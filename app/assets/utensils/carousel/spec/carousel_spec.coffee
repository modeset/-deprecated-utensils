
#= require utensils/carousel

describe 'Carousel', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    loadFixtures('carousel')
    @dom = $('#jasmine-fixtures')
    @carousel_el = @dom.find('.carousel')
    @carousel = new utensils.Carousel(@carousel_el)


  describe 'binding', ->
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


  describe '#next', ->
    it 'advances to the next panel', ->

