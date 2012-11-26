
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
    @activate(@index) # @activate... should be based on a passed active instance or 0

  options: ->
    @data.namespace = @data.namespace || 'carousel'
    @data.toggle = @data.toggle || 'active in'
    @data.keyboard = true unless @data.keyboard == false
    @data.paddles = @data.paddles || '.paddle-icon'

  initialize: ->
    @namespace = @data.namespace
    @toggle_classes = @data.toggle
    @keyboard = @data.keyboard

    @index = 0
    @slider = @el.find('.carousel-inner')
    @panels = @slider.find('.carousel-panel')
    @num_panels = @panels.length

    @paddles = @el.find(@data.paddles)
    @html = $('html') if @keyboard

    @initializeBeacon() if @data.autoplay == true

  initializeBeacon: ->
    duration = parseFloat((@data.duration || 5) * 1000, 10)
    cycles = parseFloat((@data.cycles || 1), 10)
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

  prev: (e) ->
    e?.preventDefault()
    @pause()
    @activate(@index - 1)

  activate: (index=0) ->
    @index = index
    @constrainIndex()
    @transition()

  pause: ->
    @beacon.pause() if @beacon && @is_autoplaying
    @is_autoplaying = false

  restart: ->
    @initializeBeacon() unless @beacon
    @is_autoplaying = true
    @next(null, true)

  dispose: ->
    @disposeBeacon()
    @removeListeners()

# PROTECTED #

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
    @setTransitions() unless @tranny_defined
    panel = @panels.eq(@index)
    @panels.removeClass(@toggle_classes)
    if @has_tranny then panel.one(@tranny_end, => @transitionEnd arguments...) else @transitionEnd()
    panel.addClass(@toggle_classes)

  transitionEnd: (e) ->
    @el.trigger("#{@namespace}:transition.end", index: @index, length: @num_panels)
    @beacon.start() if @beacon && @is_autoplaying

  paddled: (e) ->
    e?.preventDefault()
    method = $(e.target).attr('href').replace(/#/, '')
    @[method](e) if typeof @[method] == 'function'

  keyed: (e) ->
    return if (!/(37|39)/.test(e.keyCode))
    e?.preventDefault()
    @prev(e) if e.keyCode == 37
    @next(e) if e.keyCode == 39

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

utensils.Bindable.register('carousel', utensils.Carousel)

