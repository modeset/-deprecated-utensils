
#= require utensil
#= require bindable
#= require triggerable

class utensil.ToggleGroup
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @activate(@data.activate) if @data.activate

  options: ->
    @data.namespace = @data.namespace || 'toggle_group'
    @data.toggle = @data.toggle || 'active'
    @data.behavior = @data.behavior || 'radio'
    @data.target = @data.target || 'li'
    @data.ignore = @data.ignore || '.group-ignore,.drop'

  initialize: ->
    @namespace = @data.namespace
    @toggle_classes = @data.toggle
    @behavior = @data.behavior
    @targets = null
    @triggerable = new utensil.Triggerable(@el, @data)

# PUBLIC #

  activate: (item) ->
    if typeof item == "number"
      activator = @findTargets().eq(item).find('> a')
    else if typeof item == "string"
      activator = $(item).find('> a')
    else
      activator = item.find('> a')
    activator.trigger(@triggerable.trigger_type.on)

  deactivate: (item) ->
    if typeof item == "number"
      deactivator = @findTargets().eq(item).find('> a')
    else if typeof item == "string"
      deactivator = $(item).find('> a')
    else
      deactivator = item.find('> a')
    deactivator.trigger(@triggerable.trigger_type.off)

  dispose: ->
    @removeListeners()
    @triggerable.dispose()
    @triggerable = null

# PROTECTED #

  addListeners: ->
    @triggerable.dispatcher.on('triggerable:trigger', => @triggered arguments...)

  removeListeners: ->
    @triggerable.dispatcher.off('triggerable:trigger')

  triggered: (e, link) ->
    element = @findTargets().find(link).parent('li')
    return if element.length <= 0
    return if @behavior == 'radio' && element.hasClass(@toggle_classes)
    if @behavior == 'radio' then @radio(element) else @checkbox(element)
    @el.trigger("#{@namespace}:triggered", element)

  radio: (element) ->
    @el.find('.selected').removeClass('selected')
    @findTargets().removeClass(@toggle_classes)
    element.addClass(@toggle_classes)

  checkbox: (element) ->
    element.toggleClass(@toggle_classes)

  findTargets: ->
    return @targets if @targets
    @targets = @el.find("#{@data.target}:not(#{@data.ignore})")
    return @targets

utensil.Bindable.register('toggle-group', utensil.ToggleGroup)

