#= require utensils/utensils
#= require utensils/bindable

class utensils.ResponsiveFrame
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @resize()


  options: ->
    @data.namespace ?= 'responsive_frame'


  initialize: ->
    @namespace = @data.namespace
    @window = $(window)
    @iframe = @el.find 'iframe'
    wv = @iframe.attr 'width'
    hv = @iframe.attr 'height'
    @ratio = if wv and hv then hv / wv else 9 / 16


# PUBLIC #

  resize: (e) ->
    wv = @el.width()
    @iframe.attr 'width', wv
    @iframe.attr 'height', wv * @ratio


  dispose: ->
    @removeListeners()


# PROTECTED #

  addListeners: ->
    @window.on "resize.#{@namespace}", => @resize arguments...


  removeListeners: ->
    @window.off "resize.#{@namespace}"


utensils.Bindable.register 'responsive-frame', utensils.ResponsiveFrame

