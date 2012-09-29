
#= require menu

describe 'Menu', ->

  beforeEach ->
    extra = """
            <ul id="keyboard" class='nav menu' data-bindable='menu' data-keyboard="true">
              <li><a href='#'>Menu item 1</a></li>
              <li><a href='#'>Menu item 2</a></li>
              <li><a href='#'>Menu item 3</a></li>
            </ul>
            """

    loadFixtures('menu')
    @dom = $('#jasmine-fixtures')
    @dom.append(extra)

    @key_el = @dom.find("#keyboard")
    @base_el = @dom.find('.nav').first()

    @base_menu = new utensil.Menu(@base_el)
    @key_menu = new utensil.Menu(@key_el)


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(Bindable.getClass('menu')).toEqual(utensil.Menu)


  describe '#constructor', ->
    it 'extends TogglableGroup', ->
      expect(@key_menu instanceof utensil.TogglableGroup).toEqual(true)


  describe '#options', ->
    it 'does not enable the keyboard', ->
      expect(@base_menu.keyboard).toEqual(false)

    it 'enables the keyboard', ->
      expect(@key_menu.keyboard).toEqual(true)


  describe '#initialize', ->
    it 'finds the correct index when previously activated', ->
      expect(@base_menu.index).toEqual(1)

    it 'sets the index at 0 when not defined on the elements', ->
      expect(@key_menu.index).toEqual(-1)


  describe '#next', ->
    it 'cycles through the list via next', ->
      expect(@key_menu.index).toEqual(-1)
      @key_menu.next()
      expect(@key_menu.index).toEqual(0)
      @key_menu.next()
      expect(@key_menu.index).toEqual(1)
      @key_menu.next()
      expect(@key_menu.index).toEqual(2)
      @key_menu.next()
      expect(@key_menu.index).toEqual(2)
      expect(@key_el.find('li:last-child')).toHaveClass('active')


  describe '#prev', ->
    it 'cycles through the list via next', ->
      @key_menu.activate(target:@key_el.find('li:last-child'))
      expect(@key_menu.index).toEqual(2)
      @key_menu.prev()
      expect(@key_menu.index).toEqual(1)
      @key_menu.prev()
      expect(@key_menu.index).toEqual(0)
      @key_menu.prev()
      expect(@key_menu.index).toEqual(0)
      expect(@key_el.find('li:first-child')).toHaveClass('active')


  describe '#activateKeys', ->
    it 'activates the keyboard listener when previously disabled', ->
      expect(@base_menu.keyboard).toEqual(false)
      @base_menu.activateKeys()
      expect(@base_menu.keyboard).toEqual(true)


  describe '#deactivateKeys', ->
    it 'deactivates the keyboard listener when previously enabled', ->
      expect(@key_menu.keyboard).toEqual(true)
      @key_menu.deactivateKeys()
      expect(@key_menu.keyboard).toEqual(false)


  describe '#dispose', ->
    it 'cleans up its own mess', ->
      spyEvent = spyOn(@key_menu, 'removeKeyListeners')
      @key_menu.dispose()
      expect(spyEvent).toHaveBeenCalled()


  describe '#activateState', ->
    it 'sets the correct index when outside events have been triggered', ->
      @key_el.find('li:last-child').click()
      expect(@key_menu.index).toEqual(2)


  describe '#keyed', ->
    it 'triggers #next on the down arrow', ->
      @key_menu.keyed(keyCode:40, preventDefault:->)
      expect(@key_el.find('li:first-child')).toHaveClass('active')

    it 'triggers #prev on the up arrow', ->
      @key_el.find('li:last-child').click()
      @key_menu.keyed(keyCode:38, preventDefault:->)
      expect(@key_el.find('li:nth-child(2)')).toHaveClass('active')

