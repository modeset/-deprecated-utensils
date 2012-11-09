
#= require utensils/utensils
#= require utensils/bindable
#= require utensils/triggerable
#= require utensils/detect
#= require utensils/directional

class utensils.Pop
  constructor: (@el, data) ->
    @is_tip_like = if @el.data('content') then true else false
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @activate() if @data.activate

  options: ->
    @data.namespace = @data.namespace || 'pop'
    @data.toggle = @data.toggle || 'active in'
    @data.placement = @data.placement || 'north'
    @data.title = @data.title || @el.attr('title') || ''
    @data.content = @data.content || ''
    @data.effect = @data.effect || 'fade'

  initialize: ->
    @pop = null
    @cached_markup = null
    @container = null
    @namespace = @data.namespace
    @toggle_classes = @data.toggle
    @placement = @data.placement
    @title = @data.title
    @content = @data.content
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
    @remove()

# PROTECTED #

  addListeners: ->
    @triggerable.dispatcher.on('triggerable:activate', => @activated arguments...)
    @triggerable.dispatcher.on('triggerable:deactivate', => @deactivated arguments...)

  removeListeners: ->
    @triggerable.dispatcher.off('triggerable:activate')
    @triggerable.dispatcher.off('triggerable:deactivate')

  activated: (e) ->
    @setup() unless @initialized
    @remove()
    @cached_markup = @cached_markup || @findMarkup()
    @add()
    @el.addClass('selected')
    @el.trigger("#{@namespace}:activated", @el)

  deactivated: (e) ->
    @setup() unless @initialized
    if @pop && utensils.Detect.hasTransition
      @pop.one(utensils.Detect.transition.end, => @remove arguments...)
      @pop.removeClass(@toggle_classes)
    else
      @remove()
    @el.removeClass('selected')
    @el.trigger("#{@namespace}:deactivated", @el)

  add: ->
    @setup() unless @initialized
    @pop = @cached_markup
    @container = @container || $('body')
    @pop.appendTo(@container)
    @directional.setElement(@pop)
    position = @directional.getPlacementAndConstrain()
    @pop.removeClass(@cardinals).addClass(position.cardinal)
    @pop.css({top: position.top, left: position.left})
    @pop.addClass(@toggle_classes)

  remove: ->
    if @pop
      @pop.remove()
      @pop = null

  render: ->
    html = """
           <div class="pop #{@placement} #{@effect}">
             <div class="pop-arrow"></div>
             <div class="pop-inner">
               <div class="pop-header">#{@title}</div>
               <div class="pop-content">
                 <p>#{@content}</p>
               </div>
             </div>
           </div>
           """
    return html

# INTERNAL #

  findMarkup: ->
    pop_markup = ''
    if @is_tip_like
      pop_markup = $(@render())
      if @title == ''
        pop_markup.find('.pop-header').remove()
        pop_markup.addClass('pop-no-header')
    else
      target = $(@el.data('target') || @el.attr('href'))
      pop_markup = $(target.html())
      target.remove()
    return pop_markup

utensils.Bindable.register('pop', utensils.Pop)

