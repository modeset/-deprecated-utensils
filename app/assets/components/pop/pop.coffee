
#= require utensil
#= require bindable
#= require detect
#= require togglable
#= require directional

class utensil.Pop
  constructor: (@el, data) ->
    @is_tip_like = if @el.data('content') then true else false
    @data = if data then data else @findData()
    @options()
    @initialize()
    @addListeners()
    @activate() if @data.activate

  options: ->
    # override togglable defaults
    @toggle_classes = @data.toggle || 'active in'
    @data.toggle = @toggle_classes
    @data.target = @el unless @data.target

    # pop options
    @placement = @data.placement || 'north'
    @title = @el.attr('title') || @data.title || ''
    @content = @data.content || ''
    @effect = @data.effect || 'fade'

  initialize: ->
    @pop = null
    @cached_markup = null
    @container = $('body')
    @toggler = new utensil.Togglable(@el, @data)
    @directional = new utensil.Directional(null, @el, @placement)
    @cardinals = @directional.getCardinals()
    @el.attr('title', '')

  # PUBLIC #

  toggle: ->
    @toggler.toggle()

  activate: ->
    @toggler.activate()

  deactivate: ->
    @toggler.deactivate()

  dispose: ->
    @removeListeners()
    @toggler.dispose()
    @toggler = null
    @remove()

  # PROTECTED #

  addListeners: ->
    @toggler.dispatcher.on('togglable:activate', => @activated.apply(@, arguments))
    @toggler.dispatcher.on('togglable:deactivate', => @deactivated.apply(@, arguments))

  removeListeners: ->
    @toggler.dispatcher.off('togglable:activate')
    @toggler.dispatcher.off('togglable:deactivate')

  activated: (e) ->
    @remove()
    @cached_markup = @findMarkup() unless @cached_markup
    @addToViewport()

  addToViewport: ->
    @pop = @cached_markup
    @pop.appendTo(@container)
    @directional.setElement(@pop)
    position = @directional.getPlacementAndConstrain()
    @pop.removeClass(@cardinals).addClass(position.cardinal)
    @pop.css({top: position.top, left: position.left})
    @pop.addClass(@toggle_classes)

  deactivated: (e) ->
    if @pop && utensil.Detect.hasTransition
      @pop.one(utensil.Detect.transition.end, => @remove())
      @pop.removeClass(@toggle_classes)
    else
      @remove()

  remove: ->
    if @pop
      @pop.remove()
      @pop = null

  findData: ->
    if @is_tip_like
      return @el.data()
    target = @el.attr('href') || @el.data('target')
    return $(target).data()

  findMarkup: ->
    pop_markup =  ''
    if @is_tip_like
      pop_markup = $(@render())
      if @title == ''
        pop_markup.find('.pop-header').remove()
        pop_markup.addClass('pop-no-header')
    else
      target = $(@el.attr('href'))
      pop_markup = $(target.html())
      target.remove()
    return pop_markup

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

Bindable.register('pop', utensil.Pop)

