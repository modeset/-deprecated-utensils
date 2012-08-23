
#= require namespace
#= require bindable

# - Add class on load or delay through a timer
# - Figure out why the toggle tests aren't working (behavior works though)

class roos.Toggler
  constructor: (@el, data) ->
    @is_active = false
    @data = if data then data else @el.data()
    @options()
    @addListeners()

  options: ->
    @toggle_classes = @data.toggle || 'active'
    @event_type = @data.event || 'click'
    @lookup = @data.lookup || 'find'
    @target = @getTarget()
    @dual_toggle = @target != @el && !@data.solo

  getTarget: ->
    # see if there is a specific target and it's valid
    if @data.target
      target_element = @el[@lookup](@data.target)
      return target_element unless target_element.length < 1

    href = @el.attr('href')

    # if no href, user wants @el, only a hash tag, or href is a url
    if !href || href == "#this" || href == "#" || href.search(/\/|\?/) != -1
      return @el

    # else href is a selector, try and find the element
    else
      href_element = @el[@lookup](href)
      return href_element unless href_element.length < 1

    # the default fall through
    return @el

  addListeners: ->
    @el.on(@event_type, @toggle)

  toggle: (e) =>
    e?.preventDefault() unless @data.bubble
    @target.toggleClass(@toggle_classes)
    @el.toggleClass(@toggle_classes) if @dual_toggle
    @is_active = !@is_active

  activate: ->
    @target.addClass(@toggle_classes)
    @el.addClass(@toggle_classes) if @dual_toggle
    @is_active = true

  deactivate: ->
    @target.removeClass(@toggle_classes)
    @el.removeClass(@toggle_classes) if @dual_toggle
    @is_active = false

  dispose: ->
    @el.off(@event_type, @toggle)


Bindable.register('toggler', roos.Toggler)

