
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

    @triggerable = new utensils.Triggerable(@dispatcher, @data)
    @triggerable.stop_propagation = true
    @directional = new utensils.Directional(@menu, @el, @placement)
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
    return if (!/(27|38|40)/.test(e.keyCode))
    e?.preventDefault()
    e?.stopPropagation()
    return @clear() if e.keyCode == 27

    links = @menu.find('a')
    return unless links.length
    index = links.index(links.filter(':focus'))
    index -= 1 if e.keyCode == 38 && index > 0
    index += 1 if e.keyCode == 40 && index < links.length - 1
    index = 0 if !~index
    links.eq(index).focus()


# INTERNAL #

  findDispatcher: ->
    child = @el.find('.drop-toggle')
    if child.length > 0 then return child.first() else return @el

utensils.Bindable.register('drop', utensils.Drop)

