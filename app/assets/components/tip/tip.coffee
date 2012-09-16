
#= require utensil
#= require bindable
#= require detect
#= require togglable
#= require directional

class utensil.Tip
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @activate() if @data.activate

  options: ->
    # override togglable defaults
    @toggle_classes = @data.toggle || 'active in'
    @data.toggle = @toggle_classes
    @data.trigger = 'hover' unless @data.trigger || $('html').hasClass('touch')

    # tip options
    @placement = @data.placement || 'north'
    @title = @el.attr('title') || @data.title || ''
    @effect = @data.effect || 'fade'

  initialize: ->
    @tip = null
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
    @addToViewport()

  addToViewport: ->
    @tip = $(@render())
    @tip.appendTo(@container)
    @directional.setElement(@tip)
    position = @directional.getPlacementAndConstrain()
    @tip.removeClass(@cardinals).addClass(position.cardinal)
    @tip.css({top: position.top, left: position.left})
    @tip.addClass(@toggle_classes)

  deactivated: (e) ->
    if @tip && utensil.Detect.hasTransition
      @tip.one(utensil.Detect.transition.end, => @remove())
      @tip.removeClass(@toggle_classes)
    else
      @remove()

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

