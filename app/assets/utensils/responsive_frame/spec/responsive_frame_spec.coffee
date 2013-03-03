#= require utensils/responsive_frame
fixture.preload 'responsive_frame/markup/responsive_frame'

describe 'ResponsiveFrame', ->

  beforeEach ->
    fixture.load 'responsive_frame/markup/responsive_frame'
    @dom = $(fixture.el)
    @iframe = @dom.find 'iframe'
    @responsive_frame = new utensils.ResponsiveFrame @dom


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('responsive-frame')).to.be utensils.ResponsiveFrame


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@responsive_frame.data).not.to.be undefined


  describe '#options', ->
    it 'sets default data.namespace', ->
      expect(@responsive_frame.data.namespace).to.be 'responsive_frame'


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@responsive_frame.namespace).to.be 'responsive_frame'

    it 'stores an instance of window', ->
      expect(@responsive_frame.window.html()).to.be $(window).html()

    it 'finds the iframe', ->
      expect(@responsive_frame.iframe.html()).to.be @iframe.html()

    it 'sets the ratio from iframes width and height attributes', ->
      ratio = (@iframe.attr 'height') / (@iframe.attr 'width')
      expect(@responsive_frame.ratio).to.be ratio

    it 'sets a default 16:9 ratio when no attributes are given', ->
      markup = $('<div><iframe></iframe></div>')
      mock = new utensils.ResponsiveFrame markup
      expect(mock.ratio).to.be 9 / 16


  describe '#resize', ->
    it 'scales the iframe to the correct proportions', ->
      @responsive_frame.resize()
      frame_ratio = @iframe.attr('height') / @iframe.attr('width')
      expect(frame_ratio).to.be @responsive_frame.ratio


  describe '#addListeners', ->
    it 'listens to a window resize', ->
      spy = sinon.spy @responsive_frame, 'resize'
      $(window).trigger "resize"
      expect(spy.called).to.be.ok()


  describe '#removeListeners', ->
    it 'stops listening to a window resize', ->
      spy = sinon.spy @responsive_frame, 'resize'
      @responsive_frame.removeListeners()
      $(window).trigger "resize"
      expect(spy.called).not.to.be.ok()


  describe '#dispose', ->
    it 'cleans up the listeners', ->
      spy = sinon.spy @responsive_frame, 'removeListeners'
      @responsive_frame.dispose()
      expect(spy.called).to.be.ok()

