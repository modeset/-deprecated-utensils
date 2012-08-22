
#= require namespace
#= require bindable

class roos.Toggler
  constructor: (el) ->
    @is_active = false
    @el = $(el)
    @options()
    @initialize()

  options: ->
    @toggle_classes = @el.data('toggle') || 'active'
    @event_type = @el.data('event') || 'click'

  initialize: ->
    @el.on(@event_type, @toggle)

  toggle: (e) =>
    @el.toggleClass(@toggle_classes)
    @is_active = !@is_active

  dispose: ->
    @el.off(@event_type, @toggle)

Bindable.register('toggler', roos.Toggler)

# Add a data attribute for who gets the toggle state (closest?)
# Add an api for add and remove rather than toggle?
# Add class on load or delay through a timer
# How to handle stateful?
# Test this cat

