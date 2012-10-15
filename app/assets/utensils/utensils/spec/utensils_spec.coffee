
#= require utensils/utensils
describe 'Utensils', ->

  describe 'namespace', ->
    it 'exists for access', ->
      expect(utensils).toBeDefined()
    it 'exists on the window object', ->
      expect(window.utensils).toBeDefined()

