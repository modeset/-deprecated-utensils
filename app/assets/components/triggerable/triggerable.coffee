
#= require utensil
#= require timeslot

class utensil.Triggerable
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners() unless @data.trigger == 'manual'

  options: ->
    @data.namespace = @data.namespace || 'triggerable'
    @data.trigger = @data.trigger || 'click'

  initialize: ->
    @dispatcher = @el
    @namespace = @data.namespace
    @trigger_type = @setTriggerEventTypes(@data.trigger)
    @setDelay() if @data.delay
    @is_active = false

# PUBLIC #

  toggle: (e) ->
    e?.preventDefault() unless @data.bubble
    if @is_active then @setDeactivate(e) else @setActivate(e)

  activate: (e) ->
    @clearTimeout()
    @is_active = true
    @dispatcher.trigger('triggerable:trigger', e.target)
    @dispatcher.trigger('triggerable:activate', e.target)

  deactivate: (e) ->
    @clearTimeout()
    @is_active = false
    @dispatcher.trigger('triggerable:trigger', e.target)
    @dispatcher.trigger('triggerable:deactivate', e.target)

  dispose: ->
    @clearTimeout()
    @removeListeners() unless @trigger_type.on == 'manual'

# PROTECTED #

  addListeners: ->
    if @trigger_type.on == @trigger_type.off
      @dispatcher.on(@trigger_type.on, => @toggle arguments...)
    else
      @dispatcher.on(@trigger_type.on, => @setActivate arguments...)
      @dispatcher.on(@trigger_type.off, => @setDeactivate arguments...)

  removeListeners: ->
    @dispatcher.off(@trigger_type.on)
    @dispatcher.off(@trigger_type.off) unless @trigger_type.on == @trigger_type.off

  setActivate: (e) ->
    @activate(e)

  setDeactivate: (e) ->
    @deactivate(e)

  activateWithDelay: (e) ->
    @clearTimeout()
    @timeout = setTimeout(( => @activate(e)), @delay.activate)

  deactivateWithDelay: (e) ->
    @clearTimeout()
    @timeout = setTimeout(( => @deactivate(e)), @delay.deactivate)

# INTERNAL #

  setDelay: ->
    @delay = new utensil.Timeslot().getTimeslotFromData(@data.delay)
    @timeout = null
    @setActivate = @activateWithDelay unless @delay.activate == 0
    @setDeactivate = @deactivateWithDelay unless @delay.deactivate == 0

  setTriggerEventTypes: (type) ->
    if type == 'hover'
      return on:"mouseenter.#{@namespace}", off:"mouseleave.#{@namespace}"
    else if type == 'focus'
      return on:"focus.#{@namespace}", off:"blur.#{@namespace}"
    else if type == 'manual'
      return on:type, off:type
    else
      return on:"#{type}.#{@namespace}", off:"#{type}.#{@namespace}"

  clearTimeout: ->
    clearTimeout(@timeout) if @timeout
    @timeout = null

