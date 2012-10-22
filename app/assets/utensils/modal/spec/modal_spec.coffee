
#= require utensils/modal

describe 'Modal', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    loadFixtures('modal')
    @dom = $('#jasmine-fixtures')


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('modal')).toEqual(utensils.Modal)


  xdescribe '#constructor', ->
    it 'sets up a data object', ->
      expect(@alert.data).toBeDefined()

