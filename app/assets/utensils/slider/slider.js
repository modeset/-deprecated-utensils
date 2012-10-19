//= require utensils/utensils
//= require utensils/cursor_hand
//= require utensils/touch_tracker
//= require utensils/math_util/get_percent_within_range

utensils.Slider = function( el, handleEl, progressEl, updatedCallback ) {

  var _el = el,
      _handle = handleEl,
      _progress = progressEl || null,
      _callback = updatedCallback || function(){},
      _touching = false,
      _touchTracker = null,
      _cursor = new utensils.CursorHand();
  var _slideLength = 0,
      _valueMin = parseFloat(_el.getAttribute('data-min')) || 0,
      _valueMax = parseFloat(_el.getAttribute('data-max')) || 1,
      _value = parseFloat(_el.getAttribute('data-initial-value')) || 0.5;

  var init = function() {
    _touchTracker = new utensils.MouseAndTouchTracker( _el, createTouchCallback(), false, 'img div' );
    recalculateDimensions();
    setValue( _value );
  };

  var recalculateDimensions = function() {
    _slideLength = getInnerWidth( _el ) - getInnerWidth( _handle );
    if( _slideLength > 0 ) {
      var percentVal = utensils.MathUtil.getPercentWithinRange( _valueMin, _valueMax, _value );
      updateValueFromHandlePos( percentVal * _slideLength );
    }
  };

  var updateValueFromHandlePos = function( handleX ) {
    // move handle
    if( _slideLength > 0 ) {
      if( handleX < 0 ) handleX = 0;
      if( handleX > _slideLength ) handleX = _slideLength;
      _handle.style.left = handleX + 'px';
      if( _progress ) _progress.style.width = (handleX + getInnerWidth( _handle )/2) + 'px';
      // store value
      var sliderPercent = utensils.MathUtil.getPercentWithinRange( 0, _slideLength, handleX );
      _value = _valueMin + sliderPercent * ( _valueMax - _valueMin );
      _callback( _value );
    }
  };

  var value = function() {
    return _value;
  };

  var setValue = function( value ) {
    _value = value;
    if( _slideLength > 0 ) {
      var valPercent = utensils.MathUtil.getPercentWithinRange( _valueMin, _valueMax, value );
      setValueFromPercent( valPercent );
    }
  };

  var setValueFromPercent = function( percent ) {
    updateValueFromHandlePos( percent * _slideLength );
  };

  var createTouchCallback = function() {
    return function( state, touchEvent ) {
      switch( state ) {
        case utensils.MouseAndTouchTracker.state_start :
          _touching = true;
          updateValueFromHandlePos( Math.round( _touchTracker.touchcurrent.x ) );
          break;
        case utensils.MouseAndTouchTracker.state_move :
          updateValueFromHandlePos( Math.round( _touchTracker.touchcurrent.x ) );
          break;
        case utensils.MouseAndTouchTracker.state_end :
          _touching = true;
          break;
      }
      utensils.CursorHand.setCursorFromTouchTrackerState( _touchTracker, _cursor, state );
    }
  };

  var getInnerWidth = function( el ) {
    return Math.min( el.clientWidth, el.offsetWidth );
  };

  init();

  return {
    recalculateDimensions : recalculateDimensions,
    value : value,
    setValue : setValue,
    setValueFromPercent : setValueFromPercent
  }
};