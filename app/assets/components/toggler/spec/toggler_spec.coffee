
#= require toggler
class MockClass
  constructor: ->
    @state = 'instantiated'

describe 'Toggler', ->
  it 'is registered in bindable', ->
    expect(Bindable.getClass('toggler')).toEqual(roos.Toggler)

