#= require ../<%= file_name %>
fixture.preload 'components/<%= file_name %>/spec/fixture'

describe 'namespace.<%= file_name.camelize %>', ->

  beforeEach ->
    fixture.load 'components/<%= file_name %>/spec/fixture'
    @dom = $(fixture.el)

  it 'is registered in bindable', ->
    #expect(utensils.Bindable.getClass('<%= file_name.dasherize %>')).to.be namespace.<%= file_name.camelize %>
    #expect(utensils.Bindable.getClass('<%= file_name.dasherize %>')).toEqual namespace.<%= file_name.camelize %>

  it 'should be tested'
