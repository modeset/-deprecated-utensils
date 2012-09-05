
#= require dimensionizer
describe 'Dimensionizer', ->

  afterEach ->
    $('#_dimensionizer').remove()

  describe '#options', ->
    it 'sets up basic default options', ->
      dimensionizer = new roos.Dimensionizer()
      expect(dimensionizer.pos_x).toEqual('right')
      expect(dimensionizer.pos_y).toEqual('top')
      expect(dimensionizer.offset).toEqual('5')
      expect(dimensionizer.bg_color).toEqual('rgba(0,0,0,0.7)')
      expect(dimensionizer.color).toEqual('#fff')

    it 'overrides the default options', ->
      dimensionizer = new roos.Dimensionizer(pos_x: 'left', pos_y:'bottom', offset:'40', color:'lite')
      expect(dimensionizer.pos_x).toEqual('left')
      expect(dimensionizer.pos_y).toEqual('bottom')
      expect(dimensionizer.offset).toEqual('40')
      expect(dimensionizer.bg_color).toEqual('rgba(255,255,255,0.7)')
      expect(dimensionizer.color).toEqual('#000')

  describe '#initialize', ->
    it 'initializes with dimensionizer on screen', ->
      dimensionizer = new roos.Dimensionizer()
      dimension_el = dimensionizer.dimensionizer
      expect(dimension_el).not.toBeNull()

  describe '#dispose', ->
    it 'removes the dimensionizer from the dom', ->
      dimensionizer = new roos.Dimensionizer()
      dimensionizer.dispose()
      expect($('#_dimensionizer').length).toEqual(0)

  describe '#render', ->
    it 'returns a string for rendering the default markup of a dimensionizer', ->
      dimensionizer = new roos.Dimensionizer()
      dimension_el = dimensionizer.dimensionizer
      expect(dimension_el).not.toBeNull()
      expect(dimension_el.css('position')).toEqual('fixed')

