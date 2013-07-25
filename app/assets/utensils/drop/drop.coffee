#= require utensils/utensils
#= require utensils/bindable
#= require utensils/triggerable
#= require utensils/directional

class utensils.Drop
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @activate(@data.activate) if @data.activate or typeof @data.activate is 'number'


  options: ->
    @data.namespace ?= 'drop'
    @data.toggle ?= 'active open'
    @data.placement ?= 'south'
    @data.keyboard = true unless @data.keyboard is false


  initialize: ->
    @namespace = @data.namespace
    @toggle_classes = @data.toggle
    @placement = @data.placement
    @keyboard = @data.keyboard

    @dispatcher = @setDispatcher()
    @triggerable = new utensils.Triggerable(@dispatcher, @data)
    @triggerable.stop_propagation = true


  setup: ->
    @html = $('html')
    @menu = @dispatcher.next('.menu')
    @directional = new utensils.Directional(@menu, @el, @placement, 'north south east west')
    @cardinals = @directional.getCardinals()
    @initialized = true


# PUBLIC #

  toggle: ->
    @triggerable.toggle(target: @el)


  activate: ->
    @triggerable.activate(target: @el)


  deactivate: ->
    @triggerable.deactivate(target: @el)


  dispose: ->
    return unless @triggerable
    @deactivate()
    @removeListeners()
    @triggerable.dispose()
    @triggerable = null
    @directional = null if @directional


# PROTECTED #

  addListeners: ->
    @triggerable.dispatcher.on('triggerable:activate', => @activated arguments...)
    @triggerable.dispatcher.on('triggerable:deactivate', => @deactivated arguments...)


  removeListeners: ->
    @triggerable.dispatcher.off('triggerable:activate triggerable:deactivate')


  activated: (e) ->
    @setup() unless @initialized
    @html.trigger('click.drop.document')
    @el.addClass(@toggle_classes)
    position = @directional.getPlacementAndConstrain()
    @menu.removeClass(@cardinals).addClass(position.cardinal)
    @addDocumentListener()


  deactivated: (e) ->
    @setup() unless @initialized
    @el.removeClass("#{@toggle_classes} selected")
    @el.addClass('selected') if @menu.find('.active').length
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
    return if (!/(27|38|40)/.test(e.keyCode))
    e?.preventDefault()
    e?.stopPropagation()
    return @clear() if e.keyCode is 27

    links = @menu.find('a')
    return unless links.length
    index = links.index(links.filter(':focus'))
    index -= 1 if e.keyCode is 38 and index > 0
    index += 1 if e.keyCode is 40 and index < links.length - 1
    index = 0 if !~index
    links.eq(index).focus()


# INTERNAL #

  setDispatcher: ->
    child = @el.find('.drop-toggle')
    if child.length then return child.first() else return @el


utensils.Bindable.register 'drop', utensils.Drop

