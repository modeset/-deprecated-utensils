#= require utensils/<%= file_name %>
fixture.preload('<%= file_name %>/markup/<%= file_name %>')

describe '<%= file_name.camelize %>', ->

  beforeEach ->
    fixture.load '<%= file_name %>/markup/<%= file_name %>'
    @dom = $(fixture.el)
    @noop = ->


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('<%= file_name.dasherize %>')).to.be utensils.<%= file_name.camelize %>


  describe.skip 'has not been tested', ->
    it '', ->

