
#= require utensil
#= require bindable
#= require triggerable
#= require directional

class utensil.Drop
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @activate() if @data.activate

  options: ->
    @data.namespace = @data.namespace || 'drop'
    @data.trigger = @data.trigger || 'click'
    @data.toggle = @data.toggle || 'active open'
    @data.placement = @data.placement || 'south'
    @data.keyboard = true unless @data.keyboard == false

  initialize: ->
    @html = $('html')
    @dispatcher = @findDispatcher()
    @menu = @dispatcher.next('.menu')
    @namespace = @data.namespace
    @toggle_classes = @data.toggle
    @placement = @data.placement
    @keyboard = @data.keyboard unless @html.hasClass('touch')

    @triggerable = new utensil.Triggerable(@dispatcher, @data)
    @triggerable.stop_propagation = true
    @directional = new utensil.Directional(@menu, @el, @placement)
    @cardinals = @directional.getCardinals()

# PUBLIC #

  toggle: ->
    @triggerable.toggle(target: @el)

  activate: ->
    @triggerable.activate(target: @el)

  deactivate: ->
    @triggerable.deactivate(target: @el)

  dispose: ->
    @deactivate()
    @removeListeners()
    @triggerable.dispose()
    @triggerable = null

# PROTECTED #

  addListeners: ->
    @triggerable.dispatcher.on('triggerable:activate', => @activated arguments...)
    @triggerable.dispatcher.on('triggerable:deactivate', => @deactivated arguments...)

  removeListeners: ->
    @triggerable.dispatcher.off('triggerable:activate')
    @triggerable.dispatcher.off('triggerable:deactivate')

  activated: (e) ->
    @html.trigger('click.drop.document')
    @el.addClass(@toggle_classes)
    position = @directional.getPlacementAndConstrain()
    @menu.removeClass(@cardinals).addClass(position.cardinal)
    @addDocumentListener()
    @dispatcher.focus()

  deactivated: (e) ->
    @el.removeClass("#{@toggle_classes} selected")
    @el.addClass('selected') if @menu.find('.active').length > 0
    @removeDocumentListener()

  addDocumentListener: ->
    @html.on('click.drop.document', => @clear arguments...)
    @html.on('keydown.drop.menu', => @keyed arguments...) if @keyboard

  removeDocumentListener: ->
    @html.off('click.drop.document')
    @html.off('keydown.drop.menu') if @keyboard

  clear: (e) ->
    @deactivate()
    @removeDocumentListener()

  keyed: (e) ->
    return if (!/(27)/.test(e.keyCode))
    e?.preventDefault()
    e?.stopPropagation()
    if e.keyCode == 27 then return @clear()

# INTERNAL #

  findDispatcher: ->
    child = @el.find('.drop-toggle')
    if child.length > 0 then return child.first() else return @el

Bindable.register('drop', utensil.Drop)

