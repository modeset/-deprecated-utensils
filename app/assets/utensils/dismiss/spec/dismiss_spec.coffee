
#= require utensils/dismiss

describe 'Dismiss', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    loadFixtures('tab')
    @dom = $('#jasmine-fixtures')


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('dismiss')).toEqual(utensils.Dismiss)


