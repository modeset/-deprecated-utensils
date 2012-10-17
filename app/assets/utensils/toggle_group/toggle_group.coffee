
#= require utensils/utensils
#= require utensils/bindable
#= require utensils/triggerable

class utensils.ToggleGroup
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
    @triggerable = new utensils.Triggerable(@el, @data)

# PUBLIC #

  activate: (item) ->
    selector = '> a,> button'
    if typeof item == 'number'
      @setTargets() unless @targets
      activator = @targets.eq(item).find(selector)
    else if typeof item == 'string'
      activator = $(item).find(selector)
    else
      activator = item.find(selector)
    activator.trigger(@triggerable.trigger_type.on)

  deactivate: (item) ->
    selector = '> a,button'
    if typeof item == 'number'
      @setTargets() unless @targets
      deactivator = @targets.eq(item).find(selector)
    else if typeof item == 'string'
      deactivator = $(item).find(selector)
    else
      deactivator = item.find(selector)
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
    @setTargets() unless @targets
    element = @targets.find(link).closest('a, button').parent(@data.target)
    return if element.length <= 0
    return if @behavior == 'radio' && element.hasClass(@toggle_classes)
    if @behavior == 'radio' then @radio(element) else @checkbox(element)
    @el.trigger("#{@namespace}:triggered", element)

  radio: (element) ->
    @setTargets() unless @targets
    @el.find('.selected').removeClass('selected')
    @targets.removeClass(@toggle_classes)
    element.addClass(@toggle_classes)

  checkbox: (element) ->
    element.toggleClass(@toggle_classes)

  setTargets: ->
    @targets = @el.find("#{@data.target}:not(#{@data.ignore})")

utensils.Bindable.register('toggle-group', utensils.ToggleGroup)

