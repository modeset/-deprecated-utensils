
#= require tooltip
class MockClass
  constructor: ->
    @state = 'instantiated'

describe 'Tooltip', ->
  it 'is registered in bindable', ->
    expect(Bindable.getClass('tooltip')).toEqual(roos.Tooltip)

