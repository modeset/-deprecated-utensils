
#= require namespace
#= require bindable
#= require support
#= require toggler

# - Test for document bounds?
# - Tests!!!
# - How does this work with touch devices?

class roos.Tooltip extends roos.Toggler
  constructor: (@el, data) ->
    super(@el, data)
    @timeout = null

  options: ->
    @data.toggle = 'in' unless @data.toggle
    @data.trigger = 'hover' unless @data.trigger
    @data.selector = 'body' unless @data.selector
    super()
    @content = @el.attr('title') || @data.title || ''
    @placement = @data.placement || 'north'
    @effect = @data.effect || 'fade'
    @selector = $(@data.selector)
    @delay = @getDelay()

  initialize: ->
    @tip = null
    super()
    @el.attr('title', '')

  toggle: (e) ->
    super(e)
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
    @tip.appendTo(@selector)
    pos = @getPlacement()
    @tip.css({top: pos.top, left: pos.left})
    @tip.addClass(@toggle_classes)

  deactivate: ->
    if @tip && roos.Support.hasTransition
      @tip.one(roos.Support.transition.end, => @remove())
      @tip.removeClass(@toggle_classes)
    else
      @remove()

  reposition: ->

  remove: ->
    if @tip
      @tip.remove()
      @tip = null

  render: ->
    html = """
           <div class="tooltip #{@placement} #{@effect}">
             <div class="tooltip-arrow"></div>
             <div class="tooltip-inner">#{@content}</div>
           </div>
           """
    return html

  getPlacement: ->
    to = @tip.offset()
    tw = @tip.outerWidth()
    th = @tip.outerHeight()
    eo = @el.offset()
    ew = @el.outerWidth()
    eh = @el.outerHeight()

    if @placement == 'north'
      return {
        top: Math.round(eo.top - th)
        left: Math.round(eo.left + ew * 0.5 - tw * 0.5)
      }
    else if @placement == 'south'
      return {
        top: Math.round(eo.top + eh)
        left: Math.round(eo.left + ew * 0.5 - tw * 0.5)
      }
    else if @placement == 'east'
      return {
        top: Math.round(eo.top + eh * 0.5 - th * 0.5)
        left: Math.round(eo.left + ew)
      }
    else if @placement == 'west'
      return {
        top: Math.round(eo.top + eh * 0.5 - th * 0.5)
        left: Math.round(eo.left - tw)
      }
    return {top:0, left:0}

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

Bindable.register('tooltip', roos.Tooltip)

