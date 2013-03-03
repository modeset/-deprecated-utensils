#= require utensils/toggle
fixture.preload 'toggle/markup/toggle'

describe 'Toggle', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    fixture.load 'toggle/markup/toggle'
    @dom = $(fixture.el)

    @defaulter_el = @dom.find('#toggle_1')
    @hover_el = @dom.find('#toggle_2')
    @focus_el = @dom.find('#toggle_3')
    @delay_el = @dom.find('#toggle_4')
    @auto_el = @dom.find('#toggle_5')

    @defaulter = new utensils.Toggle(@defaulter_el)
    @hoverer = new utensils.Toggle(@hover_el)
    @focuser = new utensils.Toggle(@focus_el)
    @delayer = new utensils.Toggle(@delay_el)
    @auto = new utensils.Toggle(@auto_el)


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('toggle')).to.be utensils.Toggle


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@defaulter.data).not.to.be undefined

    it 'auto activates an element from a data attribute', ->
      expect(@auto_el.hasClass('active')).to.be true


  describe '#options', ->
    it 'sets default namespace', ->
      expect(@defaulter.data.namespace).to.be 'toggle'

    it 'overrides the default namespace via a data attribute', ->
      expect(@hoverer.data.namespace).to.be 'hoverable'

    it 'sets the default data.toggle state to "active"', ->
      expect(@defaulter.data.toggle).to.be 'active'

    it 'overrides the default data.toggle state to "active on"', ->
      expect(@hoverer.data.toggle).to.be 'active on'


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@defaulter.namespace).to.be 'toggle'

    it 'overrides the default namespace via a data attribute', ->
      expect(@hoverer.namespace).to.be 'hoverable'

    it 'sets the default toggle state to "active"', ->
      expect(@defaulter.toggle_classes).to.be 'active'

    it 'overrides the default toggle state to "active on"', ->
      expect(@hoverer.toggle_classes).to.be 'active on'

    it 'creates an instance of "Triggerable"', ->
      expect(@defaulter.triggerable).to.be.a utensils.Triggerable


  describe '#toggle', ->
    it 'calls through #toggle on the "Triggerable" instance', ->
      spy = sinon.spy @defaulter.triggerable, 'toggle'
      @defaulter_el.click()
      expect(spy.called).to.be.ok()


  describe '#activate', ->
    it 'calls through #activate on the "Triggerable" instance', ->
      spy = sinon.spy @defaulter.triggerable, 'activate'
      @defaulter_el.click()
      expect(spy.called).to.be.ok()


  describe '#deactivate', ->
    it 'calls through #deactivate on the "Triggerable" instance', ->
      spy = sinon.spy @defaulter.triggerable, 'deactivate'
      @defaulter_el.click()
      @defaulter_el.click()
      expect(spy.called).to.be.ok()


  describe '#dispose', ->
    it 'removes its own listeners', ->
      spy = sinon.spy @defaulter, 'removeListeners'
      @defaulter.dispose()
      expect(spy.called).to.be.ok()

    it 'calls through #dispose on the "Triggerable" instance', ->
      spy = sinon.spy @defaulter.triggerable, 'dispose'
      @defaulter.dispose()
      expect(spy.called).to.be.ok()

    it 'sets the instance of "Triggerable" to null', ->
      @defaulter.dispose()
      expect(@defaulter.triggerable).to.be null

    it 'does not toss an error if disposing multiple times', ->
      @defaulter.dispose()
      @defaulter.dispose()
      expect(@defaulter.dispose).not.to.throwException()


  describe '#addListeners', ->
    it 'adds a listener for "click" event', ->
      spy = sinon.spy @defaulter, 'activated'
      @defaulter_el.click()
      expect(spy.called).to.be.ok()

    it 'adds a listener for "hover" event', ->
      spy = sinon.spy @hoverer, 'deactivated'
      @hover_el.trigger('mouseenter')
      @hover_el.trigger('mouseleave')
      expect(spy.called).to.be.ok()


  describe '#removeListeners', ->
    it 'removes a listener for "click" event', ->
      spy = sinon.spy @defaulter, 'activated'
      @defaulter.removeListeners()
      @defaulter_el.click()
      expect(spy.called).not.to.be.ok()

    it 'removes a listener for "hover" event', ->
      spy = sinon.spy @hoverer, 'deactivated'
      @hoverer.removeListeners()
      @hover_el.trigger('mouseenter')
      @hover_el.trigger('mouseleave')
      expect(spy.called).not.to.be.ok()


  describe '#activated', ->
    it 'adds the toggle_classes on "click"', ->
      @defaulter_el.click()
      expect(@defaulter_el.hasClass('active')).to.be true

    it 'adds the custom toggle_classes on "hover"', ->
      @hover_el.mouseenter()
      expect(@hover_el.hasClass('active on')).to.be true

    it 'adds the toggle_classes on "focus"', ->
      @focus_el.focus()
      expect(@focus_el.hasClass('active')).to.be true

    it 'adds the toggle_classes on "click" with a delay', (done) ->
      # override the delay to speed up the tests.
      @delayer.triggerable.delay.activate = 50
      @delayer.triggerable.delay.deactivate = 50
      @delay_el.click()
      expect(@delay_el.hasClass('active')).to.be false
      setTimeout(( =>
        expect(@delay_el.hasClass('active')).to.be true
        done()
      ), 50)

    it 'dispatches an "activated" event from the element', ->
      @defaulter_el.on('toggle:activated', => @noop arguments...)
      spy = sinon.spy @, 'noop'
      @defaulter_el.click()
      expect(spy.called).to.be.ok()
      expect(@element.html()).to.be @defaulter_el.html()


  describe '#deactivated', ->
    it 'removes the toggle_classes on "click"', ->
      @defaulter_el.click()
      expect(@defaulter_el.hasClass('active')).to.be true
      @defaulter_el.click()
      expect(@defaulter_el.hasClass('active')).to.be false

    it 'removes the custom toggle_classes on "hover"', ->
      @hover_el.mouseenter()
      expect(@hover_el.hasClass('active on')).to.be true
      @hover_el.mouseleave()
      expect(@hover_el.hasClass('active on')).to.be false

    it 'removes the toggle_classes on "focus"', ->
      @focus_el.focus()
      expect(@focus_el.hasClass('active')).to.be true
      @focus_el.blur()
      expect(@focus_el.hasClass('active')).to.be false

    it 'removes the toggle_classes on "click" with a delay', (done) ->
      # override the delay to speed up the tests.
      @delayer.triggerable.delay.activate = 50
      @delayer.triggerable.delay.deactivate = 50
      @delayer.activate()
      expect(@delay_el.hasClass('active')).to.be true
      @delay_el.click()
      expect(@delay_el.hasClass('active')).to.be true
      setTimeout(( =>
        expect(@delay_el.hasClass('active')).to.be false
        done()
      ), 50)

    it 'dispatches a "deactivated" event from the element', ->
      @defaulter_el.on('toggle:deactivated', => @noop arguments...)
      spy = sinon.spy @, 'noop'
      @defaulter_el.click()
      @defaulter_el.click()
      expect(spy.called).to.be.ok()
      expect(@element.html()).to.be @defaulter_el.html()

