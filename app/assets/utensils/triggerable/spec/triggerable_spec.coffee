
#= require utensils/triggerable

describe 'Triggerable', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    loadFixtures('triggerable')
    @dom = $('#jasmine-fixtures')

    @defaulter_el = @dom.find('#triggerable_1')
    @hover_el = @dom.find('#triggerable_2')
    @focus_el = @dom.find('#triggerable_3')
    @delay_el = @dom.find('#triggerable_4')
    @radios_el = @dom.find('#triggerable_radios')
    @checks_el = @dom.find('#triggerable_checks')

    @defaulter = new utensils.Triggerable(@defaulter_el)
    @hoverer = new utensils.Triggerable(@hover_el)
    @focuser = new utensils.Triggerable(@focus_el)
    @delayer = new utensils.Triggerable(@delay_el)
    @radio = new utensils.Triggerable(@radios_el)
    @check = new utensils.Triggerable(@checks_el)


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@defaulter.data).toBeDefined()


  describe '#options', ->
    it 'sets default data.namespace', ->
      expect(@defaulter.data.namespace).toEqual('triggerable')

    it 'overrides the default data.namespace via a data attribute', ->
      expect(@hoverer.data.namespace).toEqual('hoverable')

    it 'sets the default data.trigger type to "click"', ->
      expect(@defaulter.data.trigger).toEqual('click')

    it 'overrides the default data.trigger type based on hover', ->
      expect(@hoverer.data.trigger).toEqual('hover')


  describe '#initialize', ->
    it 'sets up a dispatcher property on the element', ->
      expect(@defaulter.dispatcher).toEqual(@defaulter_el)

    it 'sets up a dispatcher property on the radio group', ->
      expect(@radio.dispatcher).toEqual(@radios_el)

    it 'sets up a dispatcher property on the check group', ->
      expect(@check.dispatcher).toEqual(@checks_el)

    it 'does not stop propagation by default', ->
      expect(@radio.stop_propagation).toEqual(false)

    it 'sets default namespace', ->
      expect(@defaulter.namespace).toEqual('triggerable')

    it 'overrides the default namespace via a data attribute', ->
      expect(@hoverer.namespace).toEqual('hoverable')

    it 'sets the default trigger type to "click.namespace"', ->
      expect(@defaulter.trigger_type).toEqual(on:'click.triggerable', off:'click.triggerable')

    it 'overrides the default trigger type based on a hover "hover.namespace"', ->
      expect(@hoverer.trigger_type).toEqual(on:'mouseenter.hoverable focus.hoverable', off:'mouseleave.hoverable blur.hoverable')

    it 'does not call #setDelay if there are is no delay attribute', ->
      expect(@defaulter.data.delay).toBeUndefined()
      expect(@defaulter.setActivate).toBe(@defaulter.setActivate)
      expect(@defaulter.setDeactivate).toBe(@defaulter.setDeactivate)

    it 'calls #setDelay if there are is a delay attribute', ->
      expect(@delayer.delay).toEqual({activate:100, deactivate:100})
      expect(@delayer.setActivate).toBe(@delayer.activateWithDelay)
      expect(@delayer.setDeactivate).toBe(@delayer.deactivateWithDelay)

    it 'defaults is_active to false', ->
      expect(@defaulter.is_active).toEqual(false)


  describe '#toggle', ->
    it 'toggles the is_active property on a "click"', ->
      @defaulter_el.click()
      expect(@defaulter.is_active).toEqual(true)
      @defaulter_el.click()
      expect(@defaulter.is_active).toEqual(false)

    it 'calls the #setActivate method on "click"', ->
      spyEvent = spyOn(@defaulter, 'setActivate')
      @defaulter_el.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'calls the #setDeactivate method on "click"', ->
      spyEvent = spyOn(@defaulter, 'setDeactivate')
      @defaulter.is_active = true
      @defaulter_el.click()
      expect(spyEvent).toHaveBeenCalled()


  describe '#activate', ->
    it 'dispatches a "triggerable:trigger" event on activation', ->
      @defaulter.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spyEvent = spyOn(this, 'noop')
      @defaulter.activate(target:null)
      expect(spyEvent).toHaveBeenCalled()
      expect(@defaulter.is_active).toEqual(true)

    it 'dispatches a "triggerable:activate" event', ->
      @defaulter.dispatcher.on('triggerable:activate', => @noop arguments...)
      spyEvent = spyOn(this, 'noop')
      @defaulter.activate(target:null)
      expect(spyEvent).toHaveBeenCalled()
      expect(@defaulter.is_active).toEqual(true)

    it 'passes the link element which triggered the activation event', ->
      @defaulter.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @defaulter_el.click()
      expect(spyEvent).toHaveBeenCalled()
      expect(@element).toBe(@defaulter_el)

    it 'passes the appropriate targets when selected from a radio group', ->
      link = @radios_el.find('li a').first()
      @radio.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      link.click()
      expect(spyEvent).toHaveBeenCalled()
      expect(@element).toBe(link)
      expect($(@event.target)).toBe(@radios_el)


  describe '#deactivate', ->
    it 'dispatches a "triggerable:trigger" event on deactivation', ->
      @defaulter.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spyEvent = spyOn(this, 'noop')
      @defaulter.deactivate(target:null)
      expect(spyEvent).toHaveBeenCalled()
      expect(@defaulter.is_active).toEqual(false)

    it 'dispatches a "triggerable:deactivate" event', ->
      @defaulter.dispatcher.on('triggerable:deactivate', => @noop arguments...)
      spyEvent = spyOn(this, 'noop')
      @defaulter.deactivate(target:null)
      expect(spyEvent).toHaveBeenCalled()
      expect(@defaulter.is_active).toEqual(false)

    it 'passes the link element which triggered the deactivation event', ->
      @defaulter.dispatcher.on('triggerable:deactivate', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @defaulter_el.click()
      @defaulter_el.click()
      expect(spyEvent).toHaveBeenCalled()
      expect(@element).toBe(@defaulter_el)

    it 'passes the appropriate targets when selected from a check group', ->
      link = @checks_el.find('li a').first()
      @check.dispatcher.on('triggerable:deactivate', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      link.click()
      link.click()
      expect(spyEvent).toHaveBeenCalled()
      expect(@element).toBe(link)
      expect($(@event.target)).toBe(@checks_el)


  describe '#dispose', ->
    it 'cleans up its own mess', ->
      spyEvent = spyOn(@defaulter, 'toggle')
      @defaulter.dispose()
      @defaulter_el.click()
      expect(spyEvent).not.toHaveBeenCalled()

    it 'removes any timeouts for delay triggerables', ->
      @delayer.dispose()
      expect(@delayer.timeout).toBeNull()

    it 'does not call removeListeners when event type is manual since no listeners are added', ->
      spyme = new utensils.Triggerable(@dom, trigger:'manual')
      spyEvent = spyOn(spyme, 'removeListeners')
      spyme.dispose()
      expect(spyEvent).not.toHaveBeenCalled()


  describe '#addListeners', ->
    it 'adds a listener for "click event"', ->
      @defaulter.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spyEvent = spyOn(this, 'noop')
      @defaulter_el.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'adds a listener for "hover" on mouse enter', ->
      @hoverer.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spyEvent = spyOn(this, 'noop')
      @hover_el.trigger('mouseenter')
      expect(spyEvent).toHaveBeenCalled()

    it 'adds a listener for "hover" on mouse leave', ->
      @hoverer.dispatcher.on('triggerable:deactivate', => @noop arguments...)
      spyEvent = spyOn(this, 'noop')
      @hover_el.trigger('mouseenter')
      @hover_el.trigger('mouseleave')
      expect(spyEvent).toHaveBeenCalled()

    it 'adds a listener for "focus"', ->
      @focuser.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spyEvent = spyOn(this, 'noop')
      @focus_el.trigger('focus')
      expect(spyEvent).toHaveBeenCalled()

    it 'adds a listener for "blur" on focus out', ->
      @focuser.dispatcher.on('triggerable:deactivate', => @noop arguments...)
      spyEvent = spyOn(this, 'noop')
      @focus_el.trigger('focus')
      @focus_el.trigger('blur')
      expect(spyEvent).toHaveBeenCalled()


  describe '#removeListeners', ->
    it 'removes a listener for "click event"', ->
      @defaulter.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spyEvent = spyOn(this, 'noop')
      @defaulter.removeListeners()
      @defaulter_el.click()
      expect(spyEvent).not.toHaveBeenCalled()

    it 'removes a listener for "hover" on mouse enter', ->
      @hoverer.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spyEvent = spyOn(this, 'noop')
      @hoverer.removeListeners()
      @hover_el.trigger('mouseenter')
      expect(spyEvent).not.toHaveBeenCalled()

    it 'removes a listener for "hover" on mouse leave', ->
      @hoverer.dispatcher.on('triggerable:deactivate', => @noop arguments...)
      spyEvent = spyOn(this, 'noop')
      @hoverer.removeListeners()
      @hover_el.trigger('mouseenter')
      @hover_el.trigger('mouseleave')
      expect(spyEvent).not.toHaveBeenCalled()

    it 'removes a listener for "focus"', ->
      @focuser.dispatcher.on('triggerable:trigger', => @noop arguments...)
      spyEvent = spyOn(this, 'noop')
      @focuser.removeListeners()
      @focus_el.trigger('focus')
      expect(spyEvent).not.toHaveBeenCalled()

    it 'removes a listener for "blur" on focus out', ->
      @focuser.dispatcher.on('triggerable:deactivate', => @noop arguments...)
      spyEvent = spyOn(this, 'noop')
      @focuser.removeListeners()
      @focus_el.trigger('focus')
      @focus_el.trigger('blur')
      expect(spyEvent).not.toHaveBeenCalled()


  describe '#activateWithDelay', ->
    it 'activates a triggerable element after a delay', ->
      # override the delay to speed up the tests.
      @delayer.delay.activate = 50
      @delayer.delay.deactivate = 50
      @delayer.dispatcher.on('triggerable:activate', => @noop arguments...)
      spyEvent = spyOn(this, 'noop')

      runs ->
        @delay_el.click()
        expect(spyEvent).not.toHaveBeenCalled()
      waits 50
      runs ->
        expect(spyEvent).toHaveBeenCalled()
        expect(@delayer.timeout).toBeNull()


  describe '#deactivateWithDelay', ->
    it 'deactivates a triggerable element after a delay', ->
      # override the delay to speed up the tests.
      @delayer.delay.activate = 50
      @delayer.delay.deactivate = 50
      @delayer.dispatcher.on('triggerable:deactivate', => @noop arguments...)
      @delayer.activate(target: null)
      spyEvent = spyOn(this, 'noop')

      runs ->
        @delay_el.click()
        expect(spyEvent).not.toHaveBeenCalled()
      waits 50
      runs ->
        expect(spyEvent).toHaveBeenCalled()
        expect(@delayer.timeout).toBeNull()


  describe '#setDelay', ->
    it 'reports a triggerable element has delays', ->
      expect(@delayer.delay).toBeDefined()
      expect(@defaulter.delay).not.toBeDefined()

    it 'creates a timeout property when needed', ->
      expect(@delayer.timeout).toBeDefined()
      expect(@defaulter.timeout).not.toBeDefined()

    it 'hijacks the #setActivate function with #activateWithDelay', ->
      expect(@delayer.setActivate).toBe(@delayer.activateWithDelay)

    it 'hijacks the #setDeactivate function with #deactivateWithDelay', ->
      expect(@delayer.setDeactivate).toBe(@delayer.deactivateWithDelay)


  describe '#setTriggerEventTypes', ->
    it 'sets different event types for on and off from hover', ->
      type = @defaulter.setTriggerEventTypes('hover')
      expect(type).toEqual(on:'mouseenter.triggerable focus.triggerable', off:'mouseleave.triggerable blur.triggerable')

    it 'sets different event types for on and off from focus', ->
      type = @defaulter.setTriggerEventTypes('focus')
      expect(type).toEqual(on:'focus.triggerable', off:'blur.triggerable')

    it 'sets the same event types for on and off from click', ->
      type = @defaulter.setTriggerEventTypes('click')
      expect(type).toEqual(on:'click.triggerable', off:'click.triggerable')

    it 'sets the same event types for on and off from manual', ->
      type = @defaulter.setTriggerEventTypes('manual')
      expect(type).toEqual(on:'manual', off:'manual')

