
#= require utensil
#= require bindable
#= require triggerable
#= require detect
#= require directional

class utensil.Tip
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @activate() if @data.activate

  options: ->
    @data.namespace = @data.namespace || 'tip'
    @data.trigger = @data.trigger || 'hover' unless $('html').hasClass('touch')
    @data.toggle = @data.toggle || 'active in'
    @data.placement = @data.placement || 'north'
    @data.title = @data.title || @el.attr('title') || ''
    @data.effect = @data.effect || 'fade'

  initialize: ->
    @tip = null
    @container = $('body')
    @namespace = @data.namespace
    @toggle_classes = @data.toggle
    @placement = @data.placement
    @title = @data.title
    @effect = @data.effect

    @triggerable = new utensil.Triggerable(@el, @data)
    @directional = new utensil.Directional(null, @el, @placement)
    @cardinals = @directional.getCardinals()
    @el.attr('title', '')

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
    @remove()

# PROTECTED #

  addListeners: ->
    @triggerable.dispatcher.on('triggerable:activate', => @activated arguments...)
    @triggerable.dispatcher.on('triggerable:deactivate', => @deactivated arguments...)

  removeListeners: ->
    @triggerable.dispatcher.off('triggerable:activate')
    @triggerable.dispatcher.off('triggerable:deactivate')

  activated: (e) ->
    @remove()
    @add()
    @el.addClass('selected')
    @el.trigger("#{@namespace}:activated", @el)

  deactivated: (e) ->
    if @tip && utensil.Detect.hasTransition
      @tip.one(utensil.Detect.transition.end, => @remove arguments...)
      @tip.removeClass(@toggle_classes)
    else
      @remove()
    @el.removeClass('selected')
    @el.trigger("#{@namespace}:deactivated", @el)

  add: ->
    @tip = $(@render())
    @tip.appendTo(@container)
    @directional.setElement(@tip)
    position = @directional.getPlacementAndConstrain()
    @tip.removeClass(@cardinals).addClass(position.cardinal)
    @tip.css({top: position.top, left: position.left})
    @tip.addClass(@toggle_classes)

  remove: ->
    if @tip
      @tip.remove()
      @tip = null

  render: ->
    html = """
           <div class="tip #{@placement} #{@effect}">
             <div class="tip-arrow"></div>
             <div class="tip-inner">#{@title}</div>
           </div>
           """
    return html

Bindable.register('tip', utensil.Tip)

