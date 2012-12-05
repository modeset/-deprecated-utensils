#= require utensils/progress

describe 'Progress', ->

  beforeEach ->
    loadFixtures('progress')
    @dom = $('#jasmine-fixtures')

    @progress_el = @dom.find('.progress').first()
    @important_el = @dom.find('.progress.important').first()

    @progress = new utensils.Progress(@progress_el)
    @important = new utensils.Progress(@important_el)


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@important.data).toBeDefined()


  describe '#initialize', ->
    it 'to find the bar for displaying progress', ->
      expect(@progress.bar).toEqual(@progress_el.find('.bar'))

    it 'initializes a bar with a default value if provided via data initial', ->
      expect(@important.get()).toEqual(80)


  describe '#set', ->
    it 'sets the bar to a passed value', ->
      @progress.set(50)
      expect(@progress.get()).toEqual(50)

    it 'returns the instance for chaining', ->
      expect(@progress.set(50)).toEqual(@progress)


  describe '#get', ->
    it 'returns the correct value of the bars current width', ->
      expect(@important.get()).toEqual(80)

    it 'returns the correct value of the bars current width before being set', ->
      expect(@progress.get()).toEqual(60)


  describe '#reset', ->
    it 'resets the bars width down to zero', ->
      @progress.reset()
      expect(@progress.get()).toEqual(0)


  describe '#complete', ->
    it 'sets the bars width up to 100', ->
      @progress.complete()
      expect(@progress.get()).toEqual(100)


