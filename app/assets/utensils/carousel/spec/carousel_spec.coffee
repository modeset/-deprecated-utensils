#= require utensils/carousel
#= require utensils/beacon
fixture.preload 'carousel/markup/carousel'

describe 'Carousel', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    fixture.load 'carousel/markup/carousel'
    @dom = $(fixture.el)
    @carousel_el = @dom.find('.carousel')
    @panels = @carousel_el.find('.carousel-panel')
    @carousel = new utensils.Carousel(@carousel_el)


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('carousel')).to.be utensils.Carousel


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@carousel.data).not.to.be undefined


  describe '#options', ->
    it 'sets default data.namespace', ->
      expect(@carousel.data.namespace).to.be 'carousel'

    it 'sets the default data.toggle state to "active in"', ->
      expect(@carousel.data.toggle).to.be 'active in'

    it 'sets the default data.keyboard to "true"', ->
      expect(@carousel.data.keyboard).to.be true

    it 'sets the default data.paddles to ".paddle-icon"', ->
      expect(@carousel.data.paddles).to.be '.paddle-icon'


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@carousel.namespace).to.be 'carousel'

    it 'sets the default toggle_classes state to "active in"', ->
      expect(@carousel.toggle_classes).to.be 'active in'

    it 'sets the default keyboard to "true"', ->
      expect(@carousel.keyboard).to.be true

    it 'instantiates an index at zero', ->
      expect(@carousel.index).to.be 0

    it 'finds the element for the slider', ->
      expect(@carousel.slider.html()).to.be(@carousel_el.find('.carousel-inner').html())

    it 'finds the panels for a carousel', ->
      expect(@carousel.panels.html()).to.be(@carousel_el.find('.carousel-panel').html())

    it 'stores a reference to the number of panels', ->
      expect(@carousel.num_panels).to.be(@carousel_el.find('.carousel-panel').length)

    it 'finds the paddles when they exist within the carousel', ->
      expect(@carousel.paddles.html()).to.be(@carousel_el.find('.paddle-icon').html())

    it 'stores a reference to the document when the keyboard is active', ->
      expect(@carousel.html).not.to.be null

    it 'does not initialize a beacon if auto-play is not present', ->
      expect(@carousel.beacon).to.be undefined


  describe '#initializeBeacon', ->
    it 'creates an auto slide show utilizing a beacon', ->
      @carousel_el.data('autoplay', true)
      auto = new utensils.Carousel(@carousel_el)
      expect(auto.is_autoplaying).to.be true

    it 'creates an instance of beacon for listening to tick events', ->
      @carousel_el.data('autoplay', true)
      auto = new utensils.Carousel(@carousel_el)
      expect(auto.beacon).to.be.a utensils.Beacon


  describe '#next', ->
    it 'advances to the next panel', ->
      expect(@panels.eq(0).hasClass('in')).to.be true
      @carousel.next()
      expect(@panels.eq(0).hasClass('in')).to.be false
      expect(@panels.eq(1).hasClass('in')).to.be true

    it 'pauses an auto playing carousel when triggered from user interaction', ->
      @carousel_el.data('autoplay', true)
      auto = new utensils.Carousel(@carousel_el)
      expect(auto.is_autoplaying).to.be true
      @carousel_el.find('.paddle-icon.east').click()
      expect(auto.is_autoplaying).to.be false


  describe '#prev', ->
    it 'advances to the previous panel', ->
      expect(@panels.eq(0).hasClass('in')).to.be true
      @carousel.next()
      expect(@panels.eq(0).hasClass('in')).to.be false
      expect(@panels.eq(1).hasClass('in')).to.be true
      @carousel.prev()
      expect(@panels.eq(0).hasClass('in')).to.be true
      expect(@panels.eq(1).hasClass('in')).to.be false

    it 'pauses an auto playing carousel when triggered from user interaction', ->
      @carousel_el.data('autoplay', true)
      auto = new utensils.Carousel(@carousel_el)
      expect(auto.is_autoplaying).to.be true
      @carousel_el.find('.paddle-icon.west').click()
      expect(auto.is_autoplaying).to.be false


  describe '#activate', ->
    it 'activates based on a passed index', ->
      expect(@panels.eq(0).hasClass('in')).to.be true
      @carousel.activate(2)
      expect(@panels.eq(0).hasClass('in')).to.be false
      expect(@panels.eq(2).hasClass('in')).to.be true


  describe '#pause', ->
    it 'pauses an auto playing carousel', ->
      @carousel_el.data('autoplay', true)
      auto = new utensils.Carousel(@carousel_el)
      expect(auto.is_autoplaying).to.be true
      auto.pause()
      expect(auto.is_autoplaying).to.be false


  describe '#restart', ->
    it 'pauses an auto playing carousel then restarts it', ->
      @carousel_el.data('autoplay', true)
      auto = new utensils.Carousel(@carousel_el)
      expect(auto.is_autoplaying).to.be true
      auto.pause()
      expect(auto.is_autoplaying).to.be false
      auto.restart()
      expect(auto.is_autoplaying).to.be true


  describe '#dispose', ->
    it 'disposes a basic carousel', ->
      spy = sinon.spy @carousel, 'removeListeners'
      @carousel.dispose()
      expect(spy.called).to.be.ok()

    it 'disposes an auto playing carousel', ->
      @carousel_el.data('autoplay', true)
      auto = new utensils.Carousel(@carousel_el)
      spy = sinon.spy auto, 'disposeBeacon'
      auto.dispose()
      expect(spy.called).to.be.ok()


  describe '#addListeners', ->
    it 'responds to a key event listener', ->
      expect(@panels.eq(0).hasClass("in")).to.be true
      e = $.Event('keydown')
      e.keyCode = 39
      $('html').trigger(e)
      expect(@panels.eq(0).hasClass("in")).to.be false
      expect(@panels.eq(1).hasClass("in")).to.be true

    it 'responds to a paddle event listener', ->
      expect(@panels.eq(0).hasClass("in")).to.be true
      @carousel_el.find('.paddle-icon.east').click()
      expect(@panels.eq(0).hasClass("in")).to.be false
      expect(@panels.eq(1).hasClass("in")).to.be true


  describe '#removeListeners', ->
    it 'stops responding to key events', ->
      e = $.Event('keydown')
      e.keyCode = 39
      @carousel.removeListeners()
      $('html').trigger(e)
      expect(@panels.eq(0).hasClass("in")).to.be true
      expect(@panels.eq(1).hasClass("in")).to.be false

    it 'stops responding to a paddle event', ->
      @carousel.removeListeners()
      @carousel_el.find('.paddle-icon.east').click()
      expect(@panels.eq(0).hasClass("in")).to.be true
      expect(@panels.eq(1).hasClass("in")).to.be false


  describe '#transition', ->
    it 'calls the transition method on a panel change', ->
      spy = sinon.spy @carousel, 'transition'
      @carousel_el.find('.paddle-icon.east').click()
      expect(spy.called).to.be.ok()


  describe '#transitionEnd', ->
    it 'calls the transitionEnd method on a panel change', ->
      spy = sinon.spy @carousel, 'transitionEnd'
      @carousel.has_transition = false
      @carousel_el.find('.paddle-icon.east').click()
      expect(spy.called).to.be.ok()


  describe '#paddled', ->
    it 'calls the next method on the next paddle', ->
      spy = sinon.spy @carousel, 'next'
      @carousel_el.find('.paddle-icon.east').click()
      expect(spy.called).to.be.ok()

    it 'calls the prev method on the previous paddle', ->
      spy = sinon.spy @carousel, 'prev'
      @carousel_el.find('.paddle-icon.west').click()
      expect(spy.called).to.be.ok()


  describe '#keyed', ->
    it 'responds to the next and prev key', ->
      expect(@panels.eq(0).hasClass('in')).to.be true
      e = $.Event('keydown')
      e.keyCode = 39
      $('html').trigger(e)
      expect(@panels.eq(0).hasClass('in')).to.be false
      expect(@panels.eq(1).hasClass('in')).to.be true
      p = $.Event('keydown')
      p.keyCode = 37
      $('html').trigger(p)
      expect(@panels.eq(0).hasClass('in')).to.be true
      expect(@panels.eq(1).hasClass('in')).to.be false


  describe '#constrainIndex', ->
    it 'loops around to the first index', ->
      start = @panels.length
      @carousel.index = start += 1
      expect(@carousel.index).to.be.above 1
      @carousel.constrainIndex()
      expect(@carousel.index).to.be 0

    it 'sets the index to the last element', ->
      start = 0
      @carousel.index = start -= 1
      expect(@carousel.index).to.be.below 0
      @carousel.constrainIndex()
      expect(@carousel.index).to.be @panels.length - 1


  describe '#setIndex', ->
    it 'sets an index from a string', ->
      @panels.eq(2).addClass 'blah'
      @carousel.data.activate = ".blah"
      expect(@carousel.setIndex()).to.be 2

    it 'sets an index from a number', ->
      @carousel.data.activate = 1
      expect(@carousel.setIndex()).to.be 1

    it 'defaults the index to zero', ->
      expect(@carousel.index).to.be 0

