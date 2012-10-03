
#= require drop

describe 'Drop', ->

  beforeEach ->
    # extra = """
            # """

    loadFixtures('drop')
    @dom = $('#jasmine-fixtures')
    # @dom.append(extra)

    @base_el = @dom.find('.nav').first().find('.drop:nth-child(1)')
    @north_el = @dom.find('.nav').first().find('.drop:nth-child(2)')
    @hover_el = @dom.find('.button-toolbar .button-group:nth-child(1) .drop')
    @btn_el = @dom.find('.button-toolbar .button-group:nth-child(2) .drop')
    @split_el = @dom.find('.button-toolbar .button-group:nth-child(3) .drop')
    @group_container = @dom.find('#drop_group_demo > .nav')
    @group_el = @group_container.find('.drop')

    @base_drop = new utensil.Drop(@base_el)
    @north_drop = new utensil.Drop(@north_el)
    @hover_drop = new utensil.Drop(@hover_el)
    @btn_drop = new utensil.Drop(@btn_el)
    @split_drop = new utensil.Drop(@split_el)
    @group_drop = new utensil.Drop(@group_el)

  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(Bindable.getClass('drop')).toEqual(utensil.Drop)


  describe '#options', ->
    it 'sets the states for togglable to active open', ->
      expect(@base_drop.toggle_classes).toEqual('active open')

    it 'defaults placement to "south"', ->
      expect(@base_drop.placement).toEqual('south')

    it 'overrides placement to "north"', ->
      expect(@north_drop.placement).toEqual('north')

    it 'overrides the selected classes used in a group', ->
      simple = new utensil.Drop(@dom, {select:'highlight'})
      expect(simple.select_classes).toEqual('highlight')

    it 'uses the keyboard for navigation by default', ->
      expect(@base_drop.use_keyboard).toEqual(true)

    it 'disables the keyboard when html has the touch', ->
      $('html').addClass('touch')
      simple = new utensil.Drop(@dom)
      expect(simple.use_keyboard).toEqual(false)
      $('html').removeClass('touch')

    it 'disables the keyboard when instantiated with a data attribute', ->
      simple = new utensil.Drop(@dom, keyboard:false)
      expect(simple.use_keyboard).toEqual(false)


  describe '#initialize', ->
    it 'creates an instance of Togglable', ->
      expect(@base_drop.toggler instanceof utensil.Togglable).toEqual(true)

    it 'finds the menu element when it is a child of .drop from #findMenu', ->
      expect(@base_drop.menu).toBe(@base_el.find('.menu'))

    it 'finds the menu element when it is a sibling of .drop from #findMenu', ->
      expect(@btn_drop.menu).toBe(@btn_el.next('.menu'))

    it 'finds the menu list', ->
      expect(@base_drop.menu_items).toBe(@base_el.find('.menu li'))

    it 'sets the group to undefined if no group is specified from #findGroup', ->
      expect(@base_drop.group).toBeUndefined()

    it 'sets the group when the data-group attribute is defined from #findGroup', ->
      expect(@group_drop.group).toBe(@group_container)

    it 'creates an instance of Directional for positioning', ->
      expect(@base_drop.directional instanceof utensil.Directional).toEqual(true)


  describe '#toggle', ->
    it 'shows the drop menu when triggered in a child setting', ->
      link = @base_el.find('> a')
      link.click()
      expect(@base_el).toHaveClass('active open')

    it 'shows the drop menu when triggered in a sibling setting', ->
      btn_menu = @btn_el.next('.menu')
      @btn_el.click()
      expect(@btn_el).toHaveClass('active open')
      expect(btn_menu).toBeVisible()

    it 'shows the drop menu when triggered through a hover', ->
      link = @hover_el.find('> a')
      link.trigger('mouseenter')
      expect(@hover_el).toHaveClass('active open')

    it 'hides the drop menu when the drop link is triggered in a child setting', ->
      link = @base_el.find('> a')
      link.click()
      expect(@base_el).toHaveClass('active open')
      link.click()
      expect(@base_el).not.toHaveClass('active open')

    it 'hides the drop menu when the drop link is triggered in a sibling setting', ->
      btn_menu = @btn_el.next('.menu')
      @btn_el.click()
      expect(@btn_el).toHaveClass('active open')
      @btn_el.click()
      expect(@btn_el).not.toHaveClass('active open')

    it 'hides the drop menu when a child element in the .menu is selected', ->
      base_menu = @base_el.find('.menu')
      @base_el.click()
      expect(@base_el).toHaveClass('active open')
      base_menu.find('a').first().click()
      expect(@base_el).not.toHaveClass('active open')

    it 'hides the drop menu when a sibling element in the .menu is selected', ->
      btn_menu = @btn_el.next('.menu')
      @btn_el.click()
      expect(@btn_el).toHaveClass('active open')
      btn_menu.find('a').first().click()
      expect(@btn_el).not.toHaveClass('active open')

    # This is the right test but currently pending the correct behavior
    xit 'hides the drop menu when an outside object is triggered', ->
      btn_menu = @btn_el.next('.menu')
      @btn_el.click()
      expect(@btn_el).toHaveClass('active open')
      $('html').click()
      expect(@btn_el).not.toHaveClass('active open')

    it 'hides the drop menu when triggered through a hover', ->
      link = @hover_el.find('> a')
      link.trigger('mouseenter')
      expect(@hover_el).toHaveClass('active open')
      link.trigger('mouseleave')
      expect(@hover_el).not.toHaveClass('active open')


  describe '#dispose', ->
    it 'cleans up its own mess', ->
      spyEvent = spyOn(@group_drop, 'removeListeners')
      @group_drop.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'cleans up toggler', ->
      @group_drop.dispose()
      expect(@group_drop.toggler).toBeNull()


  describe '#activated', ->
    it 'changes placement based on position and screen real estate', ->
      @north_el.css(position:'absolute', top:0)
      @north_el.click()
      expect(@north_drop.menu).toHaveClass('south')


  # This needs to be implemented
  xdescribe '#deactivated', ->


  # Dual test here on related states to speed up specs overall
  describe '#activateWithDelay, #activateRelatedState', ->
    it 'activates the drop with a delay', ->
      # override the delay to speed up the tests.
      @split_drop.toggler.delay.activate = 50
      @split_drop.toggler.delay.deactivate = 50
      menu = @dom.find('#menu_split')
      runs ->
        @split_el.trigger('click')
      waits 100
      runs ->
        expect(@split_el).toHaveClass('active open')
        expect(@split_drop.toggler.timeout).toBeNull()
        expect(menu).toHaveClass('in')


  # Dual test here on related states to speed up specs overall
  describe '#deactivateWithDelay, #deactivateRelatedState', ->
    it 'deactivates a drop after a delay', ->
      # override the delay to speed up the tests.
      @split_drop.toggler.delay.activate = 50
      @split_drop.toggler.delay.deactivate = 50
      menu = @dom.find('#menu_split')

      @split_drop.toggler.setActivate()
      expect(@split_el).toHaveClass('active open')
      runs ->
        @split_el.trigger('click')
      waits 100
      runs ->
        expect(@split_el).not.toHaveClass('active open')
        expect(@split_drop.toggler.timeout).toBeNull()
        expect(menu).not.toHaveClass('in')


  describe '#toggleSelectionFromGroup', ->
    it 'sets the selected state when a child of the toggle is active', ->
      first = @group_el.find('.menu > li:first-child')
      @group_drop.activate()
      expect(@group_el).toHaveClass('open')
      first.addClass('active')
      # normally triggered by a TogglableGroup
      @group_drop.toggleSelectionFromGroup()
      @group_drop.deactivate()
      expect(@group_el).toHaveClass(@group_drop.select_classes)


  describe '#keyed', ->
    noop = ->
    it 'deactivates the drop menu when the escape key is triggered', ->
      @group_el.find('> a').click()
      expect(@group_el).toHaveClass('open')
      @group_drop.keyed(keyCode:27, preventDefault:noop, stopPropagation:noop)
      expect(@group_el).not.toHaveClass('open')

