#= require utensils/triggerable
fixture.preload 'triggerable/markup/triggerable'

describe 'Triggerable', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    fixture.load 'triggerable/markup/triggerable'
    @dom = $(fixture.el)

    @defaulter_el = @dom.find('#triggerable_1')
    @hover_el = @dom.find('#triggerable_2')
    @focus_el = @dom.find('#triggerable_3')
    @delay_el = @dom.find('#triggerable_4')
    @disabled_el = @dom.find('#triggerable_5')
    @radios_el = @dom.find('#triggerable_radios')
    @checks_el = @dom.find('#triggerable_checks')

    @defaulter = new utensils.Triggerable(@defaulter_el)
    @hoverer = new utensils.Triggerable(@hover_el)
    @focuser = new utensils.Triggerable(@focus_el)
    @delayer = new utensils.Triggerable(@delay_el)
    @disabler = new utensils.Triggerable(@disabled_el)
    @radio = new utensils.Triggerable(@radios_el)
    @check = new utensils.Triggerable(@checks_el)


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@defaulter.data).not.to.be undefined


  describe '#options', ->
    it 'sets default data.namespace', ->
      expect(@defaulter.data.namespace).to.be 'triggerable'

    it 'overrides the default data.namespace via a data attribute', ->
      expect(@hoverer.data.namespace).to.be 'hoverable'

    it 'sets the default data.trigger type to "click"', ->
      expect(@defaulter.data.trigger).to.be 'click'

    it 'overrides the default data.trigger type based on hover', ->
      expect(@hoverer.data.trigger).to.be 'hover'


  describe '#initialize', ->
    it 'sets up a dispatcher property on the element', ->
      expect(@defaulter.dispatcher.html()).to.be @defaulter_el.html()

    it 'sets up a dispatcher property on the radio group', ->
      expect(@radio.dispatcher.html()).to.be @radios_el.html()

    it 'sets up a dispatcher property on the check group', ->
      expect(@check.dispatcher.html()).to.be @checks_el.html()

    it 'does not stop propagation by default', ->
      expect(@radio.stop_propagation).to.be false

    it 'sets default namespace', ->
      expect(@defaulter.namespace).to.be 'triggerable'

    it 'overrides the default namespace via a data attribute', ->
      expect(@hoverer.namespace).to.be 'hoverable'

    it 'sets the default trigger type to "click.namespace"', ->
      expect(@defaulter.trigger_type).to.eql(on:'click.triggerable', off:'click.triggerable')

    it 'overrides the default trigger type based on a hover "hover.namespace"', ->
      expect(@hoverer.trigger_type).to.eql(on:'mouseenter.hoverable focus.hoverable', off:'mouseleave.hoverable blur.hoverable')

    it 'does not call #setDelay if there are is no delay attribute', ->
      expect(@defaulter.data.delay).to.be undefined
      expect(@defaulter.setActivate).to.be @defaulter.setActivate
      expect(@defaulter.setDeactivate).to.be @defaulter.setDeactivate

    it 'calls #setDelay if there are is a delay attribute', ->
      expect(@delayer.delay).to.eql(activate:100, deactivate:100)
      expect(@delayer.setActivate).to.be @delayer.activateWithDelay
      expect(@delayer.setDeactivate).to.be @delayer.deactivateWithDelay

    it 'defaults is_active to false', ->
      expect(@defaulter.is_active).to.be false

    it 'sets the disabled property', ->
      expect(@defaulter.is_disabled).to.be false
      expect(@disabler.is_disabled).to.be true


  describe '#toggle', ->
    it 'toggles the is_active property on a "click"', ->
      @defaulter_el.click()
      expect(@defaulter.is_active).to.be true
      @defaulter_el.click()
      expect(@defaulter.is_active).to.be false

    it 'calls the #setActivate method on "click"', ->
      spy = sinon.spy @defaulter, 'setActivate'
      @defaulter_el.click()
      expect(spy.called).to.be.ok()

    it 'calls the #setDeactivate method on "click"', ->
      spy = sinon.spy @defaulter, 'setDeactivate'
      @defaulter.is_active = true
      @defaulter_el.click()
      expect(spy.called).to.be.ok()

    it 'bails if the element is disabled', ->
      spy = sinon.spy @disabler, 'setActivate'
      @disabled_el.click()
      expect(spy.called).not.to.be.ok()


  describe '#activate', ->
    it 'dispatches a "triggerable:trigger" event on activation', ->
      @defaulter.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @defaulter.activate(target:null)
      expect(spy.called).to.be.ok()
      expect(@defaulter.is_active).to.be true

    it 'dispatches a "triggerable:activate" event', ->
      @defaulter.dispatcher.on('triggerable:activate', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @defaulter.activate(target:null)
      expect(spy.called).to.be.ok()
      expect(@defaulter.is_active).to.be true

    it 'passes the link element which triggered the activation event', ->
      @defaulter.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @defaulter_el.click()
      expect(spy.called).to.be.ok()
      expect(@element.html()).to.be @defaulter_el.html()

    it 'passes the appropriate targets when selected from a radio group', ->
      link = @radios_el.find('li a').first()
      @radio.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      link.click()
      expect(spy.called).to.be.ok()
      expect(@element.html()).to.be link.html()
      expect($(@event.target).html()).to.be @radios_el.html()

    it 'bails if the element is disabled', ->
      spy = sinon.spy @disabler, 'clearTimeout'
      @disabler.activate()
      expect(spy.called).not.to.be.ok()


  describe '#deactivate', ->
    it 'dispatches a "triggerable:trigger" event on deactivation', ->
      @defaulter.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @defaulter.deactivate(target:null)
      expect(spy.called).to.be.ok()
      expect(@defaulter.is_active).to.be false

    it 'dispatches a "triggerable:deactivate" event', ->
      @defaulter.dispatcher.on('triggerable:deactivate', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @defaulter.deactivate(target:null)
      expect(spy.called).to.be.ok()
      expect(@defaulter.is_active).to.be false

    it 'passes the link element which triggered the deactivation event', ->
      @defaulter.dispatcher.on('triggerable:deactivate', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @defaulter_el.click()
      @defaulter_el.click()
      expect(spy.called).to.be.ok()
      expect(@element.html()).to.be @defaulter_el.html()

    it 'passes the appropriate targets when selected from a check group', ->
      link = @checks_el.find('li a').first()
      @check.dispatcher.on('triggerable:deactivate', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      link.click()
      link.click()
      expect(spy.called).to.be.ok()
      expect(@element.html()).to.be link.html()
      expect($(@event.target).html()).to.be @checks_el.html()

    it 'bails if the element is disabled', ->
      spy = sinon.spy @disabler, 'clearTimeout'
      @disabler.deactivate()
      expect(spy.called).not.to.be.ok()


  describe '#dispose', ->
    it 'cleans up its own mess', ->
      spy = sinon.spy @defaulter, 'toggle'
      @defaulter.dispose()
      @defaulter_el.click()
      expect(spy.called).not.to.be.ok()

    it 'removes any timeouts for delay triggerables', ->
      @delayer.dispose()
      expect(@delayer.timeout).to.be null

    it 'does not call removeListeners when event type is manual since no listeners are added', ->
      spyme = new utensils.Triggerable(@dom, trigger:'manual')
      spy = sinon.spy spyme, 'removeListeners'
      spyme.dispose()
      expect(spy.called).not.to.be.ok()


  describe '#addListeners', ->
    it 'adds a listener for "click event"', ->
      @defaulter.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @defaulter_el.click()
      expect(spy.called).to.be.ok()

    it 'adds a listener for "hover" on mouse enter', ->
      @hoverer.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @hover_el.trigger('mouseenter')
      expect(spy.called).to.be.ok()

    it 'adds a listener for "hover" on mouse leave', ->
      @hoverer.dispatcher.on('triggerable:deactivate', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @hover_el.trigger('mouseenter')
      @hover_el.trigger('mouseleave')
      expect(spy.called).to.be.ok()

    it 'adds a listener for "focus"', ->
      @focuser.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @focus_el.trigger('focus')
      expect(spy.called).to.be.ok()

    it 'adds a listener for "blur" on focus out', ->
      @focuser.dispatcher.on('triggerable:deactivate', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @focus_el.trigger('focus')
      @focus_el.trigger('blur')
      expect(spy.called).to.be.ok()


  describe '#removeListeners', ->
    it 'removes a listener for "click event"', ->
      @defaulter.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @defaulter.removeListeners()
      @defaulter_el.click()
      expect(spy.called).not.to.be.ok()

    it 'removes a listener for "hover" on mouse enter', ->
      @hoverer.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @hoverer.removeListeners()
      @hover_el.trigger('mouseenter')
      expect(spy.called).not.to.be.ok()

    it 'removes a listener for "hover" on mouse leave', ->
      @hoverer.dispatcher.on('triggerable:deactivate', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @hoverer.removeListeners()
      @hover_el.trigger('mouseenter')
      @hover_el.trigger('mouseleave')
      expect(spy.called).not.to.be.ok()

    it 'removes a listener for "focus"', ->
      @focuser.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @focuser.removeListeners()
      @focus_el.trigger('focus')
      expect(spy.called).not.to.be.ok()

    it 'removes a listener for "blur" on focus out', ->
      @focuser.dispatcher.on('triggerable:deactivate', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @focuser.removeListeners()
      @focus_el.trigger('focus')
      @focus_el.trigger('blur')
      expect(spy.called).not.to.be.ok()


  describe '#activateWithDelay', ->
    it 'activates a triggerable element after a delay', (done) ->
      # override the delay to speed up the tests.
      @delayer.delay.activate = 50
      @delayer.delay.deactivate = 50
      @delayer.dispatcher.on('triggerable:activate', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @delay_el.click()
      expect(spy.called).not.to.be.ok()
      setTimeout(( =>
        expect(spy.called).to.be.ok()
        expect(@delayer.timeout).to.be null
        done()
      ), 50)


  describe '#deactivateWithDelay', ->
    it 'deactivates a triggerable element after a delay', (done) ->
      # override the delay to speed up the tests.
      @delayer.delay.activate = 50
      @delayer.delay.deactivate = 50
      @delayer.dispatcher.on('triggerable:deactivate', => @noop arguments...)
      @delayer.activate(target: null)
      spy = sinon.spy this, 'noop'
      @delay_el.click()
      expect(spy.called).not.to.be.ok()

      setTimeout(( =>
        expect(spy.called).to.be.ok()
        expect(@delayer.timeout).to.be null
        done()
      ), 50)


  describe '#setDelay', ->
    it 'reports a triggerable element has delays', ->
      expect(@delayer.delay).not.to.be undefined
      expect(@defaulter.delay).to.be undefined

    it 'creates a timeout property when needed', ->
      expect(@delayer.timeout).not.to.be undefined
      expect(@defaulter.timeout).to.be undefined

    it 'hijacks the #setActivate function with #activateWithDelay', ->
      expect(@delayer.setActivate).to.be @delayer.activateWithDelay

    it 'hijacks the #setDeactivate function with #deactivateWithDelay', ->
      expect(@delayer.setDeactivate).to.be @delayer.deactivateWithDelay


  describe '#setTriggerEventTypes', ->
    it 'sets different event types for on and off from hover', ->
      type = @defaulter.setTriggerEventTypes('hover')
      expect(type).to.eql(on:'mouseenter.triggerable focus.triggerable', off:'mouseleave.triggerable blur.triggerable')

    it 'sets different event types for on and off from focus', ->
      type = @defaulter.setTriggerEventTypes('focus')
      expect(type).to.eql(on:'focus.triggerable', off:'blur.triggerable')

    it 'sets the same event types for on and off from click', ->
      type = @defaulter.setTriggerEventTypes('click')
      expect(type).to.eql(on:'click.triggerable', off:'click.triggerable')

    it 'sets the same event types for on and off from manual', ->
      type = @defaulter.setTriggerEventTypes('manual')
      expect(type).to.eql(on:'manual', off:'manual')

