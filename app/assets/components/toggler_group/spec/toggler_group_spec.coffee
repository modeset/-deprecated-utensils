
#= require toggler_group
class MockClass
  constructor: ->
    @state = 'instantiated'

describe 'Toggler Group', ->
  it 'is registered in bindable', ->
    expect(Bindable.getClass('toggler-group')).toEqual(roos.TogglerGroup)

