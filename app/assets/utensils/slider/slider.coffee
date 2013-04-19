#= require utensils/utensils
#= require utensils/cursor_hand
#= require utensils/touch_tracker
#= require utensils/math_util/get_percent_within_range

class utensils.Slider

  constructor: (@el, data) ->
    @data = $.extend({}, data, @el.data())
    @options()
    @initialize()


  options: ->
    @data.handle ?= @el.find('.slider-handle')
    @data.progress ?= @el.find('.slider-progress')
    @data.namespace ?= 'slider'
    @data.min ?= parseFloat(@data.min, 10) || 0
    @data.max ?= parseFloat(@data.max, 10) || 1
    @data.value ?= parseFloat(@data.value, 10) || 0.5


  initialize: ->
    @dispatcher = @el
    @el[0].set = (val) => @setValue(val)
    @namespace = @data.namespace
    @cursor = new utensils.CursorHand()
    @touchTracker = new utensils.MouseAndTouchTracker(@el[0], @touchCallback, false, "img div")
    @handleWidth = @data.handle.outerWidth() * 0.5
    @width = @el.innerWidth() - @handleWidth
    @setValue(@data.value)


  touchCallback: (state, touchEvent) =>
    switch state
      when utensils.MouseAndTouchTracker.state_start
        @send('focusin')
      when utensils.MouseAndTouchTracker.state_start, utensils.MouseAndTouchTracker.state_move
        @updateInterface(@touchTracker.touchcurrent.x)
        @send('change')
      when utensils.MouseAndTouchTracker.state_end
        @send('focusout')
    utensils.CursorHand.setCursorFromTouchTrackerState(@touchTracker, @cursor, state)


  setValue: (value) ->
    @value = value
    @updateInterface(utensils.MathUtil.getPercentWithinRange(@data.min, @data.max, @value) * (@width + @handleWidth))


  updateInterface: (x) ->
    x = @handleWidth if x < @handleWidth
    x = @width if x > @width
    @data.handle.css(left: x - @handleWidth)
    @data.progress?.css(width: x)
    percent = utensils.MathUtil.getPercentWithinRange(@handleWidth, @width, x)
    @value = @data.min + percent * (@data.max - @data.min)
    @data.callback?.call(@, @value)


  send: (event_type) ->
    @dispatcher.trigger("#{@namespace}:#{event_type}", {value: Math.round(@value)})


utensils.Bindable.register 'slider', utensils.Slider
