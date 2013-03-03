#= require utensils/utensils

describe 'Utensils', ->

  describe '#namespace', ->
    it 'exists for access', ->
      expect(utensils).not.to.be undefined
    it 'exists on the window object', ->
      expect(window.utensils).not.to.be undefined

