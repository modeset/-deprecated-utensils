//= require utensils/utensils
//= require utensils/touch_tracker
//= require utensils/css_helper
//= require utensils/cursor_hand

/**
 * Base touch tracking on an html element
 * @requires touch_tracker.js
 * @requires cursor.js
 * @requires css_helper.js
 */
utensils.TouchScroller = function( scrollOuterEl, scrollInnerEl, options ) {
    // internal positioning & size objects
    var Size2d = function( w, h ) {
        this.w = w || 0;
        this.h = h || 0;
    };

    var Point2d = function( x, y ) {
        this.x = x || 0;
        this.y = y || 0;
    };

    var scrollerDelegateMethods = [
        'touchStart',
        'touchEnd',
        'updatePosition',
        'pageChanged',
        'handleDestination',
        'closestIndexChanged'
    ];

    // overrideable options
    var defaultOptions = {
        // physics
        lockDirectionDragPixels: 15,
        dragPastBoundsFriction: 0.2,
        bouncebackFactor: -0.2,
        nonPagedFrictionShort: 0.3,
        nonPagedFriction: 0.8,
        beyondBoundsFriction: 0.4,
        bounces: true,
        // pages & dragging
        pagedEasingFactor: 5,
        pageTurnRatio: 0.2,
        // state options
        hasCursor: true,
        hasScrollbars: true,
        isPaged: true,
        defaultOrientation: utensils.TouchScroller.HORIZONTAL,
        disabledElements: 'div img nav section article',
        // delegate
        scrollerDelegate: function(){}
    };

    // apply passed-in option overrides
    for( var key in options ){
        defaultOptions[key] = options[key];
    }

    var AXIS_X = 'x',
        AXIS_Y = 'y',
        SIZE_W = 'w',
        SIZE_H = 'h',

        // directional locking properties and state vars
        _lockDirectionDragPixels = defaultOptions.lockDirectionDragPixels,
        _dragPastBoundsFriction = defaultOptions.dragPastBoundsFriction,
        _nonPagedFrictionShort = defaultOptions.nonPagedFrictionShort,
        _nonPagedFriction = _nonPagedFrictionDefault = defaultOptions.nonPagedFriction,
        _beyondBoundsFriction = defaultOptions.beyondBoundsFriction,
        _orientation = defaultOptions.defaultOrientation,
        _bounces = defaultOptions.bounces,
        _hasLockedDragAxis = false,
        _dragLockAxis = null,
        _staysInBounds = true,
        _wasDraggedBeyondBounds = new Point2d( false, false ),

        // touch helpers
        _cursor = ( defaultOptions.hasCursor ) ? new utensils.CursorHand() : null,
        _touchTracker = null,
        _cssHelper = null,
        _scrollerDelegate = null,

        // scroll elements
        _scrollOuterEl = scrollOuterEl,
        _scrollInnerEl = scrollInnerEl,

        // positioning and css flags
        _speed = new Point2d(),
        _curPosition = new Point2d(),
        _endPosition = new Point2d(),
        _containerSize = new Size2d(),
        _contentSize = new Size2d(),
        _doesntNeedScroll = new Point2d( false, false ),

        // deal with pages
        _pagedEasingFactor = defaultOptions.pagedEasingFactor,
        _pageTurnRatio = defaultOptions.pageTurnRatio,
        _isPaged = defaultOptions.isPaged,

        _numPages = new Point2d(),
        _pageIndex = new Point2d(),
        _closestScrollIndex = new Point2d(),

        _timerFps = 16,
        _timerActive = false,

        // deal with direction of scroller
        _hasScrollBars = defaultOptions.hasScrollbars,
        _scrollbars = null,
        _axis = null,   // will be x/y for Point2d
        _scrollsX = false,
        _scrollsY = false,

        _scrollerId = '',
        _cancelClick = false,
        _publicInterface = null;

    var init = function() {
        _scrollerId = generateScrollerId();
        setScrollerDelegate( defaultOptions.scrollerDelegate );
        _cssHelper = new utensils.CSSHelper();
        _touchTracker = new utensils.MouseAndTouchTracker( scrollOuterEl, touchUpdated, false, defaultOptions.disabledElements );
        if( _hasScrollBars ) _scrollbars = new Point2d( new ScrollBar( AXIS_X, SIZE_W ), new ScrollBar( AXIS_Y, SIZE_H ) );

        setOrientation( _orientation );
        calculateDimensions();

        activate();
    };

    var touchUpdated = function( state, touchEvent ) {
        switch( state ) {
            case utensils.MouseAndTouchTracker.state_start :
                onStart(touchEvent);
                break;
            case utensils.MouseAndTouchTracker.state_move :
                onMove(touchEvent);
                break;
            case utensils.MouseAndTouchTracker.state_end :
                onEnd(touchEvent);
                break;
            case utensils.MouseAndTouchTracker.state_enter :
                onEnter(touchEvent);
                break;
            case utensils.MouseAndTouchTracker.state_leave :
                onLeave(touchEvent);
                break;
        }
        updateCursor( state );
    };

    var onStart = function( touchEvent ) {
        if( _timerActive == false ) return;
        if( utensils.TouchScroller.innermostScrollerInstance == null ) utensils.TouchScroller.innermostScrollerInstance = _publicInterface;
        _scrollerDelegate.touchStart();
        _cancelClick = false;
        _scrollOuterEl.addEventListener('click', onClicked);
    };

    var onMove = function( touchEvent ) {
        // cancel scrolling if there's an inner scroller in the same orientation
        // or if there's another scroller that's been activated in a different direction
        // or if it's shut down
        if( utensils.TouchScroller.innermostScrollerInstance != _publicInterface && ( utensils.TouchScroller.innermostScrollerInstance.getOrientation() == _orientation || _orientation == utensils.TouchScroller.UNLOCKED ) ) return;   // canceling b/c same direction as inner scroller (or outer is a grid (unlocked))
        if( utensils.TouchScroller.activeScrollerInstance != null && utensils.TouchScroller.activeScrollerInstance != _scrollerId ) return;   // canceling b/c inner scroller has been activated in a different orientation
        if( _timerActive == false ) return;

        // if normal (no inner scroller blocking this instance), show scrollbars and do normal scrolling in grid orientation
        if( _orientation == utensils.TouchScroller.UNLOCKED ) {
            showScrollbars();
            utensils.TouchScroller.activeScrollerInstance = _scrollerId;
            if( Math.abs( _touchTracker.touchmoved.x ) + Math.abs( _touchTracker.touchmoved.y ) > 10 ) _cancelClick = true;
        }

        // if we're locked to an axis, drag a bit before deciding to scroll, then preventDefault on the touch event below to allow page scrolling in the non-locked axis directino
        if( !_hasLockedDragAxis && _orientation != utensils.TouchScroller.UNLOCKED ) {
            if( Math.abs( _touchTracker.touchmoved.x ) > _lockDirectionDragPixels ) decideDragAxis( utensils.TouchScroller.HORIZONTAL );
            else if( Math.abs( _touchTracker.touchmoved.y ) > _lockDirectionDragPixels ) decideDragAxis( utensils.TouchScroller.VERTICAL );
        } else {
            // scroll once we've decided a direction
            if( _orientation == utensils.TouchScroller.UNLOCKED || ( _orientation == utensils.TouchScroller.VERTICAL && _orientation == _dragLockAxis ) || ( _orientation == utensils.TouchScroller.HORIZONTAL && _orientation == _dragLockAxis ) ) {
                updatePositionFromTouch( ( _touchTracker.touchmoved.x - _touchTracker.touchmovedlast.x ), ( _touchTracker.touchmoved.y - _touchTracker.touchmovedlast.y ) );
            }
        }
    };

    var onEnd = function( touchEvent ) {
        _scrollerDelegate.touchEnd();
        _scrollOuterEl.removeEventListener('click', onClicked);

        // reset touchscroll props after a tick
        setTimeout(function(){ 
            _hasLockedDragAxis = false;
            _dragLockAxis = null;
            _cancelClick = false;
            utensils.TouchScroller.activeScrollerInstance = null; 
            utensils.TouchScroller.innermostScrollerInstance = null;
        },1);

        if( utensils.TouchScroller.activeScrollerInstance != _scrollerId ) {
            hideScrollbars();
            return;
        } 
        if( _timerActive == false ) return;

        // store last known page index before recalculating
        var prevIndexX = _pageIndex.x;
        var prevIndexY = _pageIndex.y;

        // perform final speed/snapping functions if we're active and dragging in the right direction
        if( _orientation == utensils.TouchScroller.UNLOCKED || ( _orientation == utensils.TouchScroller.VERTICAL && _orientation == _dragLockAxis ) || ( _orientation == utensils.TouchScroller.HORIZONTAL && _orientation == _dragLockAxis ) ) {
            // get mouse speed for non-paged mode
            var speedX = ( _scrollsX ) ? getTouchSpeedForAxis( AXIS_X ) : 0;
            var speedY = ( _scrollsY ) ? getTouchSpeedForAxis( AXIS_Y ) : 0;

            if( _scrollsX ) sendBackInBounds( AXIS_X );
            if( _scrollsY ) sendBackInBounds( AXIS_Y );

            if( _scrollsX ) detectPageChangeOnTouchEnd( prevIndexX, AXIS_X );
            if( _scrollsY ) detectPageChangeOnTouchEnd( prevIndexY, AXIS_Y );
        } else {
            hideScrollbars();
        }

        // hide the scrollbar if touch was just a tap
        // if dragging against the boundaries (no toss speed), hide scroller?? hmm..
        if( _touchTracker.touchmoved.x == 0 && _touchTracker.touchmoved.y == 0 ) {
            hideScrollbars();
        }
    };

    var onClicked = function(e) {
        if( _cancelClick == true ) {
            eventPreventDefault( e );
        }
    };

    var decideDragAxis = function( direction ) {
        _hasLockedDragAxis = true;
        _dragLockAxis = direction;
        if( _orientation == _dragLockAxis ) {
            showScrollbars();
            utensils.TouchScroller.activeScrollerInstance = _scrollerId; 
            _cancelClick = true;
        }
    };

    var getTouchSpeedForAxis = function( axis ) {
        if( _touchTracker.touchspeed[ axis ] != 0 ) {
            var tossStartInBounds = ( _touchTracker.touchspeed[ axis ] > 0 && _curPosition[ axis ] < 0 );
            var tossEndInBounds = ( _touchTracker.touchspeed[ axis ] < 0 && _curPosition[ axis ] > _endPosition[ axis ] );
            _speed[ axis ] = -_touchTracker.touchspeed[ axis ];
            if( tossStartInBounds || tossEndInBounds ) {
                // apply speed after tossing if in-bounds
                return _speed[ axis ];
            } else {
                return false;
            }
        } else {
            _speed[ axis ] = 0;
        }
    };


    var onEnter = function( touchEvent ) {

    };

    var onLeave = function( touchEvent ) {

    };

    var updateCursor = function( state ) {
        if( _cursor && _timerActive ) {
            utensils.CursorHand.setCursorFromTouchTrackerState( _touchTracker, _cursor, state );
        }
    };

    var runTimer = function() {
        if( _timerActive && _curPosition ) {
            calculateDimensions();
            if( !_touchTracker.is_touching ) {
                updateWhileNotTouching();
            }

            if( _scrollsX ) checkForClosestIndex( AXIS_X, SIZE_W );
            if( _scrollsY ) checkForClosestIndex( AXIS_Y, SIZE_H );

            // keep timer running - use requestAnimationFrame if available
            if( window.requestAnimationFrame ) {
                window.requestAnimationFrame( runTimer );
            } else {
                setTimeout( function() { runTimer(); }, _timerFps );
            }
        }
    };

    var update2DPosition = function( element, x, y ){
        _cssHelper.update2DPosition( element, x, y, 1, 0, false );
    };

    var redraw = function() {
        update2DPosition( _scrollInnerEl, _curPosition.x, _curPosition.y );
        updateScrollbar();
    };

    var calculateDimensions = function() {
        if( !_timerActive || !_containerSize || !_scrollOuterEl ) return;

        var outerW = _scrollOuterEl.offsetWidth;
        var outerH = _scrollOuterEl.offsetHeight;
        var contentW = _scrollInnerEl.offsetWidth;
        var contentH = _scrollInnerEl.offsetHeight;

        if( contentW != _contentSize.w || contentH != _contentSize.h || outerW != _containerSize.w || outerH != _containerSize.h ) {
            _containerSize.w = outerW;
            _containerSize.h = outerH;
            _contentSize.w = contentW;
            _contentSize.h = contentH;
            _endPosition.x = _containerSize.w - _contentSize.w;
            _endPosition.y = _containerSize.h - _contentSize.h;
            _numPages.x = Math.ceil( _contentSize.w / _containerSize.w );
            _numPages.y = Math.ceil( _contentSize.h / _containerSize.h );
            _doesntNeedScroll.x = ( _containerSize.w > _contentSize.w );
            _doesntNeedScroll.y = ( _containerSize.h > _contentSize.h );
            if( _doesntNeedScroll.x == true ) _endPosition.x = 0;
            if( _doesntNeedScroll.y == true ) _endPosition.y = 0;
            if( _pageIndex.x > _numPages.x - 1 ) _pageIndex.x = _numPages.x - 1;
            if( _pageIndex.y > _numPages.y - 1 ) _pageIndex.y = _numPages.y - 1;
            if( _scrollsX ) sendBackInBounds( AXIS_X );
            if( _scrollsY ) sendBackInBounds( AXIS_Y );
            if( _scrollsX && _scrollbars ) _scrollbars.x.resizeScrollbar();
            if( _scrollsY && _scrollbars ) _scrollbars.y.resizeScrollbar();
        }
    };

    // update scroll position
    var updatePositionFromTouch = function( moveX, moveY ) {
        // update position for either/both axis depending on orientation mode
        ( _scrollsX ) ? updateAxisPosition( AXIS_X, moveX ) : constrainContent( AXIS_X );
        ( _scrollsY ) ? updateAxisPosition( AXIS_Y, moveY ) : constrainContent( AXIS_Y );

        // update DOM and report back
        redraw();
        updateScrollbar();
        _scrollerDelegate.updatePosition( _curPosition.x, _curPosition.y, true );
    };

    var updateAxisPosition = function( axis, axisTouchMove ) {
        // handle bounce-back and lessened swipe-ability at ends of scroll area
        if( _curPosition[ axis ] > 0 && _touchTracker.touchspeed[ axis ] > 0 ) {
            _curPosition[ axis ] += axisTouchMove * _dragPastBoundsFriction;
        } else if( _curPosition[ axis ] < _endPosition[ axis ] && _touchTracker.touchspeed[ axis ] < 0 ) {
            _curPosition[ axis ] += axisTouchMove * _dragPastBoundsFriction;
        } else {
            _curPosition[ axis ] += axisTouchMove;
        }
        if( !_bounces ) {
            if( _curPosition[ axis ] < _endPosition[ axis ] ) _curPosition[ axis ] = _endPosition[ axis ];
            if( _curPosition[ axis ] > 0 ) _curPosition[ axis ] = 0;
        }
    };

    var updateWhileNotTouching = function() {
        var curX = _curPosition.x;
        var curY = _curPosition.y;
        var isDirty = false;
        // update position and set dirty flag if the position has actually moved
        if( _isPaged == true ) {
            // ease to the cosest index while not touching
            easeToIndex();
        } else {
            // slide it and apply friction
            applyInertia();
        }
        if( curX != _curPosition.x || curY != _curPosition.y || Math.abs( _speed.x ) > 0.1 || Math.abs( _speed.y ) > 0.1 ) isDirty = true;
        // hide scrollbar and set speed to zero when it eases close enough
        if( isDirty && hasSlowedToStop( null ) ) {
            handleDestination();
            _speed.x = _speed.y = 0;
        } else {
            if( isDirty ) _scrollerDelegate.updatePosition( _curPosition.x, _curPosition.y, false );
        }
        if( isDirty ) {
            redraw();
            updateScrollbar();
        }
    }

    var hasSlowedToStop = function( axis ) {
        if( axis ) {
            return hasSlowedToStopForAxis( axis );
        } else {
            return ( hasSlowedToStopForAxis( AXIS_X ) && hasSlowedToStopForAxis( AXIS_Y ) );
        }
    };

    var hasSlowedToStopForAxis = function( axis ) {
        return (Math.abs( _speed[ axis ] ) <= 0.01);
    };

    var easeToIndex = function() {
        ( _scrollsX ) ? easeToIndexForAxis( AXIS_X, SIZE_W ) : constrainContent( AXIS_X );
        ( _scrollsY ) ? easeToIndexForAxis( AXIS_Y, SIZE_H ) : constrainContent( AXIS_Y );
    };

    var easeToIndexForAxis = function( axis, dimension ) {
        var lastLoc = _curPosition[ axis ];
        _curPosition[ axis ] = getNextEasedLocation( _pageIndex[ axis ], _curPosition[ axis ], _containerSize[ dimension ] );
        _speed[ axis ] = Math.abs( _curPosition[ axis ] - lastLoc );
    };

    var applyInertia = function() {
        ( _scrollsX ) ? applyInertiaForAxis( AXIS_X ) : constrainContent( AXIS_X );
        ( _scrollsY ) ? applyInertiaForAxis( AXIS_Y ) : constrainContent( AXIS_Y );
    };

    var applyInertiaForAxis = function( axis ) {
        _speed[ axis ] *= _nonPagedFriction;
        _curPosition[ axis ] -= _speed[ axis ];

        // reverse direction if inertia has brought the content out of bounds
        var headingOutOfBounds = ( ( _curPosition[ axis ] > 0 && _speed[ axis ] < 0 ) || ( _curPosition[ axis ] < _endPosition[ axis ] && _speed[ axis ] > 0 ) );
        if( headingOutOfBounds ) {
            if( _bounces ) {
                _speed[ axis ] *= _beyondBoundsFriction;
                if( hasSlowedToStop( axis ) ) {
                    sendBackInBounds( axis );
                }
            } else {
                _speed[ axis ] = 0;
                constrainContent( axis );
            }
        }
        // check to see if content is back in bounds after sliding off
        if ( _curPosition[ axis ] < 0 && _curPosition[ axis ] > _endPosition[ axis ] ) {
            _wasDraggedBeyondBounds[ axis ] = false;
        }
    };

    var constrainContent = function( axis ) {
        if( _curPosition[ axis ] > 0 ) _curPosition[ axis ] = 0;
        if( _curPosition[ axis ] < _endPosition[ axis ] ) _curPosition[ axis ] = _endPosition[ axis ];
    };

    var sendBackInBounds = function( axis ) {
        // calculate speed to get back to edge if content was dragged out-of-bounds
        if( _staysInBounds == true && _bounces ) {
            if( isOutOfBoundsForAxis( axis ) || _doesntNeedScroll[ axis ] ) {
                _wasDraggedBeyondBounds[ axis ] = true;
                var distanceFromEdge = 0;

                // apply speed so we can treat it as if we dragged as far as the drag speed added
                _curPosition[ axis ] -= _speed[ axis ];

                // send back to top, or bottom
                if( _curPosition[ axis ] > 0 || _doesntNeedScroll[ axis ] == true )
                  distanceFromEdge = _curPosition[ axis ];
                else if( _curPosition[ axis ] < _endPosition[ axis ] )
                  distanceFromEdge = _curPosition[ axis ] - _endPosition[ axis ];

                // solve for initial speed, given distance and friction
                if( distanceFromEdge != 0 ) {
                    _speed[ axis ] = getSpeedToReachDestination( distanceFromEdge );
                }
            }
        }
    };

    var isOutOfBoundsForAxis = function( axis ) {
        return _curPosition[ axis ] - _speed[ axis ] > 0 || _curPosition[ axis ] - _speed[ axis ] < _endPosition[ axis ];
    };

    var detectPageChangeOnTouchEnd = function( prevIndex, axis ) {
        // snap to page and constrain page calculation
        if( _isPaged == true ) {
            var dimension = getDimensionForAxis( axis );
            var prevPage = _pageIndex[ axis ];
            var pageChanged = false;
            // have we swiped far enough to turn the page
            if( _touchTracker.touchmoved[ axis ] > _containerSize[ dimension ] * _pageTurnRatio ) {
                _pageIndex[ axis ] = ( _pageIndex[ axis ] == 0 ) ? 0 : _pageIndex[ axis ] - 1;
                pageChanged = true;
            } else if ( _touchTracker.touchmoved[ axis ] < -_containerSize[ dimension ] * _pageTurnRatio ) {
                _pageIndex[ axis ] = ( _pageIndex[ axis ] < _numPages[ axis ] - 1 ) ? _pageIndex[ axis ] + 1 : _numPages[ axis ] - 1;
                pageChanged = true;
            }

            // checks whether we've gone more than halfway to a page, or allows above code to let us swipe slightly for next/prev pages
            if( !( prevIndex == _closestScrollIndex[ axis ] && prevIndex != _pageIndex[ axis ] ) ) {
                _pageIndex[ axis ] = _closestScrollIndex[ axis ];
                pageChanged = true;
            }

            if( pageChanged == true && prevPage != _pageIndex[ axis ] ) {
                _scrollerDelegate.pageChanged( _pageIndex[ axis ], axis );
            }
        }
    };

    var updateScrollbar = function() {
        if( !_scrollbars ) return;
        if( _scrollsX ) _scrollbars.x.updateScrollbarPosition( _curPosition.x );
        if( _scrollsY ) _scrollbars.y.updateScrollbarPosition( _curPosition.y );
    };

    var getNextEasedLocation = function( pageIndex, curPosition, containerSize ) {
        // get location based on current position
        var targetPos = pageIndex * -containerSize;
        if( curPosition !== targetPos ) {
            if (Math.abs( curPosition - targetPos ) <= 0.25 ) {
                curPosition = targetPos;
                handleDestination();
                return curPosition;
            }
        }
        // ease position to target
        return curPosition -= ( ( curPosition - targetPos ) / _pagedEasingFactor );
    };

    var getSpeedToReachDestination = function( distance ) {
        return distance / ( ( _nonPagedFriction ) * ( 1 / ( 1 - _nonPagedFriction ) ) );
    };

    var checkForClosestIndex = function( axis, dimension ) {
        // set closest index and update indicator
        var closestIndex = Math.round( _curPosition[ axis ] / -_containerSize[ dimension ] );
        if( _closestScrollIndex[ axis ] != closestIndex ) {
            _closestScrollIndex[ axis ] = closestIndex;
            closestIndexChanged( axis );
        }
    };

    var closestIndexChanged = function( axis ) {
        if( _closestScrollIndex[ axis ] < 0 ) _closestScrollIndex[ axis ] = 0;
        if( _closestScrollIndex[ axis ] > _numPages[ axis ] - 1 ) _closestScrollIndex[ axis ] = _numPages[ axis ] - 1;
        _scrollerDelegate.closestIndexChanged( _closestScrollIndex[ axis ], axis );
    };

    var handleDestination = function () {
        hideScrollbars();
        _curPosition.x = Math.round( _curPosition.x );
        _curPosition.y = Math.round( _curPosition.y );
        _scrollerDelegate.handleDestination();
    };

    var setOrientation = function( orientation ) {
        var prevOrientation = _orientation;
        _orientation = orientation;
        if( _orientation == utensils.TouchScroller.VERTICAL ) {
            _scrollsX = false;
            _scrollsY = true;
            _axis = AXIS_Y;
            _curPosition.y = ( _isPaged ) ? _pageIndex.y * _containerSize.h : _curPosition.x;
            _curPosition.x = 0;
            if( _isPaged ) {
                if( prevOrientation == utensils.TouchScroller.HORIZONTAL ) _pageIndex.y = _pageIndex.x;
                setPage( _pageIndex.y, true );
            }
        } else if( _orientation == utensils.TouchScroller.HORIZONTAL ) {
            _scrollsX = true;
            _scrollsY = false;
            _axis = AXIS_X;
            _curPosition.x = ( _isPaged ) ? _pageIndex.x * _containerSize.w : _curPosition.y;
            _curPosition.y = 0;
            if( _isPaged ) {
                if( prevOrientation == utensils.TouchScroller.VERTICAL ) _pageIndex.x = _pageIndex.y;
                setPage( _pageIndex.x, true );
            }
        } else {
            _scrollsX = true;
            _scrollsY = true;
            _axis = null;
        }
        calculateDimensions();
        redraw();
        if( _scrollsX && _scrollbars ) _scrollbars.x.resizeScrollbar();
        if( _scrollsY && _scrollbars ) _scrollbars.y.resizeScrollbar();
        hideScrollbars();
    };

    var getOrientation = function() {
        return _orientation;
    };

    var getDimensionForAxis = function( axis ) {
        if( axis == AXIS_X ) return SIZE_W;
        else if( axis == AXIS_Y ) return SIZE_H;
        else return null;
    };

    var setBounces = function( bounces ) {
        _bounces = bounces;
    };

    var showScrollbars = function() {
        if( !_scrollbars ) return;
        if( _scrollsX ) _scrollbars.x.showScrollbar();
        if( _scrollsY ) _scrollbars.y.showScrollbar();
    };

    var hideScrollbars = function() {
        if( !_scrollbars ) return;
        _scrollbars.x.hideScrollbar();
        _scrollbars.y.hideScrollbar();
    };

    var setIsPaged = function( isPaged ) {
        _isPaged = isPaged;
    };

    var setPage = function ( index, immediately, axis ) {
        var curAxis = ( _axis ) ? _axis : axis;
        if( !curAxis ) return;

        if( _timerActive == false ) return;
        _pageIndex[ curAxis ] = index;
        if (immediately) {
            calculateDimensions();
            var dimension = ( curAxis == AXIS_X ) ? SIZE_W : SIZE_H;
            _curPosition[ curAxis ] = _pageIndex[ curAxis ] * -_containerSize[ dimension ];
            _curPosition[ curAxis ] += 1; // makes sure it snaps back to place, given the easing/isDirty check above
        }
    };

    var getPage = function ( axis ) {
        var curAxis = ( _axis ) ? _axis : axis;
        if( !curAxis ) return;

        return ( _isPaged ) ? _pageIndex[ curAxis ] : 0;
    };

    var getNumPages = function ( axis ) {
        var curAxis = ( _axis ) ? _axis : axis;
        if( !curAxis ) return;

        return ( _isPaged ) ? _numPages[ curAxis ] : 0;
    };

    var getScrollLength = function( axis ) {
        var curAxis = ( _axis ) ? _axis : axis;
        if( !curAxis ) return -1;

        return _endPosition[ curAxis ];
    };

    var prevPage = function ( loops, immediately, axis ) {
        var curAxis = ( _axis ) ? _axis : axis;
        if( !curAxis ) return;

        if( _timerActive == false ) return;
        if( loops == true && _pageIndex[ curAxis ] == 0 )
            _pageIndex[ curAxis ] = _numPages[ curAxis ] - 1;
        else
            _pageIndex[ curAxis ] = ( _pageIndex[ curAxis ] > 0 ) ? _pageIndex[ curAxis ] - 1 : 0;
        if (immediately) _curPosition[ curAxis ] = _pageIndex[ curAxis ] * -_containerSize[ getDimensionForAxis( curAxis ) ];
        showScrollbars();
    };

    var nextPage = function ( loops, immediately, axis ) {
        var curAxis = ( _axis ) ? _axis : axis;
        if( !curAxis ) return;

        if( _timerActive == false ) return;
        if( loops == true && _pageIndex[ curAxis ] == _numPages[ curAxis ] - 1 )
            _pageIndex[ curAxis ] = 0;
        else
            _pageIndex[ curAxis ] = ( _pageIndex[ curAxis ] < _numPages[ curAxis ] - 1 ) ? _pageIndex[ curAxis ] + 1 : _numPages[ curAxis ] - 1;
        if (immediately) _curPosition[ curAxis ] = _pageIndex[ curAxis ] * -_containerSize[ getDimensionForAxis( curAxis ) ];
        showScrollbars();
    };

    var scrollToEnd = function ( immediately, axis ) {
        var curAxis = ( _axis ) ? _axis : axis;
        if( !curAxis ) return;

        var offsetToEnd = _curPosition[ curAxis ] - _endPosition[ curAxis ];
        setOffsetPosition( offsetToEnd, immediately, axis );
    };

    var scrollToTop = function ( immediately, axis ) {
        var curAxis = ( _axis ) ? _axis : axis;
        if( !curAxis ) return;

        setOffsetPosition( _curPosition[ curAxis ], immediately, axis );
    };

    var scrollToPosition = function ( position, immediately, axis ) {
        var curAxis = ( _axis ) ? _axis : axis;
        if( !curAxis ) return;

        var offsetToPosition = _curPosition[ curAxis ] - position;
        setOffsetPosition( offsetToPosition, immediately, curAxis );
    };

    var scrollToPercent = function ( percent, immediately, axis ) {
        var curAxis = ( _axis ) ? _axis : axis;
        if( !curAxis ) return;

        scrollToPosition( getScrollLength( curAxis ) * percent, immediately, curAxis );
    };

    var setOffsetPosition = function ( offsetFromCurPosition, immediately, axis ) {
        var curAxis = ( _axis ) ? _axis : axis;
        if( !curAxis ) return;

        if( immediately ) {
            _curPosition[ axis ] -= offsetFromCurPosition;
            redraw();
        } else {
            _speed[ curAxis ] = getSpeedToReachDestination( offsetFromCurPosition );
        }
        showScrollbars();
    };

    var updateOnResize = function() {
        setPage( _pageIndex.x, true, AXIS_X );
        setPage( _pageIndex.y, true, AXIS_Y );
    };

    var getCurScrollPosition = function() {
        return _curPosition[ _axis ];
    };

    var getCurScrollPercent = function() {
        return _curPosition[ _axis ] / _endPosition[ _axis ];
    };

    var setIsHardwareAcceleratedCSS = function( isAccelerated ) {
        if( isAccelerated ) {
            _cssHelper.convertToWebkitPositioning( _scrollInnerEl );
            if( !_scrollbars ) {
              _scrollbars.x.setIsHardwareAcceleratedCSS( isAccelerated );
              _scrollbars.y.setIsHardwareAcceleratedCSS( isAccelerated );
            }
        } else {
            _cssHelper.convertToNativePositioning( _scrollInnerEl );
            if( !_scrollbars ) {
              _scrollbars.x.setIsHardwareAcceleratedCSS( isAccelerated );
              _scrollbars.y.setIsHardwareAcceleratedCSS( isAccelerated );
            }
        }
        redraw();
    };

    var getIsHardwareAcceleratedCSS = function() {
        return _cssHelper.getWebKitCSSEnabled();
    };

    var setNonPagedFrictionIsShort = function( isShort ) {
        _nonPagedFriction = ( isShort ) ? _nonPagedFrictionShort : _nonPagedFrictionDefault;
    };

    var setStayInBounds = function( shouldStayInBounds ) {
      _staysInBounds = shouldStayInBounds;
      if( _staysInBounds == true ) {
        onEnd( null );  // make sure we slide back into bounds if we weren't already
      }
    };

    var setScrollerDelegate = function( delegate ){
        _scrollerDelegate = delegate;

        // monkey patch scrollerDelegate methods if undefined so there aren't any errors when called
        for( var i=0; i < scrollerDelegateMethods.length; i++ ) {
            var method = scrollerDelegateMethods[i];
            if( !_scrollerDelegate[method] ) {
                _scrollerDelegate[method] = function(){};
            }
        }

    };

    var deactivate = function() {
        _timerActive = false;
        hideScrollbars();
        if( _cursor ) _cursor.setDefault();
    };

    var activate = function() {
        if( _timerActive == false ) {
            _timerActive = true;
            runTimer();
        }
    };

    var reset = function() {
        _pageIndex.x = 0;
        _pageIndex.y = 0;
        _curPosition.x = 0;
        _curPosition.y = 0;
        redraw();
        if( !_scrollbars ) return;
        _scrollbars.x.updateScrollbarPosition( 0 );
        _scrollbars.y.updateScrollbarPosition( 0 );
    };

    var dispose = function() {
        _touchTracker.dispose();
        delete _touchTracker;

        if( _cursor ) _cursor.dispose();
        _cursor = null;
        _timerActive = false;
        _curPosition = null;
        _containerSize = null;
        _contentSize = null;

        hideScrollbars();
    };


    /* Scrollbar functionality ----------------------------- */

    var ScrollBar = function( axis, dimension ) {
        var _scroll_bar = null,
            _scroll_bar_pill = null,
            _pill_position = 0,
            _pill_length = 0,
            _container_length = 0,
            _scroll_endPosition = 0,
            _pill_overflow = 0,
            _scroll_pill_padding = 0,
            _scroll_bar_opacity = 0.5,
            _is_showing = false,
            _fade = false;

        var init = function() {
            _hasScrollBars = true;

            // create divs for scrollbar
            _scroll_bar = document.createElement('div');
            _scroll_bar.className = ( axis == AXIS_Y ) ? 'scrollbar vertical' : 'scrollbar horizontal';
            _scroll_bar_pill = document.createElement('div');
            _scroll_bar_pill.className = 'scrollbar-pill';
            _scroll_bar.appendChild(_scroll_bar_pill);
            _scrollOuterEl.appendChild(_scroll_bar);
        };

        var resizeScrollbar = function() {
            if( !_hasScrollBars ) return;

            _scroll_pill_padding = ( axis == AXIS_Y ) ? parseInt(getStyle(_scroll_bar,'padding-top')) : parseInt(getStyle(_scroll_bar,'padding-left'));
            if( isNaN( _scroll_pill_padding ) ) _scroll_pill_padding = 0;

            _container_length = ( axis == AXIS_Y ) ? _containerSize[ dimension ] : _containerSize[ dimension ];
            _container_length -= _scroll_pill_padding * 2;

            _pill_length = ( _container_length / _contentSize[ dimension ] ) * _container_length;
            _scroll_endPosition = _container_length - _pill_length;

            _scroll_bar.style.width = ( axis == AXIS_X ) ? _container_length + 'px' : '';
            _scroll_bar.style.height = ( axis == AXIS_Y ) ? _container_length + 'px' : '';

            _scroll_bar.style.marginLeft = ( axis == AXIS_X ) ? _scroll_pill_padding + 'px' : '';
            _scroll_bar.style.marginTop = ( axis == AXIS_Y ) ? _scroll_pill_padding + 'px' : '';

            updateScrollPillSize();
        };

        var updateScrollPillSize = function(){
            // check to see how far the pill has gone out-of-bounds
            _pill_overflow = 0;
            if( _pill_position < 0 ) _pill_overflow = -_pill_position;
            if( _pill_position > _scroll_endPosition ) _pill_overflow = _pill_position - _scroll_endPosition;

            // adjust pill size based on overflow
            var realPillLength = _pill_length - _pill_overflow;
            if( realPillLength > _container_length ) realPillLength = _container_length;
            if( isNaN( realPillLength ) ) realPillLength = 0;

            // update element
            _scroll_bar_pill.style.width = ( axis == AXIS_X ) ? Math.round( realPillLength ) + 'px' : '';
            _scroll_bar_pill.style.height = ( axis == AXIS_Y ) ? Math.round( realPillLength ) + 'px' : '';
        };

        var updateScrollbarPosition = function( scrollPosition ) {
            if( !_hasScrollBars ) return;
            if( _scroll_bar && _scroll_bar_pill ) {
                // calculate the position of the scrollbar, relative to scroll content
                var distanceRatio = getPercentWithinRange( 0, _endPosition[ axis ], scrollPosition );
                _pill_position = Math.round( distanceRatio * ( _container_length - _pill_length ) );

                // create temporary location in case scrollbar is out of bounds
                var displayPillPosition = ( _pill_position > 0 ) ? _pill_position : 0;

                // position the scroll bar pill
                if( axis == AXIS_Y ) {
                    update2DPosition( _scroll_bar_pill, 0, displayPillPosition );
                } else {
                    update2DPosition( _scroll_bar_pill, displayPillPosition, 0 );
                }

                // resize if dragging out of bounds
                updateScrollPillSize();
            }
        };

        var showScrollbar = function() {
            if( !_hasScrollBars || _timerActive == false || _is_showing == true || !_containerSize ) return;
            if( _containerSize[ dimension ] < _contentSize[ dimension ] || _containerSize[ dimension ] < _contentSize[ dimension ] ) {
                _is_showing = true;
                addClassName( _scroll_bar_pill, 'showing' );
            }
        };

        var hideScrollbar = function() {
            if( !_hasScrollBars || _is_showing == false ) return;
            _is_showing = false;
            removeClassName( _scroll_bar_pill, 'showing' );
        };

        var setIsHardwareAcceleratedCSS = function( isAccelerated ) {
            if( isAccelerated ) {
                _cssHelper.convertToWebkitPositioning( _scroll_bar_pill );
            } else {
                _cssHelper.convertToNativePositioning( _scroll_bar_pill );
            }
        };

        init();

        return {
            resizeScrollbar: resizeScrollbar,
            updateScrollbarPosition: updateScrollbarPosition,
            showScrollbar: showScrollbar,
            hideScrollbar: hideScrollbar,
            setIsHardwareAcceleratedCSS: setIsHardwareAcceleratedCSS
        }
    };

    // DOM/Math utility methods -------------------------------------

    var generateScrollerId = function() {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
            var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
            return v.toString(16);
        });
    };

    var eventPreventDefault = function( touchEvent ) {
        if(touchEvent && typeof touchEvent !== 'undefined' && touchEvent.preventDefault && typeof touchEvent.preventDefault !== 'undefined') touchEvent.preventDefault();
    };

    var eventStopPropa = function( touchEvent ) {
        if(touchEvent && typeof touchEvent !== 'undefined' && touchEvent.stopPropagation && typeof touchEvent.stopPropagation !== 'undefined') touchEvent.stopPropagation();
        if(touchEvent && typeof touchEvent !== 'undefined' && touchEvent.stopImmediatePropagation && typeof touchEvent.stopImmediatePropagation !== 'undefined') touchEvent.stopImmediatePropagation();
    };

    var getPercentWithinRange = function( bottomRange, topRange, valueInRange ) {
        topRange += -bottomRange;
        valueInRange += -bottomRange;
        bottomRange += -bottomRange;  // last to not break other offsets
        // return percentage or normalized values
        return ( valueInRange / ( topRange - bottomRange ) );
    };

    var getStyle = function( el, styleProp ) {
        var style;
        if ( el.currentStyle )
            style = el.currentStyle[styleProp];
        else if (window.getComputedStyle)
            style = document.defaultView.getComputedStyle(el,null).getPropertyValue(styleProp);
        return style;
    };

    var hasClassName = function(element, className) {
        var regExp = new RegExp('(?:^|\\s+)' + className + '(?:\\s+|$)');
        return regExp.test(element.className);
    };

    var addClassName = function(element, className) {
        if (!hasClassName(element, className))
            element.className = [element.className, className].join(' ');
    };

    var removeClassName = function(element, className) {
        if (hasClassName(element, className)) {
            var regExp = new RegExp('(?:^|\\s+)' + className + '(?:\\s+|$)', 'g');
            var curClasses = element.className;
            element.className = curClasses.replace(regExp, ' ');
        }
    };

    var removeElement = function( elem ) {
        if( elem && elem.parentNode ) {
            elem.parentNode.removeChild( elem );
        }
    };

    init();

    _publicInterface = {
        activate : activate,
        deactivate : deactivate,
        calculateDimensions: calculateDimensions,
        setOrientation : setOrientation,
        getOrientation : getOrientation,
        setBounces : setBounces,
        setIsPaged : setIsPaged,
        prevPage : prevPage,
        nextPage : nextPage,
        setPage : setPage,
        getPage : getPage,
        getNumPages : getNumPages,
        getScrollLength : getScrollLength,
        scrollToEnd : scrollToEnd,
        scrollToTop: scrollToTop,
        scrollToPosition : scrollToPosition,
        scrollToPercent : scrollToPercent,
        setOffsetPosition : setOffsetPosition,
        getCurScrollPosition : getCurScrollPosition,
        getCurScrollPercent : getCurScrollPercent,
        setIsHardwareAcceleratedCSS : setIsHardwareAcceleratedCSS,
        getIsHardwareAcceleratedCSS : getIsHardwareAcceleratedCSS,
        setNonPagedFrictionIsShort : setNonPagedFrictionIsShort,
        setStayInBounds : setStayInBounds,
        showScrollbars : showScrollbars,
        setScrollerDelegate : setScrollerDelegate,
        reset : reset,
        dispose : dispose
    };
    return _publicInterface;
};

utensils.TouchScroller.HORIZONTAL = 'horizontal';
utensils.TouchScroller.VERTICAL = 'vertical';
utensils.TouchScroller.UNLOCKED = null;

utensils.TouchScroller.activeScrollerInstance = null;
utensils.TouchScroller.innermostScrollerInstance = null;
