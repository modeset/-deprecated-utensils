//= require utensils/utensils

utensils.MouseAndTouchTracker = function( element, callback, isMouseUpTracking, disabledElements ) {
  // positioning / tracking coordinates
  this.container_position = { x:0, y:0 };
  this.touchstart = { x : 0, y : 0 };
  this.touchcurrent = { x : 0, y : 0 };
  this.touchmovedlast = { x : 0, y : 0 };
  this.touchmoved = { x : 0, y : 0 };
  this.touchspeed = { x : 0, y : 0 };

  // state flags
  this.is_touching = false;
  this.is_touch_capable = false;
  this.has_moved = false;
  this.touch_is_inside = false;  // helps with enter/leave events

  // store parameters
  this.container = element;
  this.callback = callback;
  this.is_mouseup_tracking = isMouseUpTracking;
  disabledElements = disabledElements || '';
  this.disabled_elements = disabledElements.split(' ') || [];

  // add touch event listeners with scope for removal
  var self = this;
  this.startFunction = function(e){ self.onStart(e); };
  this.moveFunction = function(e){ self.onMove(e); if( navigator.userAgent.match(/MSIE/i) ) return false; };  // helps protect against disabled children in IE
  this.endFunction = function(e){ self.onEnd(e); };
  this.endDocumentFunction = function(e){ if( self.is_touching ) self.onEnd(e); };

  // add mouse event listeners
  if( this.container.attachEvent ) this.container.attachEvent( "onmousedown", this.startFunction ); else this.container.addEventListener( "mousedown", this.startFunction, false );
  if( this.container.attachEvent ) this.container.attachEvent( "onmouseup", this.endFunction ); else this.container.addEventListener( "mouseup", this.endFunction, false );
  if( document.attachEvent ) document.attachEvent( "onmouseup", this.endDocumentFunction ); else document.addEventListener( "mouseup", this.endDocumentFunction, false );
  if( document.attachEvent ) document.attachEvent( "onmousemove", this.moveFunction ); else document.addEventListener( "mousemove", this.moveFunction, false );

  // add touch listening (non-IE browsers)
  if( !this.container.attachEvent ) {
    this.container.addEventListener( "touchstart", this.startFunction, false );
    this.container.addEventListener( "touchend", this.endFunction, false );
    this.container.addEventListener( "touchcancel", this.endFunction, false );
    document.addEventListener( "touchmove", this.moveFunction, false );
    document.addEventListener( "touchend", this.endDocumentFunction, false );
  }

  // hmm...
  if(!navigator.userAgent.match(/Android/i)) this.recurseDisableImages( this.container ); // !this.is_mouseup_tracking &&
}

// add static constants
utensils.MouseAndTouchTracker.state_start = 'TOUCH_START';
utensils.MouseAndTouchTracker.state_move = 'TOUCH_MOVE';
utensils.MouseAndTouchTracker.state_end = 'TOUCH_END';
utensils.MouseAndTouchTracker.state_enter = 'TOUCH_ENTER';
utensils.MouseAndTouchTracker.state_leave = 'TOUCH_LEAVE';

// prevent clicking/dragging on children from interfering with container's dragging
utensils.MouseAndTouchTracker.prototype.recurseDisableImages = function ( elem ) {
  if( elem ) {
    // disable clicking/dragging on selected element types
    if( elem.tagName && this.disabled_elements.indexOf( elem.tagName.toLowerCase() ) != -1 ) {  //  console.log('disabling: = '+elem.tagName.toLowerCase());
      try {
        elem.onmousedown = function(e){ return false; };  // TODO: remove this if touch events, so we can click inside??
        elem.onselectstart = function(){ return false; };
      } catch(err) {}
    }
    // loop through children and do the same
    if( elem.childNodes.length > 0 ){
      for( var i=0; i < elem.childNodes.length; i++ ) {
        this.recurseDisableImages( elem.childNodes[i] );
      }
    }
  }
};

