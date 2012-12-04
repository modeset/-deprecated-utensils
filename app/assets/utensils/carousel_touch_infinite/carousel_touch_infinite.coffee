#= require utensils/utensils
#= require utensils/bindable
#= require utensils/carousel_touch

class utensils.CarouselTouchInfinite extends utensils.CarouselTouch
  constructor:(@el, data) ->
    super @el, data


  options: ->
    @data.namespace ?= 'carousel-touch-infinite'
    super()


  initialize: ->
    super()
    @pages_deep = 0
    @pages_pushed = 0


# PROTECTED #

  # provides endless scrolling, but not < page index of zero
  # if page has changed and we're past the 2nd page
  scrollerPageUpdated: (curpage_index) ->
    if curpage_index isnt @pages_deep
      page_up = curpage_index > @pages_deep
      @pages_deep = curpage_index
      pages = @slider.children()

      if page_up and curpage_index >= 2
        @pages_pushed = curpage_index - 1
        @slider.append pages[0]
        @slider.css('padding-left', @pages_pushed * @el.width())
      else if !page_up and curpage_index > 0
        @pages_pushed = curpage_index - 1
        $(pages[pages.length-1]).insertBefore($(pages[0]))
        @slider.css('padding-left', @pages_pushed * @el.width())


# INTERNAL #

  constrainIndex: ->
    @index = 0 if @index < 0


  getScrollOptions: ->
    return {
      isPaged: true unless @data.isPaged is false
      defaultOrientation: @data.defaultOrientation ? utensils.TouchScroller.HORIZONTAL
      scrollerDelegate: @createScrollDelegate()
      disabledElements: @data.disabledElements ? "img nav section article div"
      pagedEasingFactor: @data.pagedEasingFactor ? 4
      hasScrollbars: false
    }


utensils.Bindable.register 'carousel-touch-infinite', utensils.CarouselTouchInfinite

