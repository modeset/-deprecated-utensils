#= require utensils/tab
fixture.preload 'tab/markup/tab'

describe 'Tab', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    fixture.load 'tab/markup/tab'
    @dom = $(fixture.el)
    @tab_el = @dom.find('#tab_demo > .tab')
    @drop_el = @tab_el.find('.drop')
    @tab_content = @dom.find('#tab_content')

    @tab = new utensils.Tab(@tab_el)


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('tab')).to.be utensils.Tab


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@tab.data).not.to.be undefined

    it 'activates an element on initialization from a number', ->
      tabber = new utensils.Tab(@tab_el, {activate: 1})
      expect(@tab_el.find('li:nth-child(2)').hasClass('active')).to.be true

    it 'activates an element on initialization from an id', ->
      li = @tab_el.find('li:nth-child(2)')
      li.attr('id', 'blah')
      tabber = new utensils.Tab(@tab_el, {activate: '#blah'})
      expect(li.hasClass('active')).to.be true
      li.removeAttr('id')


  describe '#options', ->
    it 'sets default data.namespace', ->
      expect(@tab.data.namespace).to.be 'tab'

    it 'sets default data.related', ->
      expect(@tab.data.related).to.be '#tab_content'

    it 'sets the default data.toggle state to "active"', ->
      expect(@tab.data.toggle).to.be 'active'

    it 'sets the default data.relatedToggle state to "data.toggle"', ->
      expect(@tab.data.relatedToggle).to.be 'active'


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@tab.namespace).to.be 'tab'

    it 'sets default related', ->
      expect(@tab.related).to.be '#tab_content'

    it 'sets the default toggle_classes state to "active"', ->
      expect(@tab.toggle_classes).to.be 'active'

    it 'sets the default related_classes state to "toggle_classes"', ->
      expect(@tab.related_classes).to.be 'active'

    it 'creates an instance of "ToggleGroup"', ->
      expect(@tab.toggler).to.be.a utensils.ToggleGroup

    it 'defaults @container to be null', ->
      expect(@tab.container).to.be null

    it 'creates a classified version of the related classes string', ->
      expect(@tab.related_classified).to.be '.active'


  describe '#activate', ->
    it 'activates a tab on a click', ->
      li1 = @tab_el.find('> li:nth-child(1)')
      li2 = @tab_el.find('> li:nth-child(2)')
      expect(li1.hasClass('active')).to.be true
      expect(li2.hasClass('active')).to.be false
      li2.find('a').click()
      expect(li1.hasClass('active')).to.be false
      expect(li2.hasClass('active')).to.be true

    it 'activates a tab content pane on a click', ->
      spy = sinon.spy @tab, 'triggered'

      li2 = @tab_el.find('> li:nth-child(2)')
      pane1 = @tab_content.find('#tab_one')
      pane2 = @tab_content.find('#tab_two')
      expect(pane1.hasClass('active')).to.be true
      expect(pane2.hasClass('active')).to.be false

      li2.find('a').click()
      expect(spy.called).to.be.ok()
      expect(pane1.hasClass('active')).to.be false
      expect(pane2.hasClass('active')).to.be true

    it 'activates a tab and tab content when a menu item within a drop is activated', ->
      li2 = @drop_el.find('.menu > li:first-child')
      pane = @tab_content.find('#tab_four')
      li2.find('a').click()
      expect(li2.hasClass('active')).to.be true
      expect(pane.hasClass('active')).to.be true


  describe '#deactivate', ->
    it 'deactivates a tab on another tab click', ->
      li1 = @tab_el.find('> li:nth-child(1)')
      li2 = @tab_el.find('> li:nth-child(2)')
      expect(li1.hasClass('active')).to.be true
      li2.find('a').click()
      expect(li1.hasClass('active')).to.be false

    it 'deactivates a tab pane on another tab click', ->
      li2 = @tab_el.find('> li:nth-child(2)')
      pane1 = @tab_content.find('#tab_one')
      expect(pane1.hasClass('active')).to.be true
      li2.find('a').click()
      expect(pane1.hasClass('active')).to.be false

    it 'deaactivates a tab and tab content when a menu item within a drop is deactivated', ->
      li1 = @tab_el.find('> li:nth-child(1)')
      li2 = @drop_el.find('.menu > li:first-child')
      pane = @tab_content.find('#tab_four')
      li2.find('a').click()
      expect(li2.hasClass('active')).to.be true
      expect(pane.hasClass('active')).to.be true
      li1.find('a').click()
      expect(li1.hasClass('active')).to.be true
      expect(li2.hasClass('active')).to.be false
      expect(pane.hasClass('active')).to.be false

    it 'does not deactivate a tab if the drop is clicked', ->
      li1 = @tab_el.find('> li:nth-child(1)')
      pane = @tab_content.find('#tab_one')
      expect(li1.hasClass('active')).to.be true
      expect(pane.hasClass('active')).to.be true
      @drop_el.find('.drop-toggle').click()
      @drop_el.find('.drop-toggle').click()
      expect(li1.hasClass('active')).to.be true
      expect(pane.hasClass('active')).to.be true


  describe '#dispose', ->
    it 'removes its own listeners', ->
      spy = sinon.spy @tab, 'removeListeners'
      @tab.dispose()
      expect(spy.called).to.be.ok()

    it 'calls through #dispose on the "ToggleGroup" instance', ->
      spy = sinon.spy @tab.toggler, 'dispose'
      @tab.dispose()
      expect(spy.called).to.be.ok()

    it 'sets the instance of "ToggleGroup" to null', ->
      @tab.dispose()
      expect(@tab.toggler).to.be null

    it 'does not freak out when calling multiple disposals', ->
      @tab.dispose()
      @tab.dispose()
      expect(@tab.dispose).not.to.throwException()


  describe '#addListeners', ->
    it 'adds a listener for "click" event', ->
      spy = sinon.spy @tab, 'triggered'
      li = @tab_el.find('> li:nth-child(2)')
      li.find('a').click()
      expect(spy.called).to.be.ok()


  describe '#removeListeners', ->
    it 'removes a listener for "click" event', ->
      spy = sinon.spy @tab, 'triggered'
      @tab.removeListeners()
      li = @tab_el.find('> li:nth-child(2)')
      li.find('a').click()
      expect(spy.called).not.to.be.ok()


  describe '#triggered', ->
    it 'changes the state on both the tab and tab content', ->
      li1 = @tab_el.find('> li:nth-child(1)')
      li2 = @tab_el.find('> li:nth-child(2)')
      pane1 = @tab_content.find('#tab_one')
      pane2 = @tab_content.find('#tab_two')

      li1.find('a').click()
      expect(li1.hasClass('active')).to.be true
      expect(li2.hasClass('active')).to.be false
      expect(pane1.hasClass('active')).to.be true
      expect(pane2.hasClass('active')).to.be false

      li2.find('a').click()
      expect(li1.hasClass('active')).to.be false
      expect(li2.hasClass('active')).to.be true
      expect(pane1.hasClass('active')).to.be false
      expect(pane2.hasClass('active')).to.be true


  describe '#getTabablePane', ->
    it 'caches a selectors pane once clicked', ->
      li1 = @tab_el.find('> li:nth-child(2)')
      li2 = @tab_el.find('> li:nth-child(3)')
      pane1 = @tab_content.find('#tab_two')
      pane2 = @tab_content.find('#tab_three')

      li1.find('a').click()
      expect(@tab.panes['#tab_two'].html()).to.be pane1.html()
      li2.find('a').click()
      expect(@tab.panes['#tab_three'].html()).to.be pane2.html()


  describe '#setTabableContainer', ->
    it 'finds the tabable content when a related container is passed', ->
      li = @tab_el.find('> li:nth-child(2)')
      li.find('> a').click()
      expect(@tab.container.html()).to.be $('#tab_content').html()

    it 'finds the tabable content from a sibling when no reference is passed', ->
      @tab.related = null
      @tab.container = null
      li = @tab_el.find('> li:nth-child(2)')
      li.find('> a').click()
      expect(@tab.container.html()).to.be $('#tab_content').html()

    it 'finds the tabable content when a related container is passed but up the DOM level', ->
      @tab.related = '#teabag-fixtures'
      @tab.container = null
      li = @tab_el.find('> li:nth-child(2)')
      li.find('> a').click()
      expect(@tab.container.html()).to.be @dom.html()

