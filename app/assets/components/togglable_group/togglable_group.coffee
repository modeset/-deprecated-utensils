
#= require utensil
#= require bindable
#= require togglable

class utensil.TogglableGroup extends utensil.Togglable
  constructor: (@el, data) ->
    super(@el, data)

  options: ->
    @data.target = 'li' unless @data.target
    @behavior = @data.behavior || 'radio'
    super()

  # PUBLIC #

  toggle: (e) ->
    e?.preventDefault() unless @data.bubble
    activator = $(e.target).closest(@data.target)
    if activator.hasClass(@toggle_classes) then @deactivate(e) else @activate(e)

  # PROTECTED #

  activeState: (e) ->
    if typeof e.target == "number"
      activator = $(@target[e.target])
    else
      activator = $(e.target).closest(@data.target)
    if @behavior == 'radio' then @target.removeClass(@toggle_classes)
    activator.addClass(@toggle_classes)
    if @related then @activeRelatedState(activator)
    return activator

  deactiveState: (e) ->
    if typeof e.target == "number"
      deactivator = $(@target[e.target])
    else
      deactivator = $(e.target).closest(@data.target)
    deactivator.removeClass(@toggle_classes) unless @behavior == 'radio' && deactivator.hasClass(@toggle_classes)
    if @related then @deactiveRelatedState(deactivator)
    return deactivator

  activeRelatedState: (activator) ->
    selector = activator.find('[data-target]').data('target') ||
               activator.find('[href]').attr('href')
    if selector
      element = $(selector)
      if @behavior == 'radio' then @related.removeClass(@related_classes)
      element.addClass(@related_classes)
      return element

  deactiveRelatedState: (deactivator) ->
    selector = deactivator.find('[data-target]').data('target') ||
               deactivator.find('[href]').attr('href')
    if selector
      element = $(selector)
      element.removeClass(@related_classes) unless @behavior == 'radio' && element.hasClass(@related_classes)
      return element

Bindable.register('togglable-group', utensil.TogglableGroup)

