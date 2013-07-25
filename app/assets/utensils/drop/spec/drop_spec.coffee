#= require utensils/drop
#= require utensils/directional
fixture.preload 'drop/markup/drop'

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

    fixture.load 'drop/markup/drop'
    @dom = $(fixture.el)
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
      expect(utensils.Bindable.getClass('drop')).to.be utensils.Drop


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@default_drop.data).not.to.be undefined

    it 'auto activates an element from a data attribute', ->
      auto_el = @dom.find("#auto_activated")
      auto_drop = new utensils.Drop(auto_el)
      expect(auto_el.hasClass('active')).to.be true


  describe '#options', ->
    it 'sets default namespace', ->
      expect(@default_drop.data.namespace).to.be 'drop'

    it 'sets the default data.trigger state to "click"', ->
      expect(@default_drop.data.trigger).to.be 'click'

    it 'sets the default data.toggle classes to "active open"', ->
      expect(@default_drop.data.toggle).to.be 'active open'

    it 'overrides the default data.toggle classes', ->
      expect(@north_drop.data.toggle).to.be 'active open hello'

    it 'sets the default data.placement to "south"', ->
      expect(@default_drop.data.placement).to.be 'south'

    it 'overrides the default data.placement', ->
      expect(@north_drop.data.placement).to.be 'north'

    it 'sets the default data.keyboard to "true"', ->
      expect(@default_drop.data.keyboard).to.be true

    it 'overrides the default data.keyboard', ->
      expect(@north_drop.data.keyboard).to.be false


  describe '#initialize', ->
    it 'finds a reference to the link when the drop-toggle is a child of .drop', ->
      expect(@default_drop.dispatcher.html()).to.be(@default_el.find('.drop-toggle').first().html())

    it 'finds a reference to the link when the drop-toggle is .drop', ->
      expect(@button_drop.dispatcher).to.be @button_el

    it 'sets default namespace', ->
      expect(@west_drop.namespace).to.be 'drop'

    it 'sets the default toggle_classes to "active in"', ->
      expect(@default_drop.toggle_classes).to.be 'active open'

    it 'overrides the default toggle_classes', ->
      expect(@north_drop.toggle_classes).to.be 'active open hello'

    it 'sets the default placement to "south"', ->
      expect(@default_drop.placement).to.be 'south'

    it 'overrides the default placement', ->
      expect(@west_drop.placement).to.be 'west'

    it 'sets the default keyboard to "true"', ->
      expect(@default_drop.keyboard).to.be true

    it 'overrides the default keyboard', ->
      expect(@north_drop.keyboard).to.be false

    it 'creates an instance of "Triggerable"', ->
      expect(@north_drop.triggerable).to.be.a utensils.Triggerable

    it 'sets the instance of "Triggerable" to stop propagation', ->
      expect(@north_drop.triggerable.stop_propagation).to.be true

    it 'uses Triggerables trigger types', ->
      expect(@north_drop.triggerable.trigger_type).to.eql({on:'click.drop', off:'click.drop'})


  describe '#setup', ->
    it 'has a reference to the html node', ->
      @default_drop.setup()
      expect(@default_drop.html.html()).to.be $('html').html()

    it 'finds a reference to the menu when the drop-toggle is a child of .drop', ->
      @default_drop.setup()
      expect(@default_drop.menu.html()).to.be(@default_el.find('.menu').first().html())

    it 'finds a reference to the menu when the drop-toggle is .drop', ->
      @button_drop.setup()
      expect(@button_drop.menu.html()).to.be @button_el.next().html()

    it 'creates an instance of "Directional"', ->
      @north_drop.setup()
      expect(@north_drop.directional).to.be.a utensils.Directional


  describe '#toggle', ->
    it 'calls through #toggle on the "Triggerable" instance from a link', ->
      spy = sinon.spy @default_drop.triggerable, 'toggle'
      @default_el.find('.drop-toggle').click()
      expect(spy.called).to.be.ok()

    it 'calls through #toggle on the "Triggerable" instance from a button drop', ->
      spy = sinon.spy @button_drop.triggerable, 'toggle'
      @button_el.click()
      expect(spy.called).to.be.ok()

    it 'toggles a drop from a child link elements action', ->
      @default_el.find('.drop-toggle').click()
      expect(@default_el.hasClass('active open')).to.be true
      @default_el.find('.drop-toggle').click()
      expect(@default_el.hasClass('active open')).to.be false

    it 'toggles a drop from a sibling button elements action', ->
      @button_el.click()
      expect(@button_el.hasClass('active open')).to.be true
      @button_el.click()
      expect(@button_el.hasClass('active open')).to.be false

    it 'toggles a drop element on after a delay', (done) ->
      @delay_drop.triggerable.delay.activate = 50
      @delay_el.trigger('click')
      expect(@delay_el.hasClass('active open')).to.be false
      setTimeout(( =>
        expect(@delay_el.hasClass('active open')).to.be true
        done()
      ), 50)


  describe '#activate', ->
    it 'activates a drop', ->
      @default_drop.activate()
      expect(@default_el.hasClass('active open')).to.be true


  describe '#deactivate', ->
    it 'deactivates a drop', ->
      @default_drop.activate()
      expect(@default_el.hasClass('active open')).to.be true
      @default_drop.deactivate()
      expect(@default_el.hasClass('active open')).to.be false

    it 'deactivates a drop when clicking on an exterior element', ->
      @button_el.click()
      expect(@button_el.hasClass('active open')).to.be true
      $('html').click()
      expect(@button_el.hasClass('active open')).to.be false

    it 'deactivates a drop when clicking on a menu element', ->
      @default_el.find('.drop-toggle').click()
      expect(@default_el.hasClass('active open')).to.be true
      @default_el.find('.menu > li:first-child > a').click()
      expect(@default_el.hasClass('active open')).to.be false

    it 'adds the selected class if a child in menu has the active class', ->
      menu_li = @dom.find('#drop_button_demo .menu li:first-child')
      @button_el.click()
      menu_li.addClass('active')
      expect(menu_li.hasClass('active')).to.be true
      $('html').click()
      expect(@button_el.hasClass('selected')).to.be true


  describe '#dispose', ->
    it 'deactivates the drop before cleaning up', ->
      spy = sinon.spy @split_drop, 'deactivate'
      @split_el.click()
      @split_drop.dispose()
      expect(spy.called).to.be.ok()

    it 'removes listeners when disposed', ->
      spy = sinon.spy @west_drop, 'removeListeners'
      @west_drop.dispose()
      expect(spy.called).to.be.ok()

    it 'gets rid of triggerable', ->
      @west_drop.dispose()
      expect(@west_drop.triggerable).to.be null

    it 'gets rid of directional', ->
      @west_drop.setup()
      @west_drop.dispose()
      expect(@west_drop.directional).to.be null

    it 'does not respond to any further events', ->
      spy = sinon.spy @west_drop, 'activate'
      @west_drop.dispose()
      @west_el.click()
      expect(spy.called).not.to.be.ok()

    it 'does not freak out when calling multiple disposals', ->
      @west_drop.dispose()
      @west_drop.dispose()
      expect(@west_drop.dispose).not.to.throwException()


  describe '#activated', ->
    it 'removes any existing drops before activating itself', ->
      @button_el.click()
      expect(@button_el.hasClass('active open')).to.be true
      @north_el.find('.drop-toggle').click()
      expect(@north_el.hasClass('active open')).to.be true
      expect(@button_el.hasClass('active open')).to.be false

    it 'changes placement based on position and screen real estate', ->
      @north_el.css(position:'absolute', top:0)
      @north_el.find('.drop-toggle').click()
      console.log @north_drop.menu.attr('class')
      expect(@north_drop.menu.hasClass('south')).to.be true


  describe '#deactivated', ->
    it 'stops listening to document triggers', ->
      @button_el.click()
      expect(@button_el.hasClass('active open')).to.be true
      @button_el.click()
      expect(@button_el.hasClass('active open')).to.be false

      spy = sinon.spy @button_drop, 'clear'
      $('html').click()
      expect(spy.called).not.to.be.ok()


  describe '#clear', ->
    it 'clears away any menus', ->
      spy = sinon.spy @button_drop, 'clear'
      @button_el.click()
      expect(@button_el.hasClass('active open')).to.be true
      $('html').click()
      expect(spy.called).to.be.ok()


  describe '#keyed', ->
    it 'deactivates the drop menu when the escape key is triggered', ->
      @split_el.click()
      expect(@split_el.hasClass('active open')).to.be true
      @split_drop.keyed(keyCode:27, preventDefault:@noop, stopPropagation:@noop)
      expect(@split_el.hasClass('active open')).to.be false

    # Passes in the browser, but waiting for the phantom js issue around focus state to be resolved
    # @see: https://code.google.com/p/phantomjs/issues/detail?id=427
    it.skip 'tabs through the sub menu via the down arrow (pending due to issue with phantom.js and focus states)', ->
      menu = @dom.find('#drop_split_demo .menu')
      @split_el.click()
      expect(@split_el.hasClass('active open')).to.be true
      @split_drop.keyed(keyCode:40, preventDefault:@noop, stopPropagation:@noop)
      expect(menu.find(':focus').html()).to.be(menu.find(':first a').html())
      @split_drop.keyed(keyCode:40, preventDefault:@noop, stopPropagation:@noop)
      expect(menu.find(':focus').html()).to.be(menu.find(':nth-child(2) a').html())
      @split_drop.keyed(keyCode:40, preventDefault:@noop, stopPropagation:@noop)
      expect(menu.find(':focus').html()).to.be(menu.find(':nth-child(3) a').html())
      @split_drop.keyed(keyCode:38, preventDefault:@noop, stopPropagation:@noop)
      expect(menu.find(':focus').html()).to.be(menu.find(':nth-child(2) a').html())


  describe '#findDispacher', ->
    it 'finds a reference to the link when the drop-toggle is a child of .drop', ->
      expect(@default_drop.dispatcher.html()).to.be(@default_el.find('.drop-toggle').first().html())

    it 'finds a reference to the link when the drop-toggle is .drop', ->
      expect(@button_drop.dispatcher.html()).to.be(@button_el.html())

