
#= require utensil
#= require bindable
#= require timeslot

class utensil.Togglable
  constructor: (@el, data) ->
    @is_listening = false
    @related = null
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners() unless @trigger.on == 'manual'

  options: ->
    @toggle_classes = @data.toggle || 'active'
    @trigger = @setTriggerEventTypes(@data.trigger || 'click')
    @context = if @data.context then $(@data.context) else @el
    @lookup = @data.lookup || 'find'
    @target = @findTarget()
    @dispatcher = @el
    if @data.related then @relatedOptions()
    if @data.delay then @setDelay()
    @is_active = @target.hasClass(@toggle_classes)

  relatedOptions: ->
    @related_classes = @data.relatedToggle || @toggle_classes
    @related_context = if @data.relatedContext then $(@data.relatedContext) else $('body')
    @related_lookup = @data.relatedLookup || 'find'
    @related = @related_context[@related_lookup](@data.related)

  initialize: ->
    @activate(target:@data.activate) if @data.activate

  # PUBLIC #

  toggle: (e) ->
    e?.preventDefault() unless @data.bubble
    if @is_active then @deactivate(e) else @activate(e)

  activate: (e) ->
    @setActivate(e)

  deactivate: (e) ->
    @setDeactivate(e)

  dispose: ->
    @clearTimeout()
    @removeListeners() unless @trigger.on == 'manual'

  # PROTECTED #

  addListeners: ->
    if @trigger.on == @trigger.off
      @dispatcher.on(@trigger.on, => @toggle.apply(@, arguments))
    else
      @dispatcher.on(@trigger.on, => @activate.apply(@, arguments))
      @dispatcher.on(@trigger.off, => @deactivate.apply(@, arguments))
    @is_listening = true

  removeListeners: ->
    if @trigger.on == @trigger.off
      @dispatcher.off(@trigger.on)
    else
      @dispatcher.off(@trigger.on)
      @dispatcher.off(@trigger.off)

  setTriggerEventTypes: (trigger) ->
    if trigger == 'hover'
      return on:'mouseenter', off:'mouseleave'
    else if trigger == 'focus'
      return on:'focus', off:'blur'
    else
      return on:trigger, off:trigger

  setActivate: (e) ->
    @clearTimeout()
    @activeState(e)
    @is_active = true
    @dispatcher.trigger('togglable:activate', e)

  setDeactivate: (e) ->
    @clearTimeout()
    @deactiveState(e)
    @is_active = false
    @dispatcher.trigger('togglable:deactivate', e)

  activateWithDelay: (e) ->
    @clearTimeout()
    @timeout = setTimeout(( => @setActivate(e)), @delay.activate)

  deactivateWithDelay: (e) ->
    @clearTimeout()
    @timeout = setTimeout(( => @setDeactivate(e)), @delay.deactivate)

  activeState: (e) ->
    @target.addClass(@toggle_classes)
    if @related then @activeRelatedState()

  deactiveState: (e) ->
    @target.removeClass(@toggle_classes)
    if @related then @deactiveRelatedState()

  activeRelatedState: () ->
    @related.addClass(@related_classes)

  deactiveRelatedState: () ->
    @related.removeClass(@related_classes)

  clearTimeout: ->
    clearTimeout(@timeout) if @timeout
    @timeout = null

  setDelay: ->
    @delay = new utensil.Timeslot().getTimeslotFromData(@data.delay)
    @timeout = null
    @activate = @activateWithDelay unless @delay.activate == 0
    @deactivate = @deactivateWithDelay unless @delay.deactivate == 0

  findTarget: ->
    # see if there is a specific target and it's valid
    if @data.target
      return @el if @data.target == "this"
      target_element = @context[@lookup](@data.target)
      return target_element unless target_element.length < 1

    href = @el.attr('href')

    # if no href, only a hash tag, or href is a url
    if !href || href == "#" || href.search(/\/|\?/) != -1
      return @el

    # else href is a selector, try and find the element
    else
      href_element = @context[@lookup](href)
      return href_element unless href_element.length < 1

    # the default fall through
    return @el

Bindable.register('togglable', utensil.Togglable)

