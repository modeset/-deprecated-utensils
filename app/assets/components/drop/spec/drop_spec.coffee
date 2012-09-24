
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

    @base_drop = new utensil.Drop(@base_el)
    @north_drop = new utensil.Drop(@north_el)
    @hover_drop = new utensil.Drop(@hover_el)
    @btn_drop = new utensil.Drop(@btn_el)
    @split_drop = new utensil.Drop(@split_el)


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(Bindable.getClass('drop')).toEqual(utensil.Drop)


  describe '#constructor', ->
    it 'extends Togglable', ->
      expect(@base_drop instanceof utensil.Togglable).toEqual(true)


  describe '#options', ->
    it 'overrides the active state of Togglable', ->
      expect(@base_drop.toggle_classes).toEqual('open active')

    it 'defaults placement to "south"', ->
      expect(@base_drop.placement).toEqual('south')

    it 'overrides placement to "north"', ->
      expect(@north_drop.placement).toEqual('north')


  describe '#initialize', ->
    it 'finds the menu when it is a child of .drop', ->
      expect(@base_drop.menu).toBe(@base_el.find('.menu'))

    it 'finds the menu when it is a sibling of .drop', ->
      expect(@btn_drop.menu).toBe(@btn_el.next('.menu'))

    it 'creates an instance of Directional for positioning', ->
      expect(@base_drop.directional instanceof utensil.Directional).toEqual(true)

  describe '#toggle', ->
    it 'shows the drop menu when triggered in a child setting', ->
      link = @base_el.find('> a')
      link.click()
      expect(@base_el).toHaveClass('open active')

    it 'shows the drop menu when triggered in a sibling setting', ->
      btn_menu = @btn_el.next('.menu')
      @btn_el.click()
      expect(@btn_el).toHaveClass('open active')
      expect(btn_menu).toBeVisible()

    it 'shows the drop menu when triggered through a hover', ->
      link = @hover_el.find('> a')
      link.trigger('mouseenter')
      expect(@hover_el).toHaveClass('open active')

    it 'hides the drop menu when the drop link is triggered in a child setting', ->
      link = @base_el.find('> a')
      link.click()
      expect(@base_el).toHaveClass('open active')
      link.click()
      expect(@base_el).not.toHaveClass('open active')

    it 'hides the drop menu when the drop link is triggered in a sibling setting', ->
      btn_menu = @btn_el.next('.menu')
      @btn_el.click()
      expect(@btn_el).toHaveClass('open active')
      @btn_el.click()
      expect(@btn_el).not.toHaveClass('open active')

    it 'hides the drop menu when a child element in the .menu is selected', ->
      btn_menu = @btn_el.next('.menu')
      @btn_el.click()
      expect(@btn_el).toHaveClass('open active')
      btn_menu.find('a').first().click()
      expect(@btn_el).not.toHaveClass('open active')

    it 'hides the drop menu when an outside object is triggered', ->
      btn_menu = @btn_el.next('.menu')
      @btn_el.click()
      expect(@btn_el).toHaveClass('open active')
      $('html').click()
      expect(@btn_el).not.toHaveClass('open active')

    it 'hides the drop menu when triggered through a hover', ->
      link = @hover_el.find('> a')
      link.trigger('mouseenter')
      expect(@hover_el).toHaveClass('open active')
      link.trigger('mouseleave')
      expect(@hover_el).not.toHaveClass('open active')


  describe '#activateState', ->
    it 'changes placement based on position and screen real estate', ->
      @north_el.css(position:'absolute', top:0)
      @north_el.click()
      expect(@north_drop.menu).toHaveClass('south')


  # Dual test here on related states to speed up specs overall
  describe '#activateWithDelay, #activateRelatedState', ->
    it 'activates the drop with a delay', ->
      # override the delay to speed up the tests.
      @split_drop.delay.activate = 50
      @split_drop.delay.deactivate = 50
      menu = @dom.find('#menu_split')
      runs ->
        @split_el.trigger('click')
      waits 100
      runs ->
        expect(@split_el).toHaveClass('open active')
        expect(@split_drop.timeout).toBeNull()
        expect(menu).toHaveClass('in')


  # Dual test here on related states to speed up specs overall
  describe '#deactivateWithDelay, #deactivateRelatedState', ->
    it 'deactivates a drop after a delay', ->
      # override the delay to speed up the tests.
      @split_drop.delay.activate = 50
      @split_drop.delay.deactivate = 50
      menu = @dom.find('#menu_split')

      @split_drop.setActivate()
      expect(@split_el).toHaveClass('open active')
      runs ->
        @split_el.trigger('click')
      waits 100
      runs ->
        expect(@split_el).not.toHaveClass('open active')
        expect(@split_drop.timeout).toBeNull()
        expect(menu).not.toHaveClass('in')

