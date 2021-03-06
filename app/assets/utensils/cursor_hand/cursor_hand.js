//= require utensils/utensils

/*
 * Requires: _cursor-grab.css
 * Adds grabby-hand cursor functionality on-demand, and handles cases for different browsers
 * Absolute paths to .cur files are needed for IE. 
 * TODO: IE might only want the .cur style def, and not want the plain css class
 */
utensils.CursorHand = function( element ){
  this.is_msie = !!navigator.userAgent.toLowerCase().match(/msie/i);
  this.element = element || document.body;
}

utensils.CursorHand.prototype.setDefault = function() {
  if( this.is_msie ) {
    this.removeClass( 'hand handCursor' );
    this.removeClass( 'handGrab handGrabCursor' );
  } else {
    this.removeClass( 'hand' );
    this.removeClass( 'handGrab' );
  }
};

utensils.CursorHand.prototype.setHand = function() {
  this.setDefault();
  if( this.is_msie ) {
    this.addClass( 'hand handCursor' );
  } else {
    this.addClass( 'hand' );
  }
};

utensils.CursorHand.prototype.setGrabHand = function() {
  this.setDefault();
  if( this.is_msie ) {
    this.addClass( 'handGrab handGrabCursor' );
  } else {
    this.addClass( 'handGrab' );
  }
};

utensils.CursorHand.prototype.addClass = function( className ) {
  if($)
    $(this.element).addClass( className );
  else
    DOMUtil.addClass( className );
};

utensils.CursorHand.prototype.removeClass = function( className ) {
  if($)
    $(this.element).removeClass( className );
  else
    DOMUtil.removeClass( className );
};

utensils.CursorHand.prototype.dispose = function(){
  this.setDefault();
  delete this.is_msie;
  delete this.element;
};

// static helper for raw MouseAndTouchTracker usage
utensils.CursorHand.setCursorFromTouchTrackerState = function( touchTracker, cursor, state ) {
  switch( state ) {
    case utensils.MouseAndTouchTracker.state_start :
      cursor.setGrabHand();
      break;
    case utensils.MouseAndTouchTracker.state_move :
      if(touchTracker.is_touching) cursor.setGrabHand();
      break;
    case utensils.MouseAndTouchTracker.state_end :
      if( touchTracker.touch_is_inside ) cursor.setHand();
      else cursor.setDefault();
      break;
    case utensils.MouseAndTouchTracker.state_enter :
      if( !touchTracker.is_touching ) cursor.setHand();
      break;
    case utensils.MouseAndTouchTracker.state_leave :
      if(touchTracker.is_touching) cursor.setGrabHand();
      else cursor.setDefault();
      break;
  }
};
