//= require utensils/utensils

utensils.CSSHelper = function() {

  var _curVendor = utensils.CSSHelper.getVendorPrefix( 'Transform' );
  var _transformsEnabled = ( _curVendor != null );
  var _transformString = _curVendor + 'Transform';
  utensils.CSSHelper.transformString = _curVendor + 'Transform';
  var _transitionString = _curVendor + 'Transition';
  var _isPreAndroid4 = ( navigator.userAgent.toLowerCase().match(/android 2/i) || navigator.userAgent.toLowerCase().match(/android 3/i) ) ? true : false;
  
  var getVendor = function() {
    return _curVendor;
  };

  var getCssTransformsEnabled = function() {
    return _transformsEnabled;
  };

  var clearNativePositioning = function( element ) {
    element.style.left = '';
    element.style.top = '';
  };

  var clearTransformPositioning = function( element ) {
    element.style[ _transformString ] = '';
  };

  var clearCssTransition = function( element ) {
    element.style[ _transitionString ] = '';
  };

  var setBackfaceVisbility = function( element, hidden ) {
    hidden = hidden || 'hidden';
    element.style.backfaceVisibility = 'hidden';
    element.style[ _curVendor + 'BackfaceVisibility' ] = 'hidden';
  };

  // update css based on webkit positioning, or standard top/left css
  var update2DPosition = function ( element, x, y, scale, rot, keepTransition ) {
    if( !element ) return;
    if( keepTransition != true ) keepTransition = false;
    scale = scale || 1;
    rot = rot || 0;

    // since we're manually setting position, generally we're doing this in a frame loop, and should disable css transitions if true
    if( keepTransition == false ) clearCssTransition( element );

    if( !_transformsEnabled ) {
      // move element by top/left if transitions aren't supported
      element.style.left = utensils.CSSHelper.roundForCSS( x ) + 'px';
      element.style.top = utensils.CSSHelper.roundForCSS( y ) + 'px';
      element.style.zoom = scale;
    } else {
      // check for non-hardware-acceleration-capable androids - hardware acceleration has been fixed at 4.0+
      if( _isPreAndroid4 == true ) {
        clearTransformPositioning( element );
        // add data attr with x/y positioning since we'll be overriding what would otherwise be additive positioning between top/left and translate3d
        if(!element.getAttribute('data-pos') ) {
          element.setAttribute('data-pos',element.offsetLeft+','+element.offsetTop);
        }
        // pull original placement off stored data attr and add to current position
        pos = element.getAttribute('data-pos').split(',');
        x += parseInt(pos[0]);
        y += parseInt(pos[1]);
        element.style.left = utensils.CSSHelper.roundForCSS( x ) + 'px';
        element.style.top = utensils.CSSHelper.roundForCSS( y ) + 'px';

        // apply scale to inner element if we need scaling - this requires a nested element for scaling
        if( scale != 1 && element.children && element.children[0] && element.children[0].style ) {
          element.children[0].style[ _transformString ] = buildScaleTranslateString( scale );
        }
      } else {
        element.style[ _transformString ] = buildPositionTranslateString( x, y ) + buildScaleTranslateString( scale ) + buildRotationTranslateString( rot );   // element[ _transformString ] &&
      }
    }
  };

  var buildPositionTranslateString = function( x, y ) {
    return " translate3d( " + utensils.CSSHelper.roundForCSS( x ) + "px, " + utensils.CSSHelper.roundForCSS( y ) + "px, 0px )";
  };

  var buildScaleTranslateString = function( deg ) {
    return " scale( " + utensils.CSSHelper.roundForCSS( deg ) + " )";
  };

  var buildRotationTranslateString = function( deg ) {
    return " rotate( " + utensils.CSSHelper.roundForCSS( deg ) + "deg )";
  };

  return {
    update2DPosition : update2DPosition,
    getVendor: getVendor,
    getCssTransformsEnabled : getCssTransformsEnabled,
    setBackfaceVisbility : setBackfaceVisbility
  };
};

// this should really only be called once
utensils.CSSHelper.getVendorPrefix = function( styleSuffix ) {

  // see if the major browser vendor prefixes are detected for css transforms
  var checkVendor = function() {
    if(!navigator.userAgent.toLowerCase().match(/msie 9/i)){
      var vendors = ['Moz', 'Webkit'];  // should have 'ms' also, but IE9 transform doesn't work, even though it claims to exist. so, we leave it out
      var element = findElementWithStyle();
      for( var vendor in vendors ) {
        if( element.style[ vendors[vendor] + styleSuffix ] !== undefined ) {
          return vendors[vendor];
        }
      }
      return null;
    }
  };

  // find & return a legit element with style
  var findElementWithStyle = function () {
    var bodyChildren = document.body.childNodes;
    for( var child in bodyChildren ) {
      if( typeof bodyChildren[child].style !== 'undefined' ) {
        return bodyChildren[child];
      }
    }
  }

  return checkVendor();
};

// round down to 2 decimel places for smaller css strings
utensils.CSSHelper.roundForCSS = function( number ) {
  var multiplier = Math.pow( 10, 2 );
  return Math.round( number * multiplier ) / multiplier;
};

// find the location of an element on the page, taking into consideration either native left/top or CSS transform positioning, and page scroll offset
// cobbled from:
// http://javascript.about.com/od/browserobjectmodel/a/bom12.htm
// http://www.quirksmode.org/js/findpos.html
// with original code to handle webkitTransform positioning added into the mix
utensils.CSSHelper.posArray = [0,0]; // reuse to avoid creating new objects
utensils.CSSHelper.findPos = function(obj) {
  // get page scroll offset
  var scrollX = window.pageXOffset ? window.pageXOffset : document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft;
  var scrollY = window.pageYOffset ? window.pageYOffset : document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop;

  // get element location
  var curleft = curtop = 0;

  if (obj.offsetParent) {
    do {
      // add up css transform: translate3d positioning
      if( obj.offsetParent && typeof obj.offsetParent.style !== 'undefined' && typeof obj.offsetParent.style[ utensils.CSSHelper.transformString ] !== 'undefined' && obj.offsetParent.style[ utensils.CSSHelper.transformString ] ) {  // last conditional fixes chrome on windows
        var transformXYZArray = obj.offsetParent.style[ utensils.CSSHelper.transformString ].split('translate3d(')[1].split(')')[0].replace(/ +/g, '').replace(/px+/g, '').split(',');
        curleft += parseInt( transformXYZArray[0] );
        curtop += parseInt( transformXYZArray[1] );
      }
      // add normal positioning offset
      curleft += obj.offsetLeft;
      curtop += obj.offsetTop;
    } while (obj = obj.offsetParent);
  }

  // return position from cumulative offset
  utensils.CSSHelper.posArray[0] = curleft - scrollX;
  utensils.CSSHelper.posArray[1] = curtop - scrollY;
  return utensils.CSSHelper.posArray;
};
