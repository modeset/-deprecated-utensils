
#= require utensil
#= require bindable
#= require triggerable

class utensil.Toggle
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @activate() if @data.activate

  options: ->
    @data.namespace = @data.namespace || 'toggle'
    @data.toggle = @data.toggle || 'active'

  initialize: ->
    @namespace = @data.namespace
    @toggle_classes = @data.toggle
    @triggerable = new utensil.Triggerable(@el, @data)

# PUBLIC #

  toggle: ->
    @triggerable.toggle(target: @el)

  activate: ->
    @triggerable.activate(target: @el)

  deactivate: ->
    @triggerable.deactivate(target: @el)

  dispose: ->
    @removeListeners()
    @triggerable.dispose()
    @triggerable = null

# PROTECTED #

  addListeners: ->
    @triggerable.dispatcher.on('triggerable:activate', => @activated arguments...)
    @triggerable.dispatcher.on('triggerable:deactivate', => @deactivated arguments...)

  removeListeners: ->
    @triggerable.dispatcher.off('triggerable:activate')
    @triggerable.dispatcher.off('triggerable:deactivate')

  activated: (e) ->
    @el.addClass(@toggle_classes)
    @el.trigger("#{@namespace}:activated", @el)

  deactivated: (e) ->
    @el.removeClass(@toggle_classes)
    @el.trigger("#{@namespace}:deactivated", @el)

Bindable.register('toggle', utensil.Toggle)

