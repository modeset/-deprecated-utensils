
#= require tip

describe 'Directional', ->

  beforeEach ->
    loadFixtures('directional')
    @html = $('#jasmine-fixtures')

    @north_el = @html.find('#north')
    @south_el = @html.find('#south')
    @east_el = @html.find('#east')
    @west_el = @html.find('#west')

    @north_direc = new utensil.Directional(@north_el, @html, 'north')
    @south_direc = new utensil.Directional(@south_el, @html, 'south')
    @east_direc = new utensil.Directional(@east_el, @html, 'east')
    @west_direc = new utensil.Directional(@west_el, @html, 'west')

  afterEach ->
    $('.demo').remove()

  describe '#constructor', ->
    it 'constructs the class with parameters', ->
      expect(@north_direc.element).toEqual(@north_el)
      expect(@north_direc.container).toEqual(@html)
      expect(@north_direc.cardinal).toEqual('north')


  describe '#getDimensions', ->
    it 'returns dimensions of an element', ->
      dimensions = @north_direc.getDimensions(@north_el)
      expect(dimensions.top).toEqual(@north_el.offset().top)
      expect(dimensions.left).toEqual(@north_el.offset().left)
      expect(dimensions.width).toEqual(@north_el.outerWidth())
      expect(dimensions.height).toEqual(@north_el.outerHeight())


  describe '#getPlacementAndConstrain', ->
    it 'wraps #getPlacementFromCardinal and #constrainToViewport methods and does not alter', ->
      @html.css(position:'absolute', top:200, left:0)
      pos = @east_direc.getPlacementAndConstrain()
      expect(pos.cardinal).toEqual('east')

    it 'wraps #getPlacementFromCardinal and #constrainToViewport methods and alters', ->
      @html.css(position:'absolute', top:200, right:0)
      pos = @east_direc.getPlacementAndConstrain()
      expect(pos.cardinal).toEqual('west')


  describe '#getPlacementFromCardinal', ->
    it 'places an item north of the link', ->
      pos = @north_direc.getPlacementFromCardinal()
      elp = @north_el.offset().top
      expect(pos.top).toBeLessThan(elp)
      expect(pos.cardinal).toEqual('north')

    it 'places an item south of the link', ->
      pos = @south_direc.getPlacementFromCardinal()
      elp = @south_el.offset().top
      expect(pos.top).toBeGreaterThan(elp)
      expect(pos.cardinal).toEqual('south')

    it 'places an item east of the link', ->
      pos = @east_direc.getPlacementFromCardinal()
      elp = @east_el.offset().left
      expect(pos.left).toBeGreaterThan(elp)
      expect(pos.cardinal).toEqual('east')

    it 'places an item west of the link', ->
      pos = @west_direc.getPlacementFromCardinal()
      elp = @west_el.offset().left
      expect(pos.left).toBeLessThan(elp)
      expect(pos.cardinal).toEqual('west')


  # These tests sometimes fail when there are other errors,
  # we are testing for position here, so in failing tests
  # postions are sometimes awkward
  describe '#constrainToViewport', ->
    it 'repositions the item on stage when north is offscreen', ->
      @html.css(position:'absolute', top:-20, left:'50%')
      pos = @north_direc.getPlacementFromCardinal()
      suggested = @north_direc.constrainToViewport(pos)
      expect(suggested.cardinal).toEqual('south')

    it 'repositions the item on stage when south is offscreen', ->
      @south_el.css(position:'absolute', bottom:0, left:'50%')
      pos = @south_direc.getPlacementFromCardinal()
      suggested = @south_direc.constrainToViewport(pos)
      expect(suggested.cardinal).toEqual('north')

    it 'repositions the item on stage when east is offscreen', ->
      @east_el.css(position:'absolute', top:0, right:0)
      pos = @east_direc.getPlacementFromCardinal()
      suggested = @east_direc.constrainToViewport(pos)
      expect(suggested.cardinal).toEqual('west')

    it 'repositions the item on stage when west is offscreen', ->
      @west_el.css(position:'absolute', top:0, left:0)
      pos = @west_direc.getPlacementFromCardinal()
      suggested = @west_direc.constrainToViewport(pos)
      expect(suggested.cardinal).toEqual('east')

