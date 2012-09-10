
#= require utensil
describe 'Utensil', ->

  describe 'namespace', ->
    it 'exists for access', ->
      expect(utensil).toBeDefined()
    it 'exists on the window object', ->
      expect(window.utensil).toBeDefined()

