
#= require utensils/utensils
#= require utensils/detect

class utensils.Dismiss
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()

  options: ->
    @data.namespace = @data.namespace || 'dismiss'

  initialize: ->
    @namespace = @data.namespace
    @target = null

# PUBLIC #

  remove: ->
    @setTarget() unless @target
    @target.trigger("#{@namespace}:dismiss")
    if utensils.Detect.hasTransition && @target.hasClass('in')
      @target.one(utensils.Detect.transition.end, => @removeTarget arguments...)
      @target.removeClass('in')
    else
      @removeTarget()

  removeTarget: ->
    @setTarget() unless @target
    @target.trigger("#{@namespace}:dismissed")
    @target.remove()

# PROTECTED #

  addListeners: ->
    @el.one("click.#{@namespace}", => @deactivated arguments...)

  deactivated: (e) ->
    e?.preventDefault()
    @remove()

  setTarget: ->
    element = if @data.target then $(@data.target) else $(@el.attr('href'))
    return @target = element if element.length
    parent = @el.parent()
    return @target = parent if parent.hasClass('notification')
    return @target = @el

utensils.Bindable.register 'dismiss', utensils.Dismiss

# Todo:
# - Should this use Triggerable so we can tap into delay?
# - Create a separate fixture and test all possibilities
# - Abstract the "notification" on the parent, this might need to be a list
# - The "notification" should also be allowed to be passed in

