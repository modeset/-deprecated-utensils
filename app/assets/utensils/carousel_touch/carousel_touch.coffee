#= require utensils/utensils
#= require utensils/bindable
#= require utensils/carousel
#= require utensils/touch_scroller

class utensils.CarouselTouch extends utensils.Carousel
  constructor:(@el, data) ->
    super @el, data


  options: ->
    @data.namespace ?= 'carousel-touch'
    super()


  initialize: ->
    super()
    @setSliderWidth()
    @setPanelWidths()
    @initializeScroller()


  initializeScroller: ->
    @scroller = new utensils.TouchScroller @el[0], @slider[0], @getScrollOptions()


# PUBLIC #

  dispose: ->
    @scroller.dispose() if @scroller
    super()


# PROTECTED #

  createScrollDelegate: =>
    updatePosition: (position_x, position_y, is_touching) =>
      @pressed_and_didnt_move = false

    touchStart: =>
      @pause()
      @pressed_and_didnt_move = true

    touchEnd: =>
      if @pressed_and_didnt_move
        @beacon.start() if @beacon and @is_autoplaying
      @pressed_and_didnt_move = false

    handleDestination: =>
      @scrollerPageUpdated @scroller.getPage() if @scroller
      @transitionEnd()

    pageChanged: =>
      @index = @scroller.getPage()
      @scrollerPageUpdated @scroller.getPage()
      @transition()

    closestIndexChanged: (closest_index) =>
      @index = closest_index
      @scrollerPageUpdated closest_index


  scrollerPageUpdated: (index) ->
    # do nothing - used in infinite scroller


  transition: ->
    super()
    @scroller.setPage @index, false


  getScrollOptions: ->
    return {
      isPaged: true unless @data.isPaged is false
      defaultOrientation: @data.defaultOrientation ? utensils.TouchScroller.HORIZONTAL
      scrollerDelegate: @createScrollDelegate()
      disabledElements: @data.disabledElements ? "img nav section article div"
      pagedEasingFactor: @data.pagedEasingFactor ? 4
      hasScrollbars: true unless @data.hasScrollbars is false
    }


utensils.Bindable.register 'carousel-touch', utensils.CarouselTouch

