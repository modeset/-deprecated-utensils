
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
    @targets = @findTargets()
    @triggerable = new utensil.Triggerable(@el, @data)

# PUBLIC #

  activate: (item) ->
    if typeof item == "number"
      activator = @targets.eq(item).find('> a')
    else if typeof item == "string"
      activator = $(item).find('> a')
    else
      activator = item.find('> a')
    activator.trigger(@triggerable.trigger_type.on)

  deactivate: (item) ->
    if typeof item == "number"
      deactivator = @targets.eq(item).find('> a')
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
    element = @targets.find(link).parent('li')
    return if element.length <= 0
    return if @behavior == 'radio' && element.hasClass(@toggle_classes)
    if @behavior == 'radio' then @radio(element) else @checkbox(element)

  # TODO: This could use some optimization
  radio: (element) ->
    @el.find('.selected').removeClass('selected')
    @targets.removeClass(@toggle_classes)
    element.addClass(@toggle_classes)
    @el.trigger("#{@namespace}:triggered", element)

  checkbox: (element) ->
    element.toggleClass(@toggle_classes)
    @el.trigger("#{@namespace}:triggered", element)

  findTargets: ->
    return @el.find("#{@data.target}:not(#{@data.ignore})")

utensil.Bindable.register('toggle-group', utensil.ToggleGroup)

