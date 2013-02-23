#= require utensils/<%= file_name %>

describe '<%= file_name.camelize %>', ->

  beforeEach ->
    fixture.load('<%= file_name %>/markup/<%= file_name %>')
    @dom = $(fixture.el)


  describe '#constructor', ->
    it 'needs to be tested', ->
      expect(false).toEqual(true)

