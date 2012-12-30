#= require utensils/toggle

describe 'Toggle', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    loadFixtures('toggle/markup/toggle')
    @dom = $('#teabag-fixtures')

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


  xdescribe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('toggle')).toEqual(utensils.Toggle)


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@defaulter.data).toBeDefined()

    it 'auto activates an element from a data attribute', ->
      expect(@auto_el).toHaveClass('active')

  describe '#options', ->
    it 'sets default namespace', ->
      expect(@defaulter.data.namespace).toEqual('toggle')

    it 'overrides the default namespace via a data attribute', ->
      expect(@hoverer.data.namespace).toEqual('hoverable')

    it 'sets the default data.toggle state to "active"', ->
      expect(@defaulter.data.toggle).toEqual('active')

    it 'overrides the default data.toggle state to "active on"', ->
      expect(@hoverer.data.toggle).toEqual('active on')


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@defaulter.namespace).toEqual('toggle')

    it 'overrides the default namespace via a data attribute', ->
      expect(@hoverer.namespace).toEqual('hoverable')

    it 'sets the default toggle state to "active"', ->
      expect(@defaulter.toggle_classes).toEqual('active')

    it 'overrides the default toggle state to "active on"', ->
      expect(@hoverer.toggle_classes).toEqual('active on')

    it 'creates an instance of "Triggerable"', ->
      expect(@defaulter.triggerable instanceof utensils.Triggerable).toEqual(true)


  describe '#toggle', ->
    it 'calls through #toggle on the "Triggerable" instance', ->
      spyEvent = spyOn(@defaulter.triggerable, 'toggle')
      @defaulter_el.click()
      expect(spyEvent).toHaveBeenCalled()


  describe '#activate', ->
    it 'calls through #activate on the "Triggerable" instance', ->
      spyEvent = spyOn(@defaulter.triggerable, 'activate')
      @defaulter_el.click()
      expect(spyEvent).toHaveBeenCalled()


  describe '#deactivate', ->
    it 'calls through #deactivate on the "Triggerable" instance', ->
      spyEvent = spyOn(@defaulter.triggerable, 'deactivate')
      @defaulter_el.click()
      @defaulter_el.click()
      expect(spyEvent).toHaveBeenCalled()


  describe '#dispose', ->
    it 'removes its own listeners', ->
      spyEvent = spyOn(@defaulter, 'removeListeners')
      @defaulter.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'calls through #dispose on the "Triggerable" instance', ->
      spyEvent = spyOn(@defaulter.triggerable, 'dispose')
      @defaulter.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'sets the instance of "Triggerable" to null', ->
      @defaulter.dispose()
      expect(@defaulter.triggerable).toBeNull()

    it 'does not toss an error if disposing multiple times', ->
      @defaulter.dispose()
      @defaulter.dispose()
      expect(@defaulter.dispose).not.toThrow()


  describe '#addListeners', ->
    it 'adds a listener for "click" event', ->
      spyEvent = spyOn(@defaulter, 'activated')
      @defaulter_el.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'adds a listener for "hover" event', ->
      spyEvent = spyOn(@hoverer, 'deactivated')
      @hover_el.trigger('mouseenter')
      @hover_el.trigger('mouseleave')
      expect(spyEvent).toHaveBeenCalled()


  describe '#removeListeners', ->
    it 'removes a listener for "click" event', ->
      spyEvent = spyOn(@defaulter, 'activated')
      @defaulter.removeListeners()
      @defaulter_el.click()
      expect(spyEvent).not.toHaveBeenCalled()

    it 'removes a listener for "hover" event', ->
      spyEvent = spyOn(@hoverer, 'deactivated')
      @hoverer.removeListeners()
      @hover_el.trigger('mouseenter')
      @hover_el.trigger('mouseleave')
      expect(spyEvent).not.toHaveBeenCalled()


  describe '#activated', ->
    it 'adds the toggle_classes on "click"', ->
      @defaulter_el.click()
      expect(@defaulter_el).toHaveClass('active')

    it 'adds the custom toggle_classes on "hover"', ->
      @hover_el.mouseenter()
      expect(@hover_el).toHaveClass('active on')

    it 'adds the toggle_classes on "focus"', ->
      @focus_el.focus()
      expect(@focus_el).toHaveClass('active')

    it 'adds the toggle_classes on "click" with a delay', ->
      # override the delay to speed up the tests.
      @delayer.triggerable.delay.activate = 50
      @delayer.triggerable.delay.deactivate = 50
      runs ->
        @delay_el.click()
        expect(@delay_el).not.toHaveClass('active')
      waits 50
      runs ->
        expect(@delay_el).toHaveClass('active')

    it 'dispatches an "activated" event from the element', ->
      @defaulter_el.on('toggle:activated', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @defaulter_el.click()
      expect(spyEvent).toHaveBeenCalled()
      expect(@element).toBe(@defaulter_el)


  describe '#deactivated', ->
    it 'removes the toggle_classes on "click"', ->
      @defaulter_el.click()
      expect(@defaulter_el).toHaveClass('active')
      @defaulter_el.click()
      expect(@defaulter_el).not.toHaveClass('active')

    it 'removes the custom toggle_classes on "hover"', ->
      @hover_el.mouseenter()
      expect(@hover_el).toHaveClass('active on')
      @hover_el.mouseleave()
      expect(@hover_el).not.toHaveClass('active on')

    it 'removes the toggle_classes on "focus"', ->
      @focus_el.focus()
      expect(@focus_el).toHaveClass('active')
      @focus_el.blur()
      expect(@focus_el).not.toHaveClass('active')

    it 'removes the toggle_classes on "click" with a delay', ->
      # override the delay to speed up the tests.
      @delayer.triggerable.delay.activate = 50
      @delayer.triggerable.delay.deactivate = 50
      @delayer.activate()
      expect(@delay_el).toHaveClass('active')
      runs ->
        @delay_el.click()
        expect(@delay_el).toHaveClass('active')
      waits 50
      runs ->
        expect(@delay_el).not.toHaveClass('active')

    it 'dispatches a "deactivated" event from the element', ->
      @defaulter_el.on('toggle:deactivated', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @defaulter_el.click()
      @defaulter_el.click()
      expect(spyEvent).toHaveBeenCalled()
      expect(@element).toBe(@defaulter_el)

