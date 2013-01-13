#= require utensils/indicator

class MockComponent
  constructor: (@el) ->
    @dispatcher = @el
    @namespace = "mock"
    @num_panels = 3
    @index = 0

  activate: (@index) ->
    @dispatcher.trigger 'mock:transition.start'


describe 'Indicator', ->

  beforeEach ->
    fixture.load('indicator/markup/indicator_spec')
    @dom = $(fixture.el)
    @component = new MockComponent(@dom)
    @indicator = new utensils.Indicator(@dom, {}, @component)
    @lis = @dom.find('.indication li')


  describe '#constructor', ->
    it 'finds the container', ->
      expect(@indicator.indication).toBe(@dom.find('.indication'))


  describe '#initialize #buildIndicators', ->
    it 'creates the correct number of indicators', ->
      expect(@lis.length).toEqual(3)

    it 'selects the first element with an active state', ->
      expect(@lis.first()).toHaveClass('active')


  describe '#activated', ->
    it 'increments the active state on the components trigger', ->
      @component.index = 1
      @component.dispatcher.trigger 'mock:transition.start'
      expect(@lis.eq(0)).not.toHaveClass('active')
      expect(@lis.eq(1)).toHaveClass('active')


  describe '#indicated', ->
    it 'changes the components index on an indicator trigger', ->
      @lis.eq(2).find('a').click()
      expect(@component.index).toEqual(2)
      expect(@lis.eq(2)).toHaveClass('active')

