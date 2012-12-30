#= require utensils/detect
#= require utensils/collapse

describe 'Collapse', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    fixture.load('collapse/markup/collapse')
    @dom = $(fixture.el)

    @collapse_el = @dom.find('[href=#collapse_height]')
    @auto_el = @dom.find('[data-target=#collapse_auto]')
    @collapse_panel = @dom.find('#collapse_height')
    @auto_panel = @dom.find('#collapse_auto')

    @radio_el = @dom.find('#collapse_radio')
    @check_el = @dom.find('#collapse_checkbox')
    @external_el = @dom.find('#collapse_external')

    @collapse = new utensils.Collapse(@collapse_el)
    @auto = new utensils.Collapse(@auto_el)
    @radio = new utensils.Collapse(@radio_el)
    @check = new utensils.Collapse(@check_el)
    @external = new utensils.Collapse(@external_el)

  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('collapse')).toEqual(utensils.Collapse)


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@collapse.data).toBeDefined()

    xit 'auto activates an element from a data attribute for a single collapse', ->
      expect(@auto_el).toHaveClass('active')
      expect(@auto_panel).toHaveClass('in')

    xit 'auto activates an element from a data attribute for a group collapse', ->
      expect(@radio_el.find('li:first-child')).toHaveClass('active')
      expect(@radio_el.find('#collapse_radio_1')).toHaveClass('in')


  describe '#options', ->
    it 'sets default data.namespace', ->
      expect(@collapse.data.namespace).toEqual('collapse')

    it 'sets the default data.dimension', ->
      expect(@collapse.data.dimension).toEqual('height')


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@collapse.namespace).toEqual('collapse')

    it 'sets default dimension', ->
      expect(@collapse.dimension).toEqual('height')


  xdescribe '#activate', ->
    it 'calls the #activateIndex method on the toggler for a single collapse', ->
      spyEvent = spyOn(@collapse.toggler, 'activateIndex')
      @collapse.activateIndex()
      expect(spyEvent).toHaveBeenCalled()

    it 'opens the panel on a public call to #activate for a single collapse', ->
      expect(@collapse_panel).not.toHaveClass('in')
      @collapse.activate()
      expect(@collapse_panel).toHaveClass('in')

    xit 'calls the #activate method on the toggler for a group collapse', ->
      spyEvent = spyOn(@check.toggler, 'activate')
      @check.activate(1)
      expect(spyEvent).toHaveBeenCalled()

    it 'opens the panel on a public call to #activate for a group collapse', ->
      panel = @check_el.find('#collapse_check_1')
      expect(panel).not.toHaveClass('in')
      @check.activate(0)
      expect(panel).toHaveClass('in')


  xdescribe '#deactivate', ->
    it 'calls the #deactivate method on the toggler for a single collapse', ->
      spyEvent = spyOn(@collapse.toggler, 'deactivate')
      @collapse.deactivate()
      expect(spyEvent).toHaveBeenCalled()

    it 'closes the panel on a public call to #deactivate for a single collapse', ->
      expect(@auto_panel).toHaveClass('in')
      @auto.deactivate()
      expect(@auto_el).not.toHaveClass('active')
      expect(@auto_panel).not.toHaveClass('in')

    it 'calls the #deactivate method on the toggler for a group collapse', ->
      @check.activate(0)
      spyEvent = spyOn(@check.toggler, 'deactivate')
      @check.deactivate(0)
      expect(spyEvent).toHaveBeenCalled()

    it 'closes the panel on a public call to #deactivate for a group collapse', ->
      panel = @check_el.find('#collapse_check_1')
      expect(panel).not.toHaveClass('in')
      @check.activate(0)
      expect(panel).toHaveClass('in')
      @check.deactivate(0)
      expect(panel).not.toHaveClass('in')


  xdescribe '#dispose', ->
    it 'removes its own listeners for a single collapse', ->
      spyEvent = spyOn(@collapse, 'removeListeners')
      @collapse.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'calls through #dispose on the "Toggle" instance for a single collapse', ->
      spyEvent = spyOn(@collapse.toggler, 'dispose')
      @collapse.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'sets the instance of "Toggle" to null for a single collapse', ->
      @collapse.dispose()
      expect(@collapse.toggler).toBeNull()

    it 'removes its own listeners for a group collapse', ->
      spyEvent = spyOn(@check, 'removeListeners')
      @check.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'calls through #dispose on the "ToggleGroup" instance for a group collapse', ->
      spyEvent = spyOn(@check.toggler, 'dispose')
      @check.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'sets the instance of "ToggleGroup" to null for a group collapse', ->
      @radio.dispose()
      expect(@radio.toggler).toBeNull()

    it 'does not freak out when calling multiple disposals', ->
      @radio.dispose()
      @radio.dispose()
      expect(@radio.dispose).not.toThrow()


  xdescribe '#addListeners', ->
    it 'adds a listener for "click" event for a single collapse', ->
      spyEvent = spyOn(@collapse, 'activated')
      @collapse_el.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'adds a listener for "click" event for a group collapse', ->
      spyEvent = spyOn(@check, 'activated')
      @check_el.find('li:first-child > a').click()
      expect(spyEvent).toHaveBeenCalled()


  xdescribe '#removeListeners', ->
    it 'removes a listener for "click" event for a single collapse', ->
      spyEvent = spyOn(@collapse, 'activated')
      @collapse.removeListeners()
      @collapse_el.click()
      expect(spyEvent).not.toHaveBeenCalled()

    it 'removes a listener for "click" event for a group collapse', ->
      spyEvent = spyOn(@check, 'activated')
      @check.removeListeners()
      @check_el.find('li:first-child > a').click()
      expect(spyEvent).not.toHaveBeenCalled()


  xdescribe '#activated', ->
    it 'expands the height of a collapse panel', ->
      @collapse_el.click()
      expect(@collapse_panel.height()).toBeGreaterThan(0)


  xdescribe '#deactivated', ->
    it 'contracts the height of a collapse panel', ->
      @auto_el.click()
      expect(@auto_panel.height()).toBe(0)


  xdescribe '#triggered', ->
    it 'triggers a group with radio behavior', ->
      link1 = @radio_el.find('li:nth-child(2) > a')
      link2 = @radio_el.find('li:nth-child(3) > a')
      panel1 = @radio_el.find('#collapse_radio_2')
      panel2 = @radio_el.find('#collapse_radio_3')

      link1.click()
      expect(panel1).toHaveClass('in')
      expect(panel2).not.toHaveClass('in')

      link2.click()
      expect(panel1).not.toHaveClass('in')
      expect(panel2).toHaveClass('in')

    it 'triggers a group with checkbox behavior', ->
      link1 = @check_el.find('li:first-child > a')
      link2 = @check_el.find('li:nth-child(2) > a')
      panel1 = @check_el.find('#collapse_check_1')
      panel2 = @check_el.find('#collapse_check_2')

      link1.click()
      expect(panel1).toHaveClass('in')
      expect(panel2).not.toHaveClass('in')

      link2.click()
      expect(panel1).toHaveClass('in')
      expect(panel2).toHaveClass('in')


  xdescribe '#reset', ->
    it 'resets the height of a panel', ->
      spyEvent = spyOn(@auto, 'reset')
      @auto_el.click()
      expect(spyEvent).toHaveBeenCalled()
      expect(@auto_panel.height()).toBe(0)


  xdescribe '#transition', ->
    it 'transitions a panel when activated', ->
      spyEvent = spyOn(@collapse, 'transition')
      @collapse_el.click()
      expect(spyEvent).toHaveBeenCalled()
      expect(@collapse_panel.height()).toBeGreaterThan(0)

    it 'transitions a panel when deactivated', ->
      spyEvent = spyOn(@auto, 'transition')
      @auto_el.click()
      expect(spyEvent).toHaveBeenCalled()
      expect(@auto_panel.height()).toBe(0)

    it 'dispatches a start event for transitioning from the target for show', ->
      @collapse.setTarget()
      @collapse.target.on('collapse:show', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @collapse_el.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'dispatches a start event for transitioning from the target for hide', ->
      @collapse_el.click()
      @collapse.target.on('collapse:hide', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @collapse_el.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'dispatches a complete event for transitioning from the target for shown', ->
      orig = utensils.Detect.hasTransition
      utensils.Detect.hasTransition = false
      @collapse.setTarget()
      @collapse.target.on('collapse:shown', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @collapse_el.click()
      expect(spyEvent).toHaveBeenCalled()
      utensils.Detect.hasTransition = orig

    it 'dispatches a complete event for transitioning from the target for hidden', ->
      orig = utensils.Detect.hasTransition
      utensils.Detect.hasTransition = false
      @auto.target.on('collapse:hidden', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @auto_el.click()
      expect(spyEvent).toHaveBeenCalled()
      utensils.Detect.hasTransition = orig


  xdescribe '#setTarget', ->
    it 'sets the target from the href attribute', ->
      @collapse.setTarget()
      expect(@collapse.target).toBe(@collapse_panel)

    it 'sets the target from the data-target attribute', ->
      expect(@auto.target).toBe(@auto_panel)


  xdescribe '#setGroupTarget', ->
    it 'sets the target from the href attribute', ->
      expect(@radio.target).toBe($('#collapse_radio_1'))

    it 'sets the target from the data-target attribute', ->
      link1 = @check_el.find('li:first-child > a')
      panel1 = @check_el.find('#collapse_check_1')
      link1.click()
      expect(@check.target).toBe(panel1)

    it 'finds the target when it using external panels', ->
      link1 = @external_el.find('li:first-child > a')
      panel1 = @dom.find('#collapse_external_1')
      link1.click()
      expect(@external.target).toBe(panel1)

