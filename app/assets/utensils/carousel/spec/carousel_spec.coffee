#= require utensils/carousel
#= require utensils/beacon

describe 'Carousel', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    fixture.load('carousel/markup/carousel')
    @dom = $(fixture.el)
    @carousel_el = @dom.find('.carousel')
    @panels = @carousel_el.find('.carousel-panel')
    @carousel = new utensils.Carousel(@carousel_el)


  xdescribe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('carousel')).toEqual(utensils.Carousel)


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@carousel.data).toBeDefined()


  describe '#options', ->
    it 'sets default data.namespace', ->
      expect(@carousel.data.namespace).toEqual('carousel')

    it 'sets the default data.toggle state to "active in"', ->
      expect(@carousel.data.toggle).toEqual('active in')

    it 'sets the default data.keyboard to "true"', ->
      expect(@carousel.data.keyboard).toEqual(true)

    it 'sets the default data.paddles to ".paddle-icon"', ->
      expect(@carousel.data.paddles).toEqual('.paddle-icon')


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@carousel.namespace).toEqual('carousel')

    it 'sets the default toggle_classes state to "active in"', ->
      expect(@carousel.toggle_classes).toEqual('active in')

    it 'sets the default keyboard to "true"', ->
      expect(@carousel.keyboard).toEqual(true)

    it 'instantiates an index at zero', ->
      expect(@carousel.index).toEqual(0)

    it 'finds the element for the slider', ->
      expect(@carousel.slider).toBe(@carousel_el.find('.carousel-inner'))

    it 'finds the panels for a carousel', ->
      expect(@carousel.panels).toBe(@carousel_el.find('.carousel-panel'))

    it 'stores a reference to the number of panels', ->
      expect(@carousel.num_panels).toEqual(@carousel_el.find('.carousel-panel').length)

    it 'finds the paddles when they exist within the carousel', ->
      expect(@carousel.paddles).toBe(@carousel_el.find('.paddle-icon'))

    it 'stores a reference to the document when the keyboard is active', ->
      expect(@carousel.html).not.toBeNull()

    it 'does not initialize a beacon if auto-play is not present', ->
      expect(@carousel.beacon).toBeUndefined()


  describe '#initializeBeacon', ->
    it 'creates an auto slide show utilizing a beacon', ->
      @carousel_el.data('autoplay', true)
      auto = new utensils.Carousel(@carousel_el)
      expect(auto.is_autoplaying).toEqual(true)

    it 'creates an instance of beacon for listening to tick events', ->
      @carousel_el.data('autoplay', true)
      auto = new utensils.Carousel(@carousel_el)
      expect(auto.beacon instanceof utensils.Beacon).toEqual(true)


  describe '#next', ->
    it 'advances to the next panel', ->
      expect(@panels.eq(0)).toHaveClass('in')
      @carousel.next()
      expect(@panels.eq(0)).not.toHaveClass('in')
      expect(@panels.eq(1)).toHaveClass('in')

    it 'pauses an auto playing carousel when triggered from user interaction', ->
      @carousel_el.data('autoplay', true)
      auto = new utensils.Carousel(@carousel_el)
      expect(auto.is_autoplaying).toEqual(true)
      @carousel_el.find('.paddle-icon.east').click()
      expect(auto.is_autoplaying).toEqual(false)


  describe '#prev', ->
    it 'advances to the previous panel', ->
      expect(@panels.eq(0)).toHaveClass('in')
      @carousel.next()
      expect(@panels.eq(0)).not.toHaveClass('in')
      expect(@panels.eq(1)).toHaveClass('in')
      @carousel.prev()
      expect(@panels.eq(0)).toHaveClass('in')
      expect(@panels.eq(1)).not.toHaveClass('in')

    it 'pauses an auto playing carousel when triggered from user interaction', ->
      @carousel_el.data('autoplay', true)
      auto = new utensils.Carousel(@carousel_el)
      expect(auto.is_autoplaying).toEqual(true)
      @carousel_el.find('.paddle-icon.west').click()
      expect(auto.is_autoplaying).toEqual(false)


  describe '#activate', ->
    it 'activates based on a passed index', ->
      expect(@panels.eq(0)).toHaveClass('in')
      @carousel.activate(2)
      expect(@panels.eq(0)).not.toHaveClass('in')
      expect(@panels.eq(2)).toHaveClass('in')


  describe '#pause', ->
    it 'pauses an auto playing carousel', ->
      @carousel_el.data('autoplay', true)
      auto = new utensils.Carousel(@carousel_el)
      expect(auto.is_autoplaying).toEqual(true)
      auto.pause()
      expect(auto.is_autoplaying).toEqual(false)


  describe '#restart', ->
    it 'pauses an auto playing carousel then restarts it', ->
      @carousel_el.data('autoplay', true)
      auto = new utensils.Carousel(@carousel_el)
      expect(auto.is_autoplaying).toEqual(true)
      auto.pause()
      expect(auto.is_autoplaying).toEqual(false)
      auto.restart()
      expect(auto.is_autoplaying).toEqual(true)


  describe '#dispose', ->
    it 'disposes a basic carousel', ->
      spyEvent = spyOn(@carousel, 'removeListeners')
      @carousel.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'disposes an auto playing carousel', ->
      @carousel_el.data('autoplay', true)
      auto = new utensils.Carousel(@carousel_el)
      spyEvent = spyOn(auto, 'disposeBeacon')
      auto.dispose()
      expect(spyEvent).toHaveBeenCalled()


  describe '#addListeners', ->
    it 'responds to a key event listener', ->
      expect(@panels.eq(0)).toHaveClass('in')
      e = $.Event('keydown')
      e.keyCode = 39
      $('html').trigger(e)
      expect(@panels.eq(0)).not.toHaveClass('in')
      expect(@panels.eq(1)).toHaveClass('in')

    it 'responds to a paddle event listener', ->
      expect(@panels.eq(0)).toHaveClass('in')
      @carousel_el.find('.paddle-icon.east').click()
      expect(@panels.eq(0)).not.toHaveClass('in')
      expect(@panels.eq(1)).toHaveClass('in')


  describe '#removeListeners', ->
    it 'stops responding to key events', ->
      e = $.Event('keydown')
      e.keyCode = 39
      @carousel.removeListeners()
      $('html').trigger(e)
      expect(@panels.eq(0)).toHaveClass('in')
      expect(@panels.eq(1)).not.toHaveClass('in')

    it 'stops responding to a paddle event', ->
      @carousel.removeListeners()
      @carousel_el.find('.paddle-icon.east').click()
      expect(@panels.eq(0)).toHaveClass('in')
      expect(@panels.eq(1)).not.toHaveClass('in')


  describe '#transition', ->
    it 'calls the transition method on a panel change', ->
      spyEvent = spyOn(@carousel, 'transition')
      @carousel_el.find('.paddle-icon.east').click()
      expect(spyEvent).toHaveBeenCalled()


  describe '#transitionEnd', ->
    it 'calls the transitionEnd method on a panel change', ->
      spyEvent = spyOn(@carousel, 'transitionEnd')
      @carousel.has_tranny = false
      @carousel_el.find('.paddle-icon.east').click()
      expect(spyEvent).toHaveBeenCalled()


  describe '#paddled', ->
    it 'calls the next method on the next paddle', ->
      spyEvent = spyOn(@carousel, 'next')
      @carousel_el.find('.paddle-icon.east').click()
      expect(spyEvent).toHaveBeenCalled()

    it 'calls the prev method on the previous paddle', ->
      spyEvent = spyOn(@carousel, 'prev')
      @carousel_el.find('.paddle-icon.west').click()
      expect(spyEvent).toHaveBeenCalled()


  describe '#keyed', ->
    it 'responds to the next and prev key', ->
      expect(@panels.eq(0)).toHaveClass('in')
      e = $.Event('keydown')
      e.keyCode = 39
      $('html').trigger(e)
      expect(@panels.eq(0)).not.toHaveClass('in')
      expect(@panels.eq(1)).toHaveClass('in')
      p = $.Event('keydown')
      p.keyCode = 37
      $('html').trigger(p)
      expect(@panels.eq(0)).toHaveClass('in')
      expect(@panels.eq(1)).not.toHaveClass('in')


    describe '#constrainIndex', ->
      it 'loops around to the first index', ->
        start = @panels.length
        @carousel.index = start += 1
        expect(@carousel.index).toBeGreaterThan(1)
        @carousel.constrainIndex()
        expect(@carousel.index).toEqual(0)

      it 'sets the index to the last element', ->
        start = 0
        @carousel.index = start -= 1
        expect(@carousel.index).toBeLessThan(0)
        @carousel.constrainIndex()
        expect(@carousel.index).toEqual(@panels.length - 1)


  describe '#setIndex', ->
    it 'sets an index from a string', ->
      @panels.eq(2).addClass('blah')
      @carousel.data.activate = ".blah"
      expect(@carousel.setIndex()).toEqual(2)

    it 'sets an index from a number', ->
      @carousel.data.activate = 1
      expect(@carousel.setIndex()).toEqual(1)

    it 'defaults the index to zero', ->
      expect(@carousel.index).toEqual(0)

