#= require utensils/full_bleed

describe 'FullBleed', ->

  beforeEach ->
    fixture.load('full_bleed/markup/full_bleed')
    @dom = $(fixture.el)
    @fill_el = @dom.find '#fill_window'
    @crop_el = @dom.find '#no_fill_window'

    @filled = new utensils.FullBleed @fill_el
    @cropped = new utensils.FullBleed @crop_el


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('full-bleed')).toEqual(utensils.FullBleed)


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@filled.data).toBeDefined()


  describe '#options', ->
    it 'sets default data.namespace', ->
      expect(@filled.data.namespace).toEqual('full_bleed')

    it 'sets default data.cropType', ->
      expect(@filled.data.cropType).toEqual('CROP')


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@filled.namespace).toEqual('full_bleed')

    it 'sets the default fills window property', ->
      expect(@filled.fills_window).toEqual(true)

    it 'overrides the default fills window property', ->
      expect(@cropped.fills_window).toEqual(false)

    it 'stores an instance of window', ->
      expect(@cropped.window).toBe($(window))

    it 'sets the parent as its container', ->
      expect(@filled.container).toBe(@dom)

    it 'creates an instance of ImageCrop', ->
      expect(@filled.crop).toBeDefined()


  describe '#resize, #setSize', ->
    it 'resizes the filled objects width to the window', ->
      expect(@fill_el.width()).toEqual($(document).width())

    it 'resizes the filled objects height greater than the image', ->
      expect(@fill_el.height()).toBeGreaterThan(450)

    it 'resizes the cropped objects width to the window', ->
      expect(@crop_el.width()).toEqual($(document).width())

    it 'constrains the cropped el height to the image size', ->
      expect(@crop_el.height()).toEqual(450)


  describe '#addListeners', ->
    it 'listens to a window resize', ->
      spyEvent = spyOn(@filled, 'resize')
      $(window).trigger "resize"
      expect(spyEvent).toHaveBeenCalled()


  describe '#removeListeners', ->
    it 'stops listening to a window resize', ->
      spyEvent = spyOn(@filled, 'resize')
      @filled.removeListeners()
      $(window).trigger "resize"
      expect(spyEvent).not.toHaveBeenCalled()


  describe '#dispose', ->
    it 'cleans up the listeners', ->
      spyEvent = spyOn(@filled, 'removeListeners')
      @filled.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'cleans up the instance of crop', ->
      spyEvent = spyOn(@cropped.crop, 'dispose')
      @cropped.dispose()
      expect(spyEvent).toHaveBeenCalled()