utensils.MouseAndTouchTracker.prototype.disposeTouchListeners = function () {
  this.container.removeEventListener( "touchstart", this.startFunction, false );
  this.container.removeEventListener( "touchend", this.endFunction, false );
  this.container.removeEventListener( "touchcancel", this.endFunction, false );
  document.removeEventListener( "touchmove", this.moveFunction, false );
  document.removeEventListener( "touchend", this.endDocumentFunction, false );
};

utensils.MouseAndTouchTracker.prototype.disposeMouseListeners = function () {
  if( this.container.attachEvent ) this.container.detachEvent( "onmousedown", this.startFunction ); else this.container.removeEventListener( "mousedown", this.startFunction, false );
  if( this.container.attachEvent ) this.container.detachEvent( "onmouseup", this.endFunction ); else this.container.removeEventListener( "mouseup", this.endFunction, false );
  if( document.attachEvent ) document.detachEvent( "onmouseup", this.endDocumentFunction ); else document.removeEventListener( "mouseup", this.endDocumentFunction, false );
  if( document.attachEvent ) document.detachEvent( "onmousemove", this.moveFunction ); else document.removeEventListener( "mousemove", this.moveFunction, false );
};

utensils.MouseAndTouchTracker.prototype.onStart = function ( touchEvent ) {
  // HACK for Android - otherwise touchmove events don't fire. See: http://code.google.com/p/android/issues/detail?id=5491
  if( navigator.userAgent.match(/Android/i) ) {
    if( touchEvent.preventDefault ) {
      touchEvent.preventDefault();  // if( touchEvent.target.tagName.toLowerCase() != 'img' ) // potential fix for the Android image menu on tap & hold
    }
  }

  // get page position of container for relative mouse/touch position
  this.findPos( this.container );

  // check for touch-capability
  if ( typeof touchEvent.touches !== 'undefined' ) {
    // set flag and remove mouse events
    this.is_touch_capable = true;
    this.disposeMouseListeners();
  }

  // get mouse/touch coordinates
  this.is_touching = true;
  this.touch_is_inside = true;
  if( !this.is_mouseup_tracking ) {
    this.touchstart.x = ( this.is_touch_capable ) ? touchEvent.touches[0].clientX : touchEvent.clientX;
    this.touchstart.y = ( this.is_touch_capable ) ? touchEvent.touches[0].clientY : touchEvent.clientY;
    this.touchstart.x -= this.container_position.x;
    this.touchstart.y -= this.container_position.y;
    this.touchcurrent.x = this.touchstart.x;
    this.touchcurrent.y = this.touchstart.y;
    this.touchmoved.x = 0;
    this.touchmoved.y = 0;
    this.touchspeed.x = 0;
    this.touchspeed.y = 0;
  }

  // callback
  this.callback && this.callback( utensils.MouseAndTouchTracker.state_start, touchEvent )
};

utensils.MouseAndTouchTracker.prototype.onMove = function ( touchEvent ) {
  // get position of holder for relative mouse/touch position
  this.findPos(this.container);

  // store last position
  this.touchmovedlast.x = this.touchmoved.x;
  this.touchmovedlast.y = this.touchmoved.y;

  //  get current position and distance moved since touch start
  this.touchcurrent.x = ( this.is_touch_capable ) ? touchEvent.touches[0].clientX : touchEvent.clientX;
  this.touchcurrent.y = ( this.is_touch_capable ) ? touchEvent.touches[0].clientY : touchEvent.clientY;
  this.touchcurrent.x -= this.container_position.x;
  this.touchcurrent.y -= this.container_position.y;
  this.touchmoved.x = this.touchcurrent.x - this.touchstart.x;
  this.touchmoved.y = this.touchcurrent.y - this.touchstart.y;

  // calculate speed between touch moves
  this.touchspeed.x = this.touchmoved.x - this.touchmovedlast.x;
  this.touchspeed.y = this.touchmoved.y - this.touchmovedlast.y;

  // pass on move event if touching, or if we're allowing tracking without needing to touch
  if( this.is_touching || this.is_mouseup_tracking )  {
    this.callback && this.callback( utensils.MouseAndTouchTracker.state_move, touchEvent );
  }

  // check for mouse in/out and make the call if it's changed
  if(this.touchcurrent.x < 0 || this.touchcurrent.x > this.container.offsetWidth || this.touchcurrent.y < 0 || this.touchcurrent.y > this.container.offsetHeight) {
    if( this.touch_is_inside ) this.onLeave();
    this.touch_is_inside = false;
  } else {
    if( !this.touch_is_inside ) this.onEnter();
    this.touch_is_inside = true;
  }
};

