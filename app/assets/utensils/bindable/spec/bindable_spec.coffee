
#= require utensils/bindable
class MockClass
  constructor: ->
    @state = 'instantiated'

describe 'Bindable', ->
  beforeEach ->
    @dom = setFixtures(sandbox({'data-bindable': 'mock_class_key'}))


  describe '.register', ->
    beforeEach ->
      utensils.Bindable.register('mock_class_key', MockClass)

    it 'defines registry when a reference is registered', ->
      expect(utensils.Bindable.registry).toBeDefined()

    it 'adds the MockClass with the "mock_class_key" key in the registry', ->
      expect(utensils.Bindable.registry['mock_class_key'].class).toEqual(MockClass)

    it 'retrieves the class ref with .getClass', ->
      expect(utensils.Bindable.getClass('mock_class_key')).toEqual(MockClass)


  describe '#bindAll', ->
    beforeEach ->
      @bindable = new utensils.Bindable()

    it 'instantiates a bound class', ->
      @bindable.bindAll()
      expect(@bindable.getRefs('mock_class_key').length).toEqual(1)
      expect(@bindable.getRefs('mock_class_key')[0].state).toEqual('instantiated')

