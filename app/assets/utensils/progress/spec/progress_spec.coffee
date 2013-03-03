#= require utensils/progress
fixture.preload 'progress/markup/progress'

describe 'Progress', ->

  beforeEach ->
    fixture.load 'progress/markup/progress'
    @dom = $(fixture.el)

    @progress_el = @dom.find('.progress').first()
    @important_el = @dom.find('.progress.important').first()

    @progress = new utensils.Progress(@progress_el)
    @important = new utensils.Progress(@important_el)


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@important.data).not.to.be undefined


  describe '#initialize', ->
    it 'to find the bar for displaying progress', ->
      expect(@progress.bar.html()).to.be @progress_el.find('.bar').html()

    it 'initializes a bar with a default value if provided via data initial', ->
      expect(@important.get()).to.be 80


  describe '#set', ->
    it 'sets the bar to a passed value', ->
      @progress.set(50)
      expect(@progress.get()).to.be 50

    it 'returns the instance for chaining', ->
      expect(@progress.set(50)).to.eql @progress


  describe '#get', ->
    it 'returns the correct value of the bars current width', ->
      expect(@important.get()).to.be 80

    it 'returns the correct value of the bars current width before being set', ->
      expect(@progress.get()).to.be 60


  describe '#reset', ->
    it 'resets the bars width down to zero', ->
      @progress.reset()
      expect(@progress.get()).to.be 0


  describe '#complete', ->
    it 'sets the bars width up to 100', ->
      @progress.complete()
      expect(@progress.get()).to.be 100

