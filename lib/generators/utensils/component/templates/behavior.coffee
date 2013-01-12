#= require utensils/bindable

class utensils.<%= file_name.camelize %>
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()


  options: ->


  initialize: ->


# PUBLIC #

  dispose: ->


# PROTECTED #

  addListeners: ->


  removeListeners: ->


utensils.Bindable.register '<%= file_name.dasherize %>', utensils.<%= file_name.camelize %>

