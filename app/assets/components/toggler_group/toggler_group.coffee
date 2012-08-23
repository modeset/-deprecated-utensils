
#= require namespace
#= require bindable
#= require toggler

class roos.TogglerGroup extends roos.Toggler
  constructor: (@el, data) ->
    super(@el, data)

  options: ->
    @data.target = 'li' unless @data.target
    super()
    @behavior = @data.behavior || 'radio'

  toggle: (e) =>
    e?.preventDefault() unless @data.bubble
    activator = $(e.target).closest(@data.target)
    @target.removeClass(@toggle_classes) if @behavior == 'radio'
    activator.toggleClass(@toggle_classes)

  activate: (item=0) ->
    if typeof item == "number"
      activator = $(@target[item])
    else
      activator = $(item).closest(@data.target)
    @target.removeClass(@toggle_classes) if @behavior == 'radio'
    activator.addClass(@toggle_classes)

  deactivate: (item=0) ->
    if typeof item == "number"
      deactivator = $(@target[item])
    else
      deactivator = $(item).closest(@data.target)
    deactivator.removeClass(@toggle_classes)

Bindable.register('toggler-group', roos.TogglerGroup)