utensils.MouseAndTouchTracker.prototype.onEnd = function ( touchEvent ) {
  // callback before resetting all touch tracking props
  this.callback && this.callback( utensils.MouseAndTouchTracker.state_end, touchEvent );

  // reset tracking vars
  this.is_touching = false;
  if(!this.is_mouseup_tracking) {
    this.touchstart.x = this.touchstart.y = 0;
    this.touchmovedlast.x = this.touchmovedlast.y = 0;
    this.touchmoved.x = this.touchmoved.y = 0;
    this.touchspeed.x = this.touchspeed.y = 0;
  }
};

utensils.MouseAndTouchTracker.prototype.onEnter = function () {
  this.touchmoved.x = 0;
  this.touchmoved.y = 0;
  this.touchstart.x = this.touchcurrent.x;
  this.touchstart.y = this.touchcurrent.y;
  this.callback && this.callback( utensils.MouseAndTouchTracker.state_enter, null );
};

utensils.MouseAndTouchTracker.prototype.onLeave = function () {
  this.callback && this.callback( utensils.MouseAndTouchTracker.state_leave, null );
};

utensils.MouseAndTouchTracker.prototype.dispose = function () {
  if( this.is_touch_capable ) {
    this.disposeTouchListeners();
  } else {
    this.disposeMouseListeners();
  }
  // clear functions stored for event listener removal
  this.startFunction = null;
  this.moveFunction = null;
  this.endFunction = null;
  this.endDocumentFunction = null;
  // clear objects
  this.callback = false;
  this.touchstart = false;
  this.touchmovedlast = false;
  this.touchmoved = false;
};

utensils.MouseAndTouchTracker.prototype.findPos = function(obj) {
  // cobbled from:
  // http://javascript.about.com/od/browserobjectmodel/a/bom12.htm
  // http://www.quirksmode.org/js/findpos.html
  // with original code to handle webkitTransform positioning added into the mix

  // get page scroll offset
  var scrollX = window.pageXOffset ? window.pageXOffset : document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft;
  var scrollY = window.pageYOffset ? window.pageYOffset : document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop;

  // get element location
  var curleft = curtop = 0;

  if (obj.offsetParent) {
    do {
      if( typeof obj.parentNode.style !== 'undefined' && typeof obj.parentNode.style.webkitTransform !== 'undefined' && obj.parentNode.style.webkitTransform && obj.parentNode.style.webkitTransform.indexOf('translate3d') != -1 ) {   // last conditional fixes chrome on windows
        var transformXYZArray = obj.parentNode.style.webkitTransform.split('translate3d(')[1].split(')')[0].replace(/ +/g, '').replace(/px+/g, '').split(',');
        curleft += parseInt( transformXYZArray[0] );
        curtop += parseInt( transformXYZArray[1] );
      }
      curleft += obj.offsetLeft;
      curtop += obj.offsetTop;
    } while (obj = obj.offsetParent);
  }
  // store position from cumulative offset
  this.container_position.x = curleft - scrollX;
  this.container_position.y = curtop - scrollY;
};