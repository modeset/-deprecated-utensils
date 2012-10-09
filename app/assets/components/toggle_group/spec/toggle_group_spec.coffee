
#= require toggle_group

describe 'ToggleGroup', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    loadFixtures('toggle_group')
    @dom = $('#jasmine-fixtures')

    @radios_el = @dom.find('#toggle_group_radios')
    @checks_el = @dom.find('#toggle_group_checks')
    @delays_el = @dom.find('#toggle_group_delay')

    @radio_link = @radios_el.find('li:first-child a')
    @check_link = @checks_el.find('li:nth-child(2) a')
    @delay_link = @delays_el.find('li:last-child a')

    @radio = new utensil.ToggleGroup(@radios_el)
    @check = new utensil.ToggleGroup(@checks_el)
    @delay = new utensil.ToggleGroup(@delays_el)


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(Bindable.getClass('toggle-group')).toEqual(utensil.ToggleGroup)


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@radio.data).toBeDefined()


  describe '#options', ->
    it 'sets default namespace', ->
      expect(@radio.data.namespace).toEqual('toggle_group')

    it 'overrides the default namespace via a data attribute', ->
      expect(@delay.data.namespace).toEqual('toggle_delay')

    it 'sets the default data.toggle state to "active"', ->
      expect(@radio.data.toggle).toEqual('active')

    it 'overrides the default data.toggle state to "active on"', ->
      expect(@delay.data.toggle).toEqual('active on')

    it 'sets the data.behavior to "radio" by default', ->
      expect(@radio.data.behavior).toEqual('radio')

    it 'overrides the default data.behavior to "checkbox"', ->
      expect(@check.data.behavior).toEqual('checkbox')

    it 'uses the data-target attribute for targets', ->
      expect(@radio.data.target).toEqual('.radio-li')

    it 'uses the default attribute for targets', ->
      expect(@check.data.target).toEqual('li')

    it 'defaults to the ".group-ignore" class for ignoring elements actions', ->
      expect(@radio.data.ignore).toEqual('.group-ignore')

    it 'overrides ignore class via a data attribute', ->
      expect(@check.data.ignore).toEqual('.text-ignore')


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@radio.namespace).toEqual('toggle_group')

    it 'overrides the default namespace via a data attribute', ->
      expect(@delay.namespace).toEqual('toggle_delay')

    it 'sets the default toggle state to "active"', ->
      expect(@radio.toggle_classes).toEqual('active')

    it 'overrides the default toggle state to "active on"', ->
      expect(@delay.toggle_classes).toEqual('active on')

    it 'sets the radio group behavior to "radio" by default', ->
      expect(@radio.behavior).toEqual('radio')

    it 'overrides the default radio behavior to "checkbox"', ->
      expect(@check.behavior).toEqual('checkbox')

    it 'has target elements for a group to work on', ->
      expect(@radio.targets.length).toBeGreaterThan(1)
      expect(@check.targets.length).toBeGreaterThan(1)
      expect(@delay.targets.length).toBeGreaterThan(1)

    it 'creates an instance of "Triggerable"', ->
      expect(@radio.triggerable instanceof utensil.Triggerable).toEqual(true)


  describe '#activate', ->
    it 'activates the item based on a passed index', ->
      @radio.activate(1)
      expect(@radios_el.find('li:nth-child(2)')).toHaveClass('active')

    it 'activates the item based on a passed element', ->
      li = @checks_el.find('li:first-child')
      @check.activate(li)
      expect(li).toHaveClass('active')

    it 'activates the item based on a passed index performing like a check group', ->
      @check.activate(1)
      expect(@checks_el.find('li:nth-child(2)')).toHaveClass('active')
      @check.activate(2)
      expect(@checks_el.find('li:nth-child(2)')).toHaveClass('active')
      expect(@checks_el.find('li:nth-child(3)')).toHaveClass('active')

    it 'activates the item based on a passed element performing like a radio group', ->
      li1 = @radios_el.find('li:first-child')
      li2 = @radios_el.find('li:nth-child(2)')
      @radio.activate(li1)
      expect(li1).toHaveClass('active')
      @radio.activate(li2)
      expect(li1).not.toHaveClass('active')
      expect(li2).toHaveClass('active')

    it 'activates the item with a delay from a passed index', ->
      @delay.activate(1)
      activated = @delays_el.find('li:nth-child(2)')
      @delay.triggerable.delay.activate = 50
      @delay.triggerable.delay.deactivate = 50
      runs ->
        activated.find('a').click()
        expect(activated).not.toHaveClass('active on')
      waits 50
      runs ->
        expect(activated).toHaveClass('active on')


  describe '#deactivate', ->
    it 'deactivates the item based on a passed index', ->
      li = @checks_el.find('li:nth-child(2)')
      @check.activate(1)
      expect(li).toHaveClass('active')
      @check.deactivate(1)
      expect(li).not.toHaveClass('active')

    it 'deactivates the item based on a passed element', ->
      li = @checks_el.find('li:first-child')
      @check.activate(li)
      expect(li).toHaveClass('active')
      @check.deactivate(li)
      expect(li).not.toHaveClass('active')

    it 'does not deactivate the item if it is a radio group', ->
      li = @radios_el.find('li:nth-child(2)')
      @radio.activate(1)
      expect(li).toHaveClass('active')
      @radio.activate(1)
      expect(li).toHaveClass('active')

    it 'deactivates the item based on a passed index performing like a check group', ->
      li1 = @checks_el.find('li:nth-child(2)')
      li2 = @checks_el.find('li:nth-child(3)')
      @check.activate(1)
      expect(li1).toHaveClass('active')
      @check.activate(2)
      expect(li1).toHaveClass('active')
      expect(li2).toHaveClass('active')
      @check.deactivate(1)
      expect(li1).not.toHaveClass('active')
      expect(li2).toHaveClass('active')
      @check.deactivate(2)
      expect(li1).not.toHaveClass('active')
      expect(li2).not.toHaveClass('active')


  describe '#dispose', ->
    it 'removes its own listeners', ->
      spyEvent = spyOn(@radio, 'removeListeners')
      @radio.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'calls through #dispose on the "Triggerable" instance', ->
      spyEvent = spyOn(@radio.triggerable, 'dispose')
      @radio.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'sets the instance of "Triggerable" to null', ->
      @radio.dispose()
      expect(@radio.triggerable).toBeNull()


  describe '#addListeners', ->
    it 'adds a listener for "click" event', ->
      spyEvent = spyOn(@radio, 'triggered')
      @radio_link.click()
      expect(spyEvent).toHaveBeenCalled()


  describe '#removeListeners', ->
    it 'removes a listener for "click" event', ->
      spyEvent = spyOn(@check, 'triggered')
      @check.removeListeners()
      @check_link.click()
      expect(spyEvent).not.toHaveBeenCalled()


  describe '#triggered, #radio, #checkbox', ->
    it 'triggers an element in a radio group', ->
      link2 = @radios_el.find('li:nth-child(2) a')
      @radio_link.click()
      expect(@radios_el.find('li:first-child')).toHaveClass('active')
      link2.click()
      expect(@radios_el.find('li:first-child')).not.toHaveClass('active')
      expect(@radios_el.find('li:nth-child(2)')).toHaveClass('active')

    it 'calls through to the radio method', ->
      spyEvent = spyOn(@radio, 'radio')
      @radio_link.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'triggers an element in a check group', ->
      link2 = @checks_el.find('li:first-child a')
      @check_link.click()
      expect(@checks_el.find('li:nth-child(2)')).toHaveClass('active')
      link2.click()
      expect(@checks_el.find('li:nth-child(2)')).toHaveClass('active')
      expect(@checks_el.find('li:first-child')).toHaveClass('active')

    it 'calls through to the check method', ->
      spyEvent = spyOn(@check, 'checkbox')
      @check_link.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'dispatches an event from a radio group when triggered', ->
      @radios_el.on('toggle_group:triggered', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @radio_link.click()
      expect(spyEvent).toHaveBeenCalled()
      expect(@element).toBe(@radio_link.closest('li'))

    it 'dispatches an event from a checkbox group when triggered', ->
      @checks_el.on('toggle_group:triggered', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @check_link.click()
      expect(spyEvent).toHaveBeenCalled()
      expect(@element).toBe(@check_link.closest('li'))


  describe '#findTargets', ->
    it 'finds the targets when passed via a data attribute', ->
      expect(@radio.targets.length).toEqual(3)
      expect(@radio.targets).toHaveClass('radio-li')

    it 'finds the li elements by default when no target is passed', ->
      expect(@check.targets.length).toEqual(3)

    it 'ignores targets via a data attribute when the markup contains a ".group-ignore" class', ->
      expect(@radio.targets).not.toHaveClass('group-ignore')

    it 'ignores targets when the markup contains a ".group-ignore" class through the default li search', ->
      expect(@check.targets).not.toHaveClass('group-ignore')

