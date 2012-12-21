#= require utensils/tab

describe 'Tab', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    loadFixtures('tab')
    @dom = $('#teabag-fixtures')
    @tab_el = @dom.find('#tab_demo > .tab')
    @drop_el = @tab_el.find('.drop')
    @tab_content = @dom.find('#tab_content')

    @tab = new utensils.Tab(@tab_el)


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('tab')).toEqual(utensils.Tab)


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@tab.data).toBeDefined()

    it 'activates an element on initialization from a number', ->
      tabber = new utensils.Tab(@tab_el, {activate: 1})
      expect(@tab_el.find('li:nth-child(2)')).toHaveClass('active')

    it 'activates an element on initialization from an id', ->
      li = @tab_el.find('li:nth-child(2)')
      li.attr('id', 'blah')
      tabber = new utensils.Tab(@tab_el, {activate: '#blah'})
      expect(li).toHaveClass('active')
      li.removeAttr('id')


  describe '#options', ->
    it 'sets default data.namespace', ->
      expect(@tab.data.namespace).toEqual('tab')

    it 'sets default data.related', ->
      expect(@tab.data.related).toEqual('#tab_content')

    it 'sets the default data.toggle state to "active"', ->
      expect(@tab.data.toggle).toEqual('active')

    it 'sets the default data.relatedToggle state to "data.toggle"', ->
      expect(@tab.data.relatedToggle).toEqual('active')


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@tab.namespace).toEqual('tab')

    it 'sets default related', ->
      expect(@tab.related).toEqual('#tab_content')

    it 'sets the default toggle_classes state to "active"', ->
      expect(@tab.toggle_classes).toEqual('active')

    it 'sets the default related_classes state to "toggle_classes"', ->
      expect(@tab.related_classes).toEqual('active')

    it 'creates an instance of "ToggleGroup"', ->
      expect(@tab.toggler instanceof utensils.ToggleGroup).toEqual(true)

    it 'defaults @container to be null', ->
      expect(@tab.container).toBeNull()

    it 'creates a classified version of the related classes string', ->
      expect(@tab.related_classified).toEqual('.active')


  describe '#activate', ->
    it 'activates a tab on a click', ->
      li1 = @tab_el.find('> li:nth-child(1)')
      li2 = @tab_el.find('> li:nth-child(2)')
      expect(li1).toHaveClass('active')
      expect(li2).not.toHaveClass('active')
      li2.find('a').click()
      expect(li1).not.toHaveClass('active')
      expect(li2).toHaveClass('active')

    it 'activates a tab content pane on a click', ->
      spyEvent = spyOn(@tab, 'triggered').andCallThrough()

      li2 = @tab_el.find('> li:nth-child(2)')
      pane1 = @tab_content.find('#tab_one')
      pane2 = @tab_content.find('#tab_two')
      expect(pane1).toHaveClass('active')
      expect(pane2).not.toHaveClass('active')

      li2.find('a').click()
      expect(spyEvent).toHaveBeenCalled()
      expect(pane1).not.toHaveClass('active')
      expect(pane2).toHaveClass('active')

    it 'activates a tab and tab content when a menu item within a drop is activated', ->
      li2 = @drop_el.find('.menu > li:first-child')
      pane = @tab_content.find('#tab_four')
      li2.find('a').click()
      expect(li2).toHaveClass('active')
      expect(pane).toHaveClass('active')


  describe '#deactivate', ->
    it 'deactivates a tab on another tab click', ->
      li1 = @tab_el.find('> li:nth-child(1)')
      li2 = @tab_el.find('> li:nth-child(2)')
      expect(li1).toHaveClass('active')
      li2.find('a').click()
      expect(li1).not.toHaveClass('active')

    it 'deactivates a tab pane on another tab click', ->
      li2 = @tab_el.find('> li:nth-child(2)')
      pane1 = @tab_content.find('#tab_one')
      expect(pane1).toHaveClass('active')
      li2.find('a').click()
      expect(pane1).not.toHaveClass('active')

    it 'deaactivates a tab and tab content when a menu item within a drop is deactivated', ->
      li1 = @tab_el.find('> li:nth-child(1)')
      li2 = @drop_el.find('.menu > li:first-child')
      pane = @tab_content.find('#tab_four')
      li2.find('a').click()
      expect(li2).toHaveClass('active')
      expect(pane).toHaveClass('active')
      li1.find('a').click()
      expect(li1).toHaveClass('active')
      expect(li2).not.toHaveClass('active')
      expect(pane).not.toHaveClass('active')

    it 'does not deactivate a tab if the drop is clicked', ->
      li1 = @tab_el.find('> li:nth-child(1)')
      pane = @tab_content.find('#tab_one')
      expect(li1).toHaveClass('active')
      expect(pane).toHaveClass('active')
      @drop_el.find('.drop-toggle').click()
      @drop_el.find('.drop-toggle').click()
      expect(li1).toHaveClass('active')
      expect(pane).toHaveClass('active')


  describe '#dispose', ->
    it 'removes its own listeners', ->
      spyEvent = spyOn(@tab, 'removeListeners')
      @tab.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'calls through #dispose on the "ToggleGroup" instance', ->
      spyEvent = spyOn(@tab.toggler, 'dispose')
      @tab.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'sets the instance of "ToggleGroup" to null', ->
      @tab.dispose()
      expect(@tab.toggler).toBeNull()

    it 'does not freak out when calling multiple disposals', ->
      @tab.dispose()
      @tab.dispose()
      expect(@tab.dispose).not.toThrow()


  describe '#addListeners', ->
    it 'adds a listener for "click" event', ->
      spyEvent = spyOn(@tab, 'triggered')
      li = @tab_el.find('> li:nth-child(2)')
      li.find('a').click()
      expect(spyEvent).toHaveBeenCalled()


  describe '#removeListeners', ->
    it 'removes a listener for "click" event', ->
      spyEvent = spyOn(@tab, 'triggered')
      @tab.removeListeners()
      li = @tab_el.find('> li:nth-child(2)')
      li.find('a').click()
      expect(spyEvent).not.toHaveBeenCalled()


  describe '#triggered', ->
    it 'changes the state on both the tab and tab content', ->
      li1 = @tab_el.find('> li:nth-child(1)')
      li2 = @tab_el.find('> li:nth-child(2)')
      pane1 = @tab_content.find('#tab_one')
      pane2 = @tab_content.find('#tab_two')

      li1.find('a').click()
      expect(li1).toHaveClass('active')
      expect(li2).not.toHaveClass('active')
      expect(pane1).toHaveClass('active')
      expect(pane2).not.toHaveClass('active')

      li2.find('a').click()
      expect(li1).not.toHaveClass('active')
      expect(li2).toHaveClass('active')
      expect(pane1).not.toHaveClass('active')
      expect(pane2).toHaveClass('active')

  describe '#getTabablePane', ->
    it 'caches a selectors pane once clicked', ->
      li1 = @tab_el.find('> li:nth-child(2)')
      li2 = @tab_el.find('> li:nth-child(3)')
      pane1 = @tab_content.find('#tab_two')
      pane2 = @tab_content.find('#tab_three')

      li1.find('a').click()
      expect(@tab.panes['#tab_two']).toBe(pane1)
      li2.find('a').click()
      expect(@tab.panes['#tab_three']).toBe(pane2)

  describe '#setTabableContainer', ->
    it 'finds the tabable content when a related container is passed', ->
      li = @tab_el.find('> li:nth-child(2)')
      li.find('> a').click()
      expect(@tab.container).toEqual($('#tab_content'))

    it 'finds the tabable content from a sibling when no reference is passed', ->
      @tab.related = null
      @tab.container = null
      li = @tab_el.find('> li:nth-child(2)')
      li.find('> a').click()
      expect(@tab.container).toBe($('#tab_content'))

    it 'finds the tabable content when a related container is passed but up the DOM level', ->
      @tab.related = '#teabag-fixtures'
      @tab.container = null
      li = @tab_el.find('> li:nth-child(2)')
      li.find('> a').click()
      expect(@tab.container).toBe(@dom)

