
#= require roos
describe 'Roos', ->

  describe 'namespace', ->
    it 'exists for access', ->
      expect(roos).toBeDefined()
    it 'exists on the window object', ->
      expect(window.roos).toBeDefined()

