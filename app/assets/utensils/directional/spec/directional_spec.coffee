#= require utensils/directional
fixture.preload 'directional/markup/directional'

showDom = ->

describe 'Directional', ->

  beforeEach ->
    fixture.load 'directional/markup/directional'
    @win = $(window)
    @dom = $(fixture.el)

    showDom = =>
      test = @dom.clone()
      test.html(@dom.html())
      test.attr('id', 'test')
      test.appendTo('body')

    # the element we want to position around
    @container = @dom.find('.container')

    # the element that will be positioned
    @el = @dom.find('.element')

    @north_direc = new utensils.Directional(@el, @container, 'north')
    @south_direc = new utensils.Directional(@el, @container, 'south')
    @east_direc  = new utensils.Directional(@el, @container, 'east')
    @west_direc  = new utensils.Directional(@el, @container, 'west')

  afterEach ->
    @container.css(top:0, left:0, bottom:"auto", right:"auto", position:'absolute')


  describe '#constructor', ->
    it 'constructs the class with parameters', ->
      expect(@north_direc.element).to.be @el
      expect(@north_direc.container).to.be @container
      expect(@north_direc.cardinal).to.be 'north'

    it 'returns a list of directional cardinals', ->
      expect(@north_direc.getCardinals()).to.be 'north east south west'


  describe '#getPlacementAndConstrain', ->
    it 'wraps #getPlacementFromCardinal and #constrainToViewport methods', ->
      sinon.stub(@east_direc, 'constrainToViewport')
      sinon.stub(@east_direc, 'getPlacementFromCardinal')
      @east_direc.getPlacementAndConstrain()
      expect(@east_direc.constrainToViewport.calledOnce).to.be.true
      expect(@east_direc.getPlacementFromCardinal.calledOnce).to.be.true


  # These tests sometimes fail when there are other errors,
  # we are testing for position here, so in failing tests
  # postions are sometimes awkward
  describe '#constrainToViewport', ->

    describe 'choosing the cardinality', ->
      it 'repositions the item on stage when north is offscreen', ->
        @container.css(position:'absolute', left:0, top: 0)
        pos = @north_direc.getPlacementFromCardinal()
        suggested = @north_direc.constrainToViewport(pos)
        expect(suggested.cardinal).to.be 'east'

      it 'repositions the item to the south when north is offscreen and it is too wide for east and west', ->
        @container.css(position:'absolute', left:0, top: 0, width: @win.width())
        pos = @north_direc.getPlacementFromCardinal()
        suggested = @north_direc.constrainToViewport(pos)
        expect(suggested.cardinal).to.be 'south'

      it 'repositions the item on stage when east is offscreen', ->
        @container.css(position:'absolute', top:0, left:@win.width() - @container.width())
        pos = @east_direc.getPlacementFromCardinal()
        suggested = @east_direc.constrainToViewport(pos)
        expect(suggested.cardinal).to.be 'west'

      it 'repositions the item on stage when west is offscreen', ->
        @container.css(position:'absolute', top:0, left:0)
        pos = @west_direc.getPlacementFromCardinal()
        suggested = @west_direc.constrainToViewport(pos)
        expect(suggested.cardinal).to.be 'east'

      it 'repositions the item on stage when south is offscreen', ->
        @container.css(position:'absolute', top: @win.height() - @container.height(), left:0)
        pos = @south_direc.getPlacementFromCardinal()
        suggested = @south_direc.constrainToViewport(pos)
        expect(suggested.cardinal).to.be 'north'

    describe 'calculating the offset of the element to put it onscreen', ->
      beforeEach ->
        # set the element to be too big to fit onscreen when positioned
        @el.css(height: 300, width: 300)

      it 'provides a top offset to position the element on screen', ->
        @container.css(position:'absolute', left:0, top: 0)
        pos = @north_direc.getPlacementFromCardinal()
        suggested = @north_direc.constrainToViewport(pos)
        expect(suggested.top).to.be - Math.round(@container.height())
        expect(suggested.top + suggested.offsetTop).to.be 0

      it 'provides a left offset to position the element on screen', ->
        @container.css(position:'absolute', top: @win.height() - @container.height(), left:0)
        pos = @north_direc.getPlacementFromCardinal()
        suggested = @north_direc.constrainToViewport(pos)
        expect(suggested.left).to.be - Math.round(@container.width())
        expect(suggested.left + suggested.offsetLeft).to.be 0


  describe '#getDimensions', ->
    it 'returns dimensions of an element', ->
      dimensions = @north_direc.getDimensions(@el)
      expect(dimensions.top).to.be @el.offset().top
      expect(dimensions.left).to.be @el.offset().left
      expect(dimensions.width).to.be @el.outerWidth()
      expect(dimensions.height).to.be @el.outerHeight()

