
#= require utensils/drop
#= require utensils/directional

describe 'Drop', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    extra = """
            <a class="drop" id="auto_activated" data-activate="true">Auto Activated</a>
            <ul class="menu"><li><a href="#"</li></ul>
            """

    loadFixtures('drop')
    @dom = $('#jasmine-fixtures')
    @dom.append(extra)

    @default_el = @dom.find('#drop_nav_demo .drop:nth-child(1)')
    @north_el = @dom.find('#drop_nav_demo .drop:nth-child(2)')
    @west_el = @dom.find('#drop_nav_demo .drop:nth-child(3)')
    @button_el = @dom.find('#drop_button_demo .drop')
    @split_el = @dom.find('#drop_split_demo .drop')
    @delay_el = @dom.find('#drop_delay_demo .drop')

    @default_drop = new utensils.Drop(@default_el)
    @north_drop = new utensils.Drop(@north_el)
    @west_drop = new utensils.Drop(@west_el)
    @button_drop = new utensils.Drop(@button_el)
    @split_drop = new utensils.Drop(@split_el)
    @delay_drop = new utensils.Drop(@delay_el)


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('drop')).toEqual(utensils.Drop)


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@default_drop.data).toBeDefined()

    it 'auto activates an element from a data attribute', ->
      auto_el = @dom.find("#auto_activated")
      auto_drop = new utensils.Drop(auto_el)
      expect(auto_el).toHaveClass('active')


  describe '#options', ->
    it 'sets default namespace', ->
      expect(@default_drop.data.namespace).toEqual('drop')

    it 'sets the default data.trigger state to "click"', ->
      expect(@default_drop.data.trigger).toEqual('click')

    it 'sets the default data.toggle classes to "active in"', ->
      expect(@default_drop.data.toggle).toEqual('active open')

    it 'overrides the default data.toggle classes', ->
      expect(@north_drop.data.toggle).toEqual('active open hello')

    it 'sets the default data.placement to "south"', ->
      expect(@default_drop.data.placement).toEqual('south')

    it 'overrides the default data.placement', ->
      expect(@north_drop.data.placement).toEqual('north')

    it 'sets the default data.keyboard to "true"', ->
      expect(@default_drop.data.keyboard).toEqual(true)

    it 'overrides the default data.keyboard', ->
      expect(@north_drop.data.keyboard).toEqual(false)


  describe '#initialize', ->
    it 'has a reference to the html node', ->
      expect(@default_drop.html).toEqual($('html'))

    it 'finds a reference to the link when the drop-toggle is a child of .drop', ->
      expect(@default_drop.dispatcher).toBe(@default_el.find('.drop-toggle').first())

    it 'finds a reference to the link when the drop-toggle is .drop', ->
      expect(@button_drop.dispatcher).toBe(@button_el)

    it 'finds a reference to the menu when the drop-toggle is a child of .drop', ->
      expect(@default_drop.menu).toBe(@default_el.find('.menu').first())

    it 'finds a reference to the menu when the drop-toggle is .drop', ->
      expect(@button_drop.menu).toBe(@button_el.next())

    it 'sets default namespace', ->
      expect(@west_drop.namespace).toEqual('drop')

    it 'sets the default toggle_classes to "active in"', ->
      expect(@default_drop.toggle_classes).toEqual('active open')

    it 'overrides the default toggle_classes', ->
      expect(@north_drop.toggle_classes).toEqual('active open hello')

    it 'sets the default placement to "south"', ->
      expect(@default_drop.placement).toEqual('south')

    it 'overrides the default placement', ->
      expect(@west_drop.placement).toEqual('west')

    it 'sets the default keyboard to "true"', ->
      expect(@default_drop.keyboard).toEqual(true)

    it 'overrides the default keyboard', ->
      expect(@north_drop.keyboard).toEqual(false)

    it 'shuts down the keyboard if the device is touch enabled', ->
      $('html').addClass('touch')
      touch_drop = new utensils.Drop(@dom)
      expect(touch_drop.keyboard).toBeUndefined()
      $('html').removeClass('touch')

    it 'creates an instance of "Triggerable"', ->
      expect(@north_drop.triggerable instanceof utensils.Triggerable).toEqual(true)

    it 'sets the instance of "Triggerable" to stop propagation', ->
      expect(@north_drop.triggerable.stop_propagation).toEqual(true)

    it 'creates an instance of "Directional"', ->
      expect(@north_drop.directional instanceof utensils.Directional).toEqual(true)

    it 'memoizes the cardinals from "Directional"', ->
      expect(@north_drop.cardinals).toEqual(new utensils.Directional().getCardinals())

    it 'uses Triggerables trigger types', ->
      expect(@north_drop.triggerable.trigger_type).toEqual(on:'click.drop', off:'click.drop')


  describe '#toggle', ->
    it 'calls through #toggle on the "Triggerable" instance from a link', ->
      spyEvent = spyOn(@default_drop.triggerable, 'toggle')
      @default_el.find('.drop-toggle').click()
      expect(spyEvent).toHaveBeenCalled()

    it 'calls through #toggle on the "Triggerable" instance from a button drop', ->
      spyEvent = spyOn(@button_drop.triggerable, 'toggle')
      @button_el.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'toggles a drop from a child link elements action', ->
      @default_el.find('.drop-toggle').click()
      expect(@default_el).toHaveClass('active open')
      @default_el.find('.drop-toggle').click()
      expect(@default_el).not.toHaveClass('active open')

    it 'toggles a drop from a sibling button elements action', ->
      @button_el.click()
      expect(@button_el).toHaveClass('active open')
      @button_el.click()
      expect(@button_el).not.toHaveClass('active open')

    it 'toggles a drop on an elements action after a delay', ->
      # override the delay to speed up the tests.
      @delay_drop.triggerable.delay.activate = 50
      @delay_drop.triggerable.delay.deactivate = 50

      runs ->
        @delay_el.trigger('click')
        expect(@delay_el).not.toHaveClass('active open')
      waits 50
      runs ->
        expect(@delay_el).toHaveClass('active open')
      waits 50
      runs ->
        @delay_el.trigger('click')
      waits 50
      runs ->
        expect(@delay_el).not.toHaveClass('active open')


  describe '#activate', ->
    it 'activates a drop', ->
      @default_drop.activate()
      expect(@default_el).toHaveClass('active open')


  describe '#deactivate', ->
    it 'deactivates a drop', ->
      @default_drop.activate()
      expect(@default_el).toHaveClass('active open')
      @default_drop.deactivate()
      expect(@default_el).not.toHaveClass('active open')

    it 'deactivates a drop when clicking on an exterior element', ->
      @button_el.click()
      expect(@button_el).toHaveClass('active open')
      $('html').click()
      expect(@button_el).not.toHaveClass('active open')

    it 'deactivates a drop when clicking on a menu element', ->
      @default_el.find('.drop-toggle').click()
      expect(@default_el).toHaveClass('active open')
      @default_el.find('.menu > li:first-child > a').click()
      expect(@default_el).not.toHaveClass('active open')

    it 'adds the selected class if a child in menu has the active class', ->
      menu_li = @button_drop.menu.find('li:first-child')
      @button_el.click()
      menu_li.addClass('active')
      expect(menu_li).toHaveClass('active')
      $('html').click()
      expect(@button_el).toHaveClass('selected')


  describe '#dispose', ->
    it 'deactivates the drop before cleaning up', ->
      spyEvent = spyOn(@split_drop, 'deactivate')
      @split_el.click()
      @split_drop.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'removes listeners when disposed', ->
      spyEvent = spyOn(@west_drop, 'removeListeners')
      @west_drop.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'gets rid of triggerable', ->
      @west_drop.dispose()
      expect(@west_drop.triggerable).toBeNull()

    it 'does not respond to any further events', ->
      spyEvent = spyOn(@west_drop, 'activate')
      @west_drop.dispose()
      @west_el.click()
      expect(spyEvent).not.toHaveBeenCalled()


  describe '#activated', ->
    it 'removes any existing drops before activating itself', ->
      @button_el.click()
      expect(@button_el).toHaveClass('active open')
      @north_el.find('.drop-toggle').click()
      expect(@north_el).toHaveClass('active open')
      expect(@button_el).not.toHaveClass('active open')

    it 'changes placement based on position and screen real estate', ->
      @north_el.css(position:'absolute', top:0)
      @north_el.find('.drop-toggle').click()
      expect(@north_drop.menu).toHaveClass('south')


  describe '#deactivated', ->
    it 'stops listening to document triggers', ->
      @button_el.click()
      expect(@button_el).toHaveClass('active open')
      @button_el.click()
      expect(@button_el).not.toHaveClass('active open')

      spyEvent = spyOn(@button_drop, 'clear')
      $('html').click()
      expect(spyEvent).not.toHaveBeenCalled()


  describe '#clear', ->
    it 'clears away any menus', ->
      spyEvent = spyOn(@button_drop, 'clear')
      @button_el.click()
      expect(@button_el).toHaveClass('active open')
      $('html').click()
      expect(spyEvent).toHaveBeenCalled()


  describe '#keyed', ->
    it 'deactivates the drop menu when the escape key is triggered', ->
      @split_el.click()
      expect(@split_el).toHaveClass('active open')
      @split_drop.keyed(keyCode:27, preventDefault:@noop, stopPropagation:@noop)
      expect(@split_el).not.toHaveClass('active open')

    it 'tabs through the sub menu via the down arrow', ->
      menu = @split_drop.menu
      @split_el.click()
      expect(@split_el).toHaveClass('active open')
      @split_drop.keyed(keyCode:40, preventDefault:@noop, stopPropagation:@noop)
      expect(menu.find(':focus')).toBe(menu.find(':first a'))
      @split_drop.keyed(keyCode:40, preventDefault:@noop, stopPropagation:@noop)
      expect(menu.find(':focus')).toBe(menu.find(':nth-child(2) a'))
      @split_drop.keyed(keyCode:40, preventDefault:@noop, stopPropagation:@noop)
      expect(menu.find(':focus')).toBe(menu.find(':nth-child(3) a'))
      @split_drop.keyed(keyCode:38, preventDefault:@noop, stopPropagation:@noop)
      expect(menu.find(':focus')).toBe(menu.find(':nth-child(2) a'))



  describe '#findDispacher', ->
    it 'finds a reference to the link when the drop-toggle is a child of .drop', ->
      expect(@default_drop.dispatcher).toBe(@default_el.find('.drop-toggle').first())

    it 'finds a reference to the link when the drop-toggle is .drop', ->
      expect(@button_drop.dispatcher).toBe(@button_el)

