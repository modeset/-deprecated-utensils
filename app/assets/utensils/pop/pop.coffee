
#= require utensils/utensils
#= require utensils/bindable
#= require utensils/triggerable
#= require utensils/detect
#= require utensils/directional

class utensils.Pop
  constructor: (@el, data) ->
    @is_tip_like = if @el.data('content') then true else false
    @data = if data then data else @findData()
    @options()
    @initialize()
    @addListeners()
    @activate() if @data.activate

  options: ->
    @data.namespace = @data.namespace || 'pop'
    @data.trigger = @data.trigger || 'click'
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
    @directional = new utensils.Directional(null, @el, @placement)
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
    @cached_markup = @cached_markup || @findMarkup()
    @add()
    @el.addClass('selected')
    @el.trigger("#{@namespace}:activated", @el)

  deactivated: (e) ->
    if @pop && utensils.Detect.hasTransition
      @pop.one(utensils.Detect.transition.end, => @remove arguments...)
      @pop.removeClass(@toggle_classes)
    else
      @remove()
    @el.removeClass('selected')
    @el.trigger("#{@namespace}:deactivated", @el)

  add: ->
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

  findData: ->
    if @is_tip_like
      return @el.data()
    target = @el.data('target') || @el.attr('href')
    return $(target).data()

  findMarkup: ->
    pop_markup =  ''
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

