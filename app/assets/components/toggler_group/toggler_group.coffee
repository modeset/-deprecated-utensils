
#= require namespace
#= require bindable

class roos.TogglerGroup
  constructor: (el) ->
    @el = $(el)
    @options()
    @addListeners()

  options: ->
    @event_type = @el.data('event') || 'click'
    @toggle_classes = @el.data('toggle') || 'active'
    @toggle_behavior = @el.data('behavior') || 'radio'
    @activator_element = @el.data('children') || 'li'

    @kids = @el.find(@activator_element)

  addListeners: ->
    @kids.on(@event_type, @triggered)

  triggered: (e) =>
    activator = $(e.target).closest(@activator_element)
    if @toggle_behavior == 'radio'
      @kids.removeClass(@toggle_classes)
    activator.toggleClass(@toggle_classes)

Bindable.register('toggler-group', roos.TogglerGroup)

