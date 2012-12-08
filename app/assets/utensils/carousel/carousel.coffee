#= require utensils/utensils
#= require utensils/bindable
#= require utensils/detect
#= require utensils/beacon

class utensils.Carousel
  constructor:(@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @activate(@index)


  options: ->
    @data.namespace ?= 'carousel'
    @data.toggle ?= 'active in'
    @data.keyboard = true unless @data.keyboard is false
    @data.paddles ?= '.paddle-icon'


  initialize: ->
    @dispatcher = @el
    @namespace = @data.namespace
    @toggle_classes = @data.toggle
    @keyboard = @data.keyboard

    @slider = @el.find('.carousel-inner')
    @panels = @slider.find('.carousel-panel')
    @num_panels = @panels.length
    @index = @setIndex()

    @paddles = @el.find(@data.paddles)
    @html = $('html') if @keyboard

    @initializeBeacon() if @data.autoplay is true


  initializeBeacon: ->
    duration = parseFloat((@data.duration or 5) * 1000, 10)
    cycles = parseFloat((@data.cycles or 1), 10)
    total = cycles *= @num_panels
    @is_autoplaying = true
    @beacon = new utensils.Beacon(@el, {total, duration})
    @beacon.dispatcher.on("beacon:ticked", => @next arguments...)
    @beacon.dispatcher.on("beacon:finished", => @disposeBeacon arguments...)


# PUBLIC #

  next: (e, data) ->
    e?.preventDefault()
    @pause() unless data
    @activate(@index + 1)
    @send('next')


  prev: (e) ->
    e?.preventDefault()
    @pause()
    @activate(@index - 1)
    @send('prev')


  activate: (index=0) ->
    @index = index
    @constrainIndex()
    @transition()
    @send('activated')


  pause: ->
    @beacon.pause() if @beacon and @is_autoplaying
    @is_autoplaying = false
    @send('paused')


  restart: ->
    @initializeBeacon() unless @beacon
    @is_autoplaying = true
    @next null, true
    @send('restarted')


  dispose: ->
    @disposeBeacon()
    @removeListeners()
    @dispatcher.off("#{@namespace}:next #{@namespace}:prev #{@namespace}:activated #{@namespace}:paused #{@namespace}:restarted")


# PROTECTED #

  send: (event_type) ->
    @dispatcher.trigger("#{@namespace}:#{event_type}", {index: @index, total: @num_panels})


  addListeners: ->
    @html.on("keydown.#{@namespace}", => @keyed arguments...) if @keyboard
    @paddles.on("click.#{@namespace}", => @paddled arguments...) if @paddles.length


  removeListeners: ->
    @html.off("keydown.#{@namespace}") if @keyboard
    @paddles.off("click.#{@namespace}") if @paddles.length


  disposeBeacon: ->
    return unless @beacon
    @beacon.dispose()
    @beacon = null


  transition: ->
    @send('transition.start')
    @setTransitions() unless @tranny_defined
    panel = @panels.eq(@index)
    @panels.removeClass(@toggle_classes)
    if @has_tranny then panel.one(@tranny_end, => @transitionEnd arguments...) else @transitionEnd()
    panel.addClass(@toggle_classes)


  transitionEnd: (e) ->
    @send('transition.end')
    @beacon.start() if @beacon and @is_autoplaying


  paddled: (e) ->
    e?.preventDefault()
    method = $(e.target).attr('href').replace(/#/, '')
    @[method](e) if typeof @[method] is 'function'


  keyed: (e) ->
    return if (!/(37|39)/.test(e.keyCode))
    e?.preventDefault()
    @prev(e) if e.keyCode is 37
    @next(e) if e.keyCode is 39


  setSliderWidth: ->
    @slider.width("#{100 * @num_panels}%")


  setPanelWidths: ->
    @panels.width("#{100 / @num_panels}%")


# INTERNAL #

  setTransitions: ->
    @has_tranny = utensils.Detect.hasTransition
    @tranny_end = utensils.Detect.transition.end
    @tranny_defined = true


  constrainIndex: ->
    @index = 0 if @index >= @num_panels
    @index = @num_panels - 1 if @index < 0


  setIndex: ->
    index = 0
    if typeof @data.activate is 'string'
      order = @panels.index(@el.find(@data.activate))
      index = if order >= 0 then order else 0
    else if typeof @data.activate is 'number'
      index = parseFloat(@data.activate, 10)
    return index


utensils.Bindable.register 'carousel', utensils.Carousel

