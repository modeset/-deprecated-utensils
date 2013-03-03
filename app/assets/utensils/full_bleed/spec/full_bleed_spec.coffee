#= require utensils/full_bleed
fixture.preload 'full_bleed/markup/full_bleed'

describe 'FullBleed', ->

  beforeEach ->
    fixture.load 'full_bleed/markup/full_bleed'
    @dom = $(fixture.el)
    @fill_el = @dom.find '#fill_window'
    @crop_el = @dom.find '#no_fill_window'

    @filled = new utensils.FullBleed @fill_el
    @cropped = new utensils.FullBleed @crop_el


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('full-bleed')).to.be utensils.FullBleed


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@filled.data).not.to.be undefined


  describe '#options', ->
    it 'sets default data.namespace', ->
      expect(@filled.data.namespace).to.be 'full_bleed'

    it 'sets default data.cropType', ->
      expect(@filled.data.cropType).to.be 'CROP'


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@filled.namespace).to.be 'full_bleed'

    it 'sets the default fills window property', ->
      expect(@filled.fills_window).to.be true

    it 'overrides the default fills window property', ->
      expect(@cropped.fills_window).to.be false

    it 'stores an instance of window', ->
      expect(@cropped.window.html()).to.be $(window).html()

    it 'sets the parent as its container', ->
      expect(@filled.container.html()).to.be @dom.html()

    it 'creates an instance of ImageCrop', ->
      expect(@filled.crop).not.to.be undefined


  describe '#resize, #setSize', ->
    it 'resizes the filled objects width to the window', ->
      expect(@fill_el.width()).to.be $(document).width()

    it 'resizes the filled objects height greater than the image', ->
      expect(@fill_el.height()).to.be.above 450

    it 'resizes the cropped objects width to the window', ->
      expect(@crop_el.width()).to.be $(document).width()

    it 'constrains the cropped el height to the image size', ->
      expect(@crop_el.height()).to.be 450


  describe '#addListeners', ->
    it 'listens to a window resize', ->
      spy = sinon.spy @filled, 'resize'
      $(window).trigger "resize"
      expect(spy.called).to.be.ok()


  describe '#removeListeners', ->
    it 'stops listening to a window resize', ->
      spy = sinon.spy @filled, 'resize'
      @filled.removeListeners()
      $(window).trigger "resize"
      expect(spy.called).not.to.be.ok()


  describe '#dispose', ->
    it 'cleans up the listeners', ->
      spy = sinon.spy @filled, 'removeListeners'
      @filled.dispose()
      expect(spy.called).to.be.ok()

    it 'cleans up the instance of crop', ->
      spy = sinon.spy @cropped.crop, 'dispose'
      @cropped.dispose()
      expect(spy.called).to.be.ok()

