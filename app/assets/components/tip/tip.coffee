
#= require utensil
#= require bindable
#= require detect
#= require togglable
#= require directional

class utensil.Tip extends utensil.Togglable
  constructor: (@el, data) ->
    super(@el, data)

  options: ->
    @data.toggle = 'in' unless @data.toggle
    @data.trigger = 'hover' unless @data.trigger || $('html').hasClass('touch')
    @data.lookup = "closest" unless @data.lookup
    @data.target = 'body' unless @data.target
    super()
    @content = @el.attr('title') || @data.title || ''
    @placement = @data.placement || 'north'
    @effect = @data.effect || 'fade'
    @delay = @getDelay()

  initialize: ->
    @tip = null
    @timeout = null
    @directional = new utensil.Directional(null, @el, @placement)
    super()
    @el.attr('title', '')

  toggle: (e) ->
    e?.preventDefault() unless @data.bubble
    clearTimeout(@timeout) if @timeout
    @el.toggleClass(@toggle_classes) if @dual_toggle
    @is_active = !@is_active

    if @is_active
      if @delay.show != 0
        @timeout = setTimeout(( => @activate()), @delay.show)
      else
        @activate()
    else
      if @delay.hide != 0
        @timeout = setTimeout(( => @deactivate()), @delay.hide)
      else
        @deactivate()

  activate: ->
    @remove()
    @tip = $(@render())
    @tip.appendTo(@target)

    @directional.setElement(@tip)
    position = @directional.getPlacementAndConstrain()

    @tip.removeClass(@placement).addClass(position.cardinal) unless position.cardinal == @placement
    @tip.css({top: position.top, left: position.left})
    @tip.addClass(@toggle_classes)

  deactivate: ->
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
             <div class="tip-inner">#{@content}</div>
           </div>
           """
    return html

  getDelay: ->
    if !@data.delay
      return show: 0, hide: 0
    else if @data.delay && typeof @data.delay == 'number'
      return show: @data.delay, hide: @data.delay
    else
      params = @data.delay.split(',')
      return {
        show: parseInt(params[0].match(/\d+/g), 10)
        hide: parseInt(params[1].match(/\d+/g), 10)
      }

Bindable.register('tip', utensil.Tip)

