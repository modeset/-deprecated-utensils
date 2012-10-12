
#= require utensil
#= require bindable
#= require toggle_group

class utensil.ToggleButtonGroup extends utensil.ToggleGroup
  constructor: (@el, data) ->
    super(@el, data)

  options: ->
    @data.namespace = @data.namespace || 'toggle_button_group'
    @data.target = @data.target || 'a,button'
    super()

# PUBLIC OVERRIDES #

  activate: (item) ->
    if typeof item == "number"
      activator = @targets.eq(item)
    else if typeof item == "string"
      activator = $(item)
    else
      activator = item
    activator.trigger(@triggerable.trigger_type.on)

  deactivate: (item) ->
    if typeof item == "number"
      deactivator = @targets.eq(item)
    else if typeof item == "string"
      deactivator = $(item)
    else
      deactivator = item
    deactivator.trigger(@triggerable.trigger_type.off)

# PROTECTED OVERRIDES #

  triggered: (e, link) ->
    element = $(link)
    return if element.length <= 0
    return if @behavior == 'radio' && element.hasClass(@toggle_classes)
    if @behavior == 'radio' then @radio(element) else @checkbox(element)

utensil.Bindable.register('toggle-button-group', utensil.ToggleButtonGroup)

