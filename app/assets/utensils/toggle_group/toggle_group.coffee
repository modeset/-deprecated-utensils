
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
    target_type = if @data.bindable == 'toggle-button-group' then 'a,button' else 'li'
    @data.namespace = @data.namespace || 'toggle_group'
    @data.toggle = @data.toggle || 'active'
    @data.behavior = @data.behavior || 'radio'
    @data.target = @data.target || target_type
    @data.ignore = @data.ignore || '.group-ignore,.drop'

  initialize: ->
    @namespace = @data.namespace
    @toggle_classes = @data.toggle
    @behavior = @data.behavior
    @targets = null
    @triggerable = new utensils.Triggerable(@el, @data)

# PUBLIC #

  activate: (item) ->
    activator = @findElementFromType(item)
    activator.trigger(@triggerable.trigger_type.on)

  deactivate: (item) ->
    deactivator = @findElementFromType(item)
    deactivator.trigger(@triggerable.trigger_type.off)

  dispose: ->
    return unless @triggerable
    @removeListeners()
    @triggerable.dispose()
    @triggerable = null

# PROTECTED #

  addListeners: ->
    @triggerable.dispatcher.on('triggerable:trigger', => @triggered arguments...)

  removeListeners: ->
    @triggerable.dispatcher.off('triggerable:trigger')

  triggered: (e, target) ->
    @setTargets() unless @targets
    element = $(target).closest("#{@data.target}:not(#{@data.ignore})", @targets)
    return if !element.length || @behavior == 'radio' && element.hasClass(@toggle_classes)
    if @behavior == 'radio' then @radio(element) else @checkbox(element)
    @el.trigger("#{@namespace}:triggered", element)

  radio: (element) ->
    @setTargets() unless @targets
    @el.find('.selected').removeClass('selected')
    @targets.removeClass(@toggle_classes)
    element.addClass(@toggle_classes)

  checkbox: (element) ->
    element.toggleClass(@toggle_classes)

# INTERNAL #

  setTargets: ->
    @targets = @el.find("#{@data.target}:not(#{@data.ignore})")

  findElementFromType: (item) ->
    if typeof item == 'number'
      return @findElementByIndex(item)
    else if typeof item == 'string'
      return @findElementByString(item)
    return @findElementBySelector(item)

  findElementByIndex: (index) ->
    @setTargets() unless @targets
    element = @targets.eq(index).find('a, button')
    if element.length then return element else return @targets.eq(index)

  findElementByString: (value) ->
    element = @el.find(value).find('a, button')
    if element.length then return element else return @el.find(value)

  findElementBySelector: (selector) ->
    element = selector.find('a, button')
    if element.length then return element else return selector

utensils.Bindable.register('toggle-group', utensils.ToggleGroup)
utensils.Bindable.register('toggle-button-group', utensils.ToggleGroup)

