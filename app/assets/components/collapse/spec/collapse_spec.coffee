
#= require detect
#= require collapse

describe 'Collapse', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    loadFixtures('collapse')
    @dom = $('#jasmine-fixtures')

    @collapse_el = @dom.find('[href=#collapse_height]')
    @auto_el = @dom.find('[data-target=#collapse_auto]')
    @collapse_panel = @dom.find('#collapse_height')
    @auto_panel = @dom.find('#collapse_auto')

    @radio_el = @dom.find('#collapse_radio')
    @check_el = @dom.find('#collapse_checkbox')
    @external_el = @dom.find('#collapse_external')

    @collapse = new utensil.Collapse(@collapse_el)
    @auto = new utensil.Collapse(@auto_el)
    @radio = new utensil.Collapse(@radio_el)
    @check = new utensil.Collapse(@check_el)
    @external = new utensil.Collapse(@external_el)

  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensil.Bindable.getClass('collapse')).toEqual(utensil.Collapse)


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@collapse.data).toBeDefined()

    it 'auto activates an element from a data attribute for a single collapse', ->
      expect(@auto_el).toHaveClass('active')
      expect(@auto_panel).toHaveClass('in')

    it 'auto activates an element from a data attribute for a group collapse', ->
      expect(@radio_el.find('li:first-child')).toHaveClass('active')
      expect(@radio_el.find('#collapse_radio_1')).toHaveClass('in')


  describe '#options', ->
    it 'sets default data.namespace', ->
      expect(@collapse.data.namespace).toEqual('collapse')

    it 'sets the default data.dimension', ->
      expect(@collapse.data.dimension).toEqual('height')

    it 'sets the default data.type for a single collapse', ->
      expect(@collapse.data.type).toEqual('single')

    it 'sets the default data.type for a group collapse', ->
      expect(@radio.data.type).toEqual('group')


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@collapse.namespace).toEqual('collapse')

    it 'sets default dimension', ->
      expect(@collapse.dimension).toEqual('height')

    it 'sets the default type for a single collapse', ->
      expect(@collapse.type).toEqual('single')

    it 'sets the default type for a group collapse', ->
      expect(@radio.type).toEqual('group')

    it 'initializes with a null target', ->
      expect(@collapse.target).toBeNull()

    it 'creates an instance of "Toggle" for a single collapse', ->
      expect(@collapse.toggler instanceof utensil.Toggle).toEqual(true)

    it 'creates an instance of "ToggleGroup" for a group collapse', ->
      expect(@radio.toggler instanceof utensil.ToggleGroup).toEqual(true)
      expect(@check.toggler instanceof utensil.ToggleGroup).toEqual(true)


  describe '#activate', ->
    it 'calls the #activate method on the toggler for a single collapse', ->
      spyEvent = spyOn(@collapse.toggler, 'activate')
      @collapse.activate()
      expect(spyEvent).toHaveBeenCalled()

    it 'opens the panel on a public call to #activate for a single collapse', ->
      expect(@collapse_panel).not.toHaveClass('in')
      @collapse.activate()
      expect(@collapse_panel).toHaveClass('in')

    it 'calls the #activate method on the toggler for a group collapse', ->
      spyEvent = spyOn(@check.toggler, 'activate')
      @check.activate(1)
      expect(spyEvent).toHaveBeenCalled()

    it 'opens the panel on a public call to #activate for a group collapse', ->
      panel = @check_el.find('#collapse_check_1')
      expect(panel).not.toHaveClass('in')
      @check.activate(0)
      expect(panel).toHaveClass('in')


  describe '#deactivate', ->
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


  describe '#dispose', ->
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


  describe '#addListeners', ->
    it 'adds a listener for "click" event for a single collapse', ->
      spyEvent = spyOn(@collapse, 'activated')
      @collapse_el.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'adds a listener for "click" event for a group collapse', ->
      spyEvent = spyOn(@check, 'activated')
      @check_el.find('li:first-child > a').click()
      expect(spyEvent).toHaveBeenCalled()


  describe '#removeListeners', ->
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


  describe '#activated', ->
    it 'expands the height of a collapse panel', ->
      @collapse_el.click()
      expect(@collapse_panel.height()).toBeGreaterThan(0)


  describe '#deactivated', ->
    it 'contracts the height of a collapse panel', ->
      @auto_el.click()
      expect(@auto_panel.height()).toBe(0)


  describe '#triggered', ->
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


  describe '#reset', ->
    it 'resets the height of a panel', ->
      spyEvent = spyOn(@auto, 'reset')
      @auto_el.click()
      expect(spyEvent).toHaveBeenCalled()
      expect(@auto_panel.height()).toBe(0)


  describe '#transition', ->
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
      orig = utensil.Detect.hasTransition
      utensil.Detect.hasTransition = false
      @collapse.setTarget()
      @collapse.target.on('collapse:shown', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @collapse_el.click()
      expect(spyEvent).toHaveBeenCalled()
      utensil.Detect.hasTransition = orig

    it 'dispatches a complete event for transitioning from the target for hidden', ->
      orig = utensil.Detect.hasTransition
      utensil.Detect.hasTransition = false
      @auto.target.on('collapse:hidden', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @auto_el.click()
      expect(spyEvent).toHaveBeenCalled()
      utensil.Detect.hasTransition = orig


  describe '#setTarget', ->
    it 'sets the target from the href attribute', ->
      @collapse.setTarget()
      expect(@collapse.target).toBe(@collapse_panel)

    it 'sets the target from the data-target attribute', ->
      expect(@auto.target).toBe(@auto_panel)


  describe '#setGroupTarget', ->
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

