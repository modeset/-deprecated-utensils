#= require utensils/utensils
#= require utensils/bindable
#= require utensils/triggerable

class utensils.Toggle
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @activate() if @data.activate


  options: ->
    @data.namespace ?= 'toggle'
    @data.toggle ?= 'active'


  initialize: ->
    @namespace = @data.namespace
    @toggle_classes = @data.toggle
    @triggerable = new utensils.Triggerable(@el, @data)


# PUBLIC #

  toggle: ->
    @triggerable.toggle(target: @el)


  activate: ->
    @triggerable.activate(target: @el)


  deactivate: ->
    @triggerable.deactivate(target: @el)


  dispose: ->
    return unless @triggerable
    @removeListeners()
    @triggerable.dispose()
    @triggerable = null


# PROTECTED #

  addListeners: ->
    @triggerable.dispatcher.on('triggerable:activate', => @activated arguments...)
    @triggerable.dispatcher.on('triggerable:deactivate', => @deactivated arguments...)


  removeListeners: ->
    @el.off("#{@namespace}:activated #{@namespace}:deactivated")
    @triggerable.dispatcher.off('triggerable:activate triggerable:deactivate')


  activated: (e) ->
    @el.addClass(@toggle_classes)
    @el.trigger("#{@namespace}:activated", @el)


  deactivated: (e) ->
    @el.removeClass(@toggle_classes)
    @el.trigger("#{@namespace}:deactivated", @el)


utensils.Bindable.register 'toggle', utensils.Toggle

