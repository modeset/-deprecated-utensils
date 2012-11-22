
#= require utensils/utensils
#= require utensils/bindable
#= require utensils/triggerable
#= require utensils/detect

class utensils.Dismiss
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @autoDismiss(parseInt(@data.autoDismiss, 10)) if @data.autoDismiss

  options: ->
    @data.namespace = @data.namespace || 'dismiss'
    @data.parents = @data.parents || '.notification, .dismiss'

  initialize: ->
    @namespace = @data.namespace
    @parent_classes = @data.parents
    @target = null
    @timeout = null
    @triggerable = new utensils.Triggerable(@el, @data)

# PUBLIC #

  remove: ->
    @clearTimeout() if @timeout
    @setTarget() unless @target
    @target.trigger("#{@namespace}:dismiss")
    if utensils.Detect.hasTransition && @target.hasClass('in')
      @target.one(utensils.Detect.transition.end, => @removeTarget arguments...)
      @target.removeClass('in')
    else
      @removeTarget()

  removeTarget: ->
    @clearTimeout() if @timeout
    @setTarget() unless @target
    @target.trigger("#{@namespace}:dismissed")
    @target.off("#{@namespace}:dismiss #{@namespace}:dismissed")
    @target.remove()
    @dispose()

  dispose: ->
    return unless @triggerable
    @clearTimeout() if @timeout
    @removeListeners()
    @triggerable.dispose()
    @triggerable = null

# PROTECTED #

  addListeners: ->
    @triggerable.dispatcher.on("triggerable:trigger", => @deactivated arguments...)

  removeListeners: ->
    @triggerable.dispatcher.off("triggerable:trigger")

  deactivated: (e) ->
    e?.preventDefault()
    @remove()

  autoDismiss: (time) ->
    @timeout = setTimeout(( => @remove()), time)

  clearTimeout: ->
    clearTimeout(@timeout)
    @timeout = null

  setTarget: ->
    element = if @data.target then $(@data.target) else $(@el.attr('href'))
    return @target = element if element.length
    parent = @el.parents(@parent_classes)
    return @target = parent if parent.length
    return @target = @el

utensils.Bindable.register('dismiss', utensils.Dismiss)

