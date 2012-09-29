
#= require utensil
#= require bindable
#= require togglable_group

class utensil.Menu extends utensil.TogglableGroup
  constructor: (@el, data) ->
    @html = $('html')
    super(@el, data)

  options: ->
    @keyboard = if @data.keyboard == true then true else false
    super()

  initialize: ->
    super()
    @index = @el.find(@classify(@toggle_classes)).index()
    @addKeyListeners() if @keyboard

  # PUBLIC #

  next: ->
    if @index < @target.length - 1
      @index += 1
      @activate(target: @index)

  prev: ->
    if @index > 0
      @index -= 1
      @activate(target: @index)

  activateKeys: ->
    @keyboard = true
    @addKeyListeners()

  deactivateKeys: ->
    @keyboard = false
    @removeKeyListeners()

  dispose: ->
    @removeKeyListeners() if @keyboard
    super()

  # PROTECTED #

  activateState: (e) ->
    activator = super(e)
    @index = @el.find(activator).index()

  addKeyListeners: ->
    @html.on('keydown.menu', => @keyed arguments...)

  removeKeyListeners: ->
    @html.on('keydown.menu')

  keyed: (e) ->
    return if (!/(40|38)/.test(e.keyCode))
    e.preventDefault()
    if e.keyCode == 40
      @next()
    else if e.keyCode == 38
      @prev()

Bindable.register 'menu', utensil.Menu

