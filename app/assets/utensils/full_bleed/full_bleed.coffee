#= require utensils/utensils
#= require utensils/bindable
#= require utensils/image_crop

class utensils.FullBleed
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @resize()


  options: ->
    @data.namespace ?= 'full_bleed'
    @data.cropType ?= 'CROP'


  initialize: ->
    @namespace = @data.namespace
    @fills_window = if @data.fillsWindow is false then false else true
    @window = $(window)
    @container = @el.parent()
    @setSize()
    image = @el.find 'img'
    @crop = new utensils.ImageCrop @el[0], @width, @height, image.width(), image.height(), @data.cropType


# PUBLIC #

  resize: (e) ->
    @setSize()
    @el.css('left', Math.round(-Math.abs(@width - @container_width) * 0.5))
    @crop.updateContainerSize @width, @height
    @crop.resize()


  dispose: ->
    return unless @crop
    @removeListeners()
    @crop.dispose()
    @crop = null


# PROTECTED #

  addListeners: ->
    @window.on "resize.#{@namespace}", => @resize arguments...


  removeListeners: ->
    @window.off "resize.#{@namespace}"


  setSize: ->
    @width = @window.width()
    window_height = @window.height()
    @container_width = @container.width()
    container_height = @container.height()
    if @fills_window
      @height = if container_height > window_height then container_height else window_height
    else
      @height = @el.height()


utensils.Bindable.register 'full-bleed', utensils.FullBleed

