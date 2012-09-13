
#= require utensil
#= require bindable
#= require detect
#= require togglable

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
    pos = @inBounds(@getPlacement(@placement))
    @tip.css({top: pos.top, left: pos.left})
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

  getPlacement: (placement) ->
    to = @tip.offset()
    tw = @tip.outerWidth()
    th = @tip.outerHeight()
    eo = @el.offset()
    ew = @el.outerWidth()
    eh = @el.outerHeight()

    if placement == 'north'
      return {
        top: Math.round(eo.top - th)
        left: Math.round(eo.left + ew * 0.5 - tw * 0.5)
      }
    else if placement == 'south'
      return {
        top: Math.round(eo.top + eh)
        left: Math.round(eo.left + ew * 0.5 - tw * 0.5)
      }
    else if placement == 'east'
      return {
        top: Math.round(eo.top + eh * 0.5 - th * 0.5)
        left: Math.round(eo.left + ew)
      }
    else if placement == 'west'
      return {
        top: Math.round(eo.top + eh * 0.5 - th * 0.5)
        left: Math.round(eo.left - tw)
      }
    return {top:0, left:0}

  inBounds: (pos) ->
    win = $(window)
    top = win.scrollTop()
    left = win.scrollLeft()
    w = win.width()
    h = win.height()
    tw = @tip.outerWidth()
    th = @tip.outerHeight()

    if (pos.top < top)
      @tip.removeClass(@placement).addClass('south')
      return @getPlacement('south')
    if (pos.top + th > top + h)
      @tip.removeClass(@placement).addClass('north')
      return @getPlacement('north')
    if (pos.left + tw > left + w)
      @tip.removeClass(@placement).addClass('west')
      return @getPlacement('west')
    if (pos.left < left)
      @tip.removeClass(@placement).addClass('east')
      return @getPlacement('east')
    return pos

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

