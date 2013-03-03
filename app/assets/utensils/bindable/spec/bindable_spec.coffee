#= require utensils/bindable
fixture.set '<div data-bindable="mock_class_key"></div>'

class MockClass
  constructor: (@el)->
    @state = 'instantiated'
    @disposed = false

  dispose: ->
    @disposed = true


describe 'Bindable', ->
  beforeEach ->
    @dom = $(fixture.el)


  describe '#register', ->
    beforeEach ->
      utensils.Bindable.register('mock_class_key', MockClass)

    it 'defines registry when a reference is registered', ->
      expect(utensils.Bindable.registry).not.to.be undefined

    it 'adds the MockClass with the "mock_class_key" key in the registry', ->
      expect(utensils.Bindable.registry['mock_class_key'].class).to.be MockClass

    it 'retrieves the class ref with .getClass', ->
      expect(utensils.Bindable.getClass('mock_class_key')).to.be MockClass


  describe '#bindAll', ->
    beforeEach ->
      @bindable = new utensils.Bindable()

    it 'instantiates a bound class', ->
      @bindable.bindAll()
      expect(@bindable.getRefs('mock_class_key').length).to.be 1
      expect(@bindable.getRefs('mock_class_key')[0].state).to.be 'instantiated'


  describe '#dispose', ->
    beforeEach ->
      @bindable = new utensils.Bindable()
      @bindable.bindAll()

    it 'calls dispose on the bindable instances', ->
      instance = @bindable.getRefs('mock_class_key')[0]
      expect(instance.disposed).to.be false
      @bindable.dispose()
      expect(instance.disposed).to.be true

    it 'removes the instance from bindable', ->
      @bindable.dispose()
      expect(@bindable.getRefs('mock_class_key').length).to.be 0


  describe '#bind', ->
    beforeEach ->
      @bindable = new utensils.Bindable()
      @bindable.bindAll()

    it 'binds a class instance with a DOM element', ->
      instance = @bindable.getRefs('mock_class_key')[0]
      expect(instance.el.html()).to.be @dom.find('div').html()


  describe '@getClass', ->
    beforeEach ->
      @bindable = new utensils.Bindable()
      @bindable.bindAll()

    it 'returns the instance from a key', ->
      expect(utensils.Bindable.getClass('mock_class_key')).to.be MockClass


  describe '@register', ->
    beforeEach ->
      @bindable = new utensils.Bindable()

    it 'registers a bindable object through the static method', ->
      utensils.Bindable.register 'test_register', new MockClass
      expect(@bindable.getRefs('test_register').length).to.be 1

