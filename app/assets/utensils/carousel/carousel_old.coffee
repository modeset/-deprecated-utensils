#= require utensils/utensils
#= require utensils/bindable
#= require utensils/detect

class utensils.Carousel
  constructor:(el) ->
    @el = $(el)
    @index = 0
    @num_panels = 0
    @num_cycles = 0
    @cycle_slide = 0
    @options()
    @initialize()

  # Carousel Setup

  options: ->
    # Set any options coming from html data attributes
    @autoplay = (@el.data('autoplay') + "" == "true")
    @num_cycles = parseFloat(@el.data('cycles')) || 99
    @duration = @el.data('duration') || 5
    @duration *= 1000
    @active_class = @el.data('active-class') || 'in'
    @keyboard = (@el.data('keyboard') + "" == "true")

  initialize: ->
    @getElements()

    @buildControls() if @num_panels > 1 && @controls.length > 0
    @swap(0)

    @initTimer()

  getElements: ->
    @slider = @el.find('.carousel-inner')
    @panels = @el.find('.carousel-panel')
    @controls = @el.find('.carousel-controls')
    @indication = @el.find('.indication')

    @num_panels = @panels.length

  initTimer: ->    
    @num_cycles *= @num_panels
    @startTimer() if @autoplay == true && @num_panels > 1

  buildControls: ->
    @buildPaddles()
    @buildIndicators()
    @buildKeyboardControl()
  
  buildPaddles: ->
    @el.find('.paddle-icon.east').on("click", @next)
    @el.find('.paddle-icon.west').on("click", @prev)

  buildIndicators: ->
    indicators_html = ''
    # add <li> buttons
    if @indication
      for i in [1..@num_panels]
        indicators_html += "<li><a href='#slide_#{i}'>#{i}</a></li>"
      @indication.append(indicators_html)
      # add clicks
      @indicators = @indication.find('li')
      @indication.find('a').on 'click', (e) =>
        e.preventDefault()
        @autoplay_finished = true
        newIndex = $(e.target).parent().index()
        newIndex = @index - ( @index % @num_panels ) + newIndex # for infinite scrolling - mods the page index so we're in the current range
        @swap(newIndex)
      @updateIndicators()

  buildKeyboardControl: ->
    if @keyboard
      $(document).on 'keydown', @handleKeyboard

  handleKeyboard: (e) =>
    @prev() if e.keyCode == 37
    @next() if e.keyCode == 39

  setSliderWidth: ->
    @slider.width((100 * @num_panels) + '%')

  setPanelWidths: ->
    @panels.width((100 / @num_panels) + '%')

  updateIndicators: ->
    if @indication.length
      indicator_index = @index % @num_panels  # mod page index in case of infinite scrolling
      for indicator, i in @indicators
        if i == indicator_index
          $(indicator).addClass 'active'
        else
          $(indicator).removeClass 'active'

  startTimer: ->
    # stop auto-play after 2 full cycles
    if @cycle_slide >= @num_cycles
      @autoplay_finished = true
    if @autoplay_finished == true || @autoplay == false
      return
    # set next slide timer
    @timer = setTimeout =>
      unless @autoplay_finished
        @cycle_slide++
        @next()
    , @duration

  clearTimer: ->
    clearTimeout @timer

  constrainIndex: ->
    @index = 0 if @index >= @num_panels
    @index = @num_panels - 1 if @index < 0

  # Public Functions
  
  next: (e) =>
    e?.preventDefault()
    @autoplay_finished = true if e
    @clearTimer()
    @swap(@index + 1)

  prev: (e) =>
    e?.preventDefault()
    @autoplay_finished = true if e
    @clearTimer()
    @swap(@index - 1)

  swap: (index) ->
    @index = index
    @constrainIndex()
    @slide()
    @updateIndicators()
    @startTimer()

  slide: ->
    for page, i in @panels
      if i == @index
        if utensils.Detect.hasTransition then $(page).on(utensils.Detect.transition.end, @handleTransitionEnd) else @handleTransitionEnd()
        $(page).addClass @active_class
      else
        if utensils.Detect.hasTransition then $(page).off(utensils.Detect.transition.end, @handleTransitionEnd) 
        $(page).removeClass @active_class

  handleTransitionEnd: (e) =>
    @el.trigger('carousel:transitionEnd', index: @index, length: @num_panels)

  dispose: ->
    @clearTimer()
    @panels.off(utensils.Detect.transition.end, @handleTransitionEnd) 
    $(document).off 'keydown', @handleKeyboard
    @el.find('.paddle-icon.east').off("click", @next)
    @el.find('.paddle-icon.west').off("click", @prev)
    @indication.find('a').off 'click'

utensils.Bindable.register('carousel', utensils.Carousel)

