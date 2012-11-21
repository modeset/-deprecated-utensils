
//= require utensils/utensils

utensils.CSSHelper = function() {

    var _curVendor = utensils.CSSHelper.getVendorPrefix( 'Transform' );
    var _transformsEnabled = ( _curVendor != null );

    var getVendor = function() {
        return _curVendor;
    };

    var getCssTransformsEnabled = function() {
        return _transformsEnabled;
    };

    var convertToNativePositioning = function( element ) {
        _transformsEnabled = false;
        clearWebkitPositioning( element );
    };

    var convertToWebkitPositioning = function( element ) {
        _transformsEnabled = true;
        clearNativePositioning( element );
    };

    var clearNativePositioning = function( element ) {
        element.style.left = '';
        element.style.top = '';
    };

    var clearWebkitPositioning = function( element ) {
        element.style[ _curVendor + 'Transform' ] = '';
    };

    var clearWebkitTransition = function( element ) {
        // stop any previous webkit animations
        element.style[ _curVendor + 'Transition' ] = '';
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

        // since we're manually setting position, generally we're doing this on a frame loop, and should disable css transitions if true
        if( keepTransition == false ) clearWebkitTransition( element );

        if( !_transformsEnabled ) {
            // clearWebkitPositioning( element );
            element.style.left = utensils.CSSHelper.roundForCSS( x ) + 'px';
            element.style.top = utensils.CSSHelper.roundForCSS( y ) + 'px';
        } else {
            // check for android, and hardware-accelerated capable androids... this relies on android-fix.js right now... move this.
            var docClass = document.documentElement.className;
            var isAndroid = (docClass.indexOf('android') != -1);
            var notAndroid = (docClass.indexOf('no-android') != -1);
            var isAndroid4Plus = (docClass.indexOf('android4plus') != -1);
            // TODO: Make this only < Android 4 since hardware acceleration has been fixed
            if( isAndroid == true && notAndroid == false && isAndroid4Plus == false ) {
                clearWebkitPositioning( element );
                // add data attr with x/y positioning since we'll be overriding what would otherwise be additive positioning between top/left and translate3d
                if(!element.getAttribute('data-pos') ) {
                    element.setAttribute('data-pos',element.offsetLeft+','+element.offsetTop);
                }
                // pull original placement off stored data attr and add to current position
                pos = element.getAttribute('data-pos').split(',')
                x += parseInt(pos[0]);
                y += parseInt(pos[1]);
                element.style.left = utensils.CSSHelper.roundForCSS( x ) + 'px';
                element.style.top = utensils.CSSHelper.roundForCSS( y ) + 'px';
                // apply scale to inner element if we need scaling - this requires a nested element for scaling
                if( scale != 1 && element.children && element.children[0] && element.children[0].style ) {
                    element.children[0].style[ _curVendor + 'Transform' ] = buildScaleTranslateString( scale );
                }
            } else {
                element.style[ _curVendor + 'Transform' ] = buildPositionTranslateString( x, y ) + buildScaleTranslateString( scale ) + buildRotationTranslateString( rot );     // element[ _curVendor + 'Transform' ] &&
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
        convertToNativePositioning : convertToNativePositioning,
        convertToWebkitPositioning : convertToWebkitPositioning,
        setBackfaceVisbility : setBackfaceVisbility
    };
};

// this should really only be called once
utensils.CSSHelper.getVendorPrefix = function( styleSuffix ) {

    // see if the major browser vendor prefixes are detected for css transforms
    var checkVendor = function() {
        var vendors = ['Moz', 'Webkit', 'O', 'Khtml'];   // should have 'ms' also, but IE9 transform doesn't work, even though it claims to exist. bullshit.
        var element = findElementWithStyle();
        for( var vendor in vendors ) {
            if( element.style[ vendors[vendor] + styleSuffix ] !== undefined ) {
                return vendors[vendor];
            }
        }
        return null;
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
utensils.CSSHelper.findPos = function(obj) {
    // get page scroll offset
    var scrollX = window.pageXOffset ? window.pageXOffset : document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft;
    var scrollY = window.pageYOffset ? window.pageYOffset : document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop;

    // get element location
    var curleft = curtop = 0;

    if (obj.offsetParent) {
        do {
            if( obj.offsetParent && typeof obj.offsetParent.style !== 'undefined' && typeof obj.offsetParent.style[ _curVendor + 'Transform' ] !== 'undefined' && obj.offsetParent.style[ _curVendor + 'Transform' ] ) {   // last conditional fixes chrome on windows
                var transformXYZArray = obj.offsetParent.style[ _curVendor + 'Transform' ].split('translate3d(')[1].split(')')[0].replace(/ +/g, '').replace(/px+/g, '').split(',');
                curleft += parseInt( transformXYZArray[0] );
                curtop += parseInt( transformXYZArray[1] );
            }
            curleft += obj.offsetLeft;
            curtop += obj.offsetTop;
        } while (obj = obj.offsetParent);
    }

    // return position from cumulative offset
    return [ curleft - scrollX, curtop - scrollY ];
};
