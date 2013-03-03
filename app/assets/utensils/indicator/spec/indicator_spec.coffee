#= require utensils/indicator
fixture.preload 'indicator/markup/indicator_spec'

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
    fixture.load 'indicator/markup/indicator_spec'
    @dom = $(fixture.el)
    @component = new MockComponent(@dom)
    @indicator = new utensils.Indicator(@dom, {}, @component)
    @lis = @dom.find('.indication li')


  describe '#constructor', ->
    it 'finds the container', ->
      expect(@indicator.indication.html()).to.be @dom.find('.indication').html()


  describe '#initialize #buildIndicators', ->
    it 'creates the correct number of indicators', ->
      expect(@lis.length).to.be 3

    it 'selects the first element with an active state', ->
      expect(@lis.first().hasClass('active')).to.be true


  describe '#activated', ->
    it 'increments the active state on the components trigger', ->
      @component.index = 1
      @component.dispatcher.trigger 'mock:transition.start'
      expect(@lis.eq(0).hasClass('active')).to.be false
      expect(@lis.eq(1).hasClass('active')).to.be true


  describe '#indicated', ->
    it 'changes the components index on an indicator trigger', ->
      @lis.eq(2).find('a').click()
      expect(@component.index).to.be 2
      expect(@lis.eq(2).hasClass('active')).to.be true

