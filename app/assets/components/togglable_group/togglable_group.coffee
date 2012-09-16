
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
    @target.removeClass(@toggle_classes) if @behavior == 'radio'
    activator.addClass(@toggle_classes)

  deactiveState: (e) ->
    if typeof e.target == "number"
      deactivator = $(@target[e.target])
    else
      deactivator = $(e.target).closest(@data.target)
    deactivator.removeClass(@toggle_classes) unless @behavior == 'radio' && deactivator.hasClass(@toggle_classes)

Bindable.register('togglable-group', utensil.TogglableGroup)

