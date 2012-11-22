
#= require utensils/utensils
#= require utensils/bindable
#= require utensils/triggerable
#= require utensils/detect
#= require utensils/directional

class utensils.Tip
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @activate() if @data.activate

  options: ->
    @data.namespace = @data.namespace || 'tip'
    @data.trigger = @data.trigger || 'hover'
    @data.toggle = @data.toggle || 'active in'
    @data.placement = @data.placement || 'north'
    @data.title = @data.title || @el.attr('title') || ''
    @data.effect = @data.effect || 'fade'

  initialize: ->
    @tip = null
    @container = null
    @cached_markup = null
    @namespace = @data.namespace
    @toggle_classes = @data.toggle
    @placement = @data.placement
    @title = @data.title
    @effect = @data.effect
    @triggerable = new utensils.Triggerable(@el, @data)
    @el.attr('title', '')

  setup: ->
    @initialized = true
    @directional = new utensils.Directional(null, @el, @placement)
    @cardinals = @directional.getCardinals()

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
    @directional = null if @directional
    @remove()

# PROTECTED #

  addListeners: ->
    @triggerable.dispatcher.on('triggerable:activate', => @activated arguments...)
    @triggerable.dispatcher.on('triggerable:deactivate', => @deactivated arguments...)

  removeListeners: ->
    @el.off("#{@namespace}:activated #{@namespace}:deactivated")
    @triggerable.dispatcher.off('triggerable:activate')
    @triggerable.dispatcher.off('triggerable:deactivate')

  activated: (e) ->
    @setup() unless @initialized
    @remove()
    @add()
    @el.addClass('selected')
    @el.trigger("#{@namespace}:activated", @el)

  deactivated: (e) ->
    @setup() unless @initialized
    if @tip && utensils.Detect.hasTransition
      @tip.one(utensils.Detect.transition.end, => @remove arguments...)
      @tip.removeClass(@toggle_classes)
    else
      @remove()
    @el.removeClass('selected')
    @el.trigger("#{@namespace}:deactivated", @el)

  add: ->
    @setup() unless @initialized
    @cached_markup = @cached_markup || @render()
    @tip = @cached_markup
    @container = @container || $('body')
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
    return $(html)

utensils.Bindable.register('tip', utensils.Tip)

