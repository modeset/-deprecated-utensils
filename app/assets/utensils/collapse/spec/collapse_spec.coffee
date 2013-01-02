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
    @auto_el = @dom.find('[href=#collapse_auto]')
    @collapse_panel = @dom.find('#collapse_height')
    @auto_panel = @dom.find('#collapse_auto')

    @radio_el = @dom.find('#collapse_radio')
    @check_el = @dom.find('#collapse_checkbox')
    @external_el = @dom.find('#collapse_external')

    @collapse = new utensils.Collapse(@collapse_el.parent())
    @auto = new utensils.Collapse(@auto_el.parent())
    @radio = new utensils.Collapse(@radio_el)
    @check = new utensils.Collapse(@check_el)
    @external = new utensils.Collapse(@external_el)


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('collapse')).toEqual(utensils.Collapse)


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@collapse.data).toBeDefined()

    it 'auto activates an element from a data attribute for a single collapse', ->
      expect(@auto_el.parent()).toHaveClass('active')
      expect(@auto_panel).toHaveClass('in')

    it 'auto activates an element from a data attribute for a group collapse', ->
      expect(@radio_el.find('li:first-child')).toHaveClass('active')
      expect(@radio_el.find('#collapse_radio_1')).toHaveClass('in')


  describe '#options', ->
    it 'sets default data.namespace', ->
      expect(@collapse.data.namespace).toEqual('collapse')

    it 'sets the default data.dimension', ->
      expect(@collapse.data.dimension).toEqual('height')

    it 'sets the default data.behavior', ->
      expect(@radio.data.behavior).toEqual('radio')

    it 'sets the overrides data.behavior', ->
      expect(@check.data.behavior).toEqual('checkbox')

    it 'sets up a default selector list', ->
      expect(@check.data.selector).toContain('.collapse-toggle')


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@collapse.namespace).toEqual('collapse')

    it 'sets default dimension', ->
      expect(@collapse.dimension).toEqual('height')

    it 'sets the default behavior', ->
      expect(@radio.behavior).toEqual('radio')

    it 'sets the overrides behavior', ->
      expect(@check.behavior).toEqual('checkbox')

    it 'sets up a default selector list', ->
      expect(@check.selector).toContain('.collapse-toggle')

    it 'finds a toggler element based on a selector', ->
      expect(@radio.toggler).toBe(@radio_el.find('> li > .collapse-toggle'))


  describe '#activate', ->
    it 'opens the panel for a single collapse element', ->
      expect(@collapse_panel).not.toHaveClass('in')
      @collapse_el.click()
      expect(@collapse_panel).toHaveClass('in')

    it 'calls the #activate method for a check group collapse', ->
      spyEvent = spyOn(@check, 'activate')
      @check_el.find('.collapse-toggle').first().click()
      expect(spyEvent).toHaveBeenCalled()

    it 'opens the panel on a click for a check group collapse', ->
      panel = @check_el.find('#collapse_check_1')
      expect(panel).not.toHaveClass('in')
      @check_el.find('.collapse-toggle').first().click()
      expect(panel).toHaveClass('in')

    it 'opens the panel for a radio group collapse', ->
      panel = @radio_el.find('#collapse_radio_2')
      expect(panel).not.toHaveClass('in')
      @radio_el.find('li:nth-child(2) > a').click()
      expect(panel).toHaveClass('in')

    it 'closes the panel for a radio group collapse', ->
      panel1 = @radio_el.find('#collapse_radio_1')
      panel2 = @radio_el.find('#collapse_radio_2')
      expect(panel1).toHaveClass('in')
      expect(panel2).not.toHaveClass('in')
      @radio_el.find('li:nth-child(2) > a').click()
      expect(panel1).not.toHaveClass('in')
      expect(panel2).toHaveClass('in')


  describe '#deactivate', ->
    it 'closes the panel for a single collapse element', ->
      expect(@auto_panel).toHaveClass('in')
      @auto_el.click()
      expect(@auto_panel).not.toHaveClass('in')

    it 'calls the #deactivate method for a check group collapse', ->
      spyEvent = spyOn(@check, 'deactivate')
      @check_el.find('.collapse-toggle').first().click()
      @check_el.find('.collapse-toggle').first().click()
      expect(spyEvent).toHaveBeenCalled()

    it 'closes the panel on a click for a check group collapse', ->
      panel = @check_el.find('#collapse_check_1')
      expect(panel).not.toHaveClass('in')
      @check_el.find('.collapse-toggle').first().click()
      expect(panel).toHaveClass('in')
      @check_el.find('.collapse-toggle').first().click()
      expect(panel).not.toHaveClass('in')

    it 'does not close the panel for a radio group collapse that is active', ->
      panel = @radio_el.find('#collapse_radio_2')
      expect(panel).not.toHaveClass('in')
      @radio_el.find('li:nth-child(2) > a').click()
      expect(panel).toHaveClass('in')
      @radio_el.find('li:nth-child(2) > a').click()
      expect(panel).toHaveClass('in')


  describe '#deactivateAll', ->
    it 'closes all open panels for a check group', ->
      panel1 = @check_el.find('#collapse_check_1')
      panel2 = @check_el.find('#collapse_check_2')
      @check_el.find('li:nth-child(1) > a').click()
      expect(panel1).toHaveClass('in')
      expect(panel2).toHaveClass('in')
      @check.deactivateAll()
      expect(panel1).not.toHaveClass('in')
      expect(panel2).not.toHaveClass('in')


  describe '#activateIndex', ->
    it 'activates through a passed number', ->
      panel = @check_el.find('#collapse_check_1')
      expect(panel).not.toHaveClass('in')
      @check.activateIndex(0)
      expect(panel).toHaveClass('in')


  describe '#deactivateIndex', ->
    it 'deactivates through a passed number', ->
      panel = @check_el.find('#collapse_check_2')
      expect(panel).toHaveClass('in')
      @check.deactivateIndex(1)
      expect(panel).not.toHaveClass('in')


  describe '#dispose', ->
    it 'removes its own listeners for a single collapse', ->
      spyEvent = spyOn(@collapse, 'removeListeners')
      @collapse.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'removes its own listeners for a group collapse', ->
      spyEvent = spyOn(@check, 'removeListeners')
      @check.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'does not freak out when calling multiple disposals', ->
      @radio.dispose()
      @radio.dispose()
      expect(@radio.dispose).not.toThrow()


  describe '#addListeners', ->
    it 'adds a listener for "click" event for a single collapse', ->
      spyEvent = spyOn(@collapse, 'triggered')
      @collapse_el.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'adds a listener for "click" event for a group collapse', ->
      spyEvent = spyOn(@check, 'triggered')
      @check_el.find('li:first-child > a').click()
      expect(spyEvent).toHaveBeenCalled()


  describe '#removeListeners', ->
    it 'removes a listener for "click" event for a single collapse', ->
      spyEvent = spyOn(@collapse, 'triggered')
      @collapse.removeListeners()
      @collapse_el.click()
      expect(spyEvent).not.toHaveBeenCalled()

    it 'removes a listener for "click" event for a group collapse', ->
      spyEvent = spyOn(@check, 'triggered')
      @check.removeListeners()
      @check_el.find('li:first-child > a').click()
      expect(spyEvent).not.toHaveBeenCalled()


  describe '#triggered', ->
    it 'expands the height of a collapse panel', ->
      @collapse_el.click()
      expect(@collapse_panel.height()).toBeGreaterThan(0)

    it 'contracts the height of a collapse panel', ->
      @auto_el.click()
      expect(@auto_panel.height()).toBe(0)

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
      panel1 = @check_el.find('#collapse_check_1')
      panel2 = @check_el.find('#collapse_check_2')

      expect(panel1).not.toHaveClass('in')
      expect(panel2).toHaveClass('in')

      link1.click()
      expect(panel1).toHaveClass('in')
      expect(panel2).toHaveClass('in')


  describe '#reset', ->
    it 'resets the height of a panel', ->
      spyEvent = spyOn(@auto, 'reset')
      @auto_el.click()
      expect(spyEvent).toHaveBeenCalled()
      expect(@auto_panel.height()).toBe(0)


  describe '#getPanelAndParent', ->
    it 'returns an object of a panel and parent for a given object', ->
      obj = @collapse.getPanelAndParent(@collapse_el)
      expect(obj.panel).toBe(@collapse_panel)
      expect(obj.parent).toBe(@collapse_el.parent())

    it 'caches a selection after being triggered', ->
      expect(@check.cache['#collapse_check_2']).toBeDefined()
      @check_el.find('li:first-child > a').click()
      expect(@check.cache['#collapse_check_1']).toBeDefined()


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

    it 'dispatches a start event for transitioning from the panel for show', ->
      @collapse_panel.on('collapse:show', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @collapse_el.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'dispatches a start event for transitioning from the panel for hide', ->
      @collapse_el.click()
      @collapse_panel.on('collapse:hide', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @collapse_el.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'dispatches a complete event for transitioning from the panel for shown', ->
      orig = utensils.Detect.hasTransition
      utensils.Detect.hasTransition = false
      @collapse_panel.on('collapse:shown', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @collapse_el.click()
      expect(spyEvent).toHaveBeenCalled()
      utensils.Detect.hasTransition = orig

    it 'dispatches a complete event for transitioning from the panel for hidden', ->
      orig = utensils.Detect.hasTransition
      utensils.Detect.hasTransition = false
      @auto_panel.on('collapse:hidden', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @auto_el.click()
      expect(spyEvent).toHaveBeenCalled()
      utensils.Detect.hasTransition = orig

