#= require utensils/toggle_group

describe 'ToggleGroup', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    loadFixtures('toggle_group')
    @dom = $('#teabag-fixtures')

    @radios_el = @dom.find('#toggle_group_radios')
    @checks_el = @dom.find('#toggle_group_checks')
    @delays_el = @dom.find('#toggle_group_delay')
    @btn_radios_el = @dom.find('#toggle_button_group_radios')
    @btn_checks_el = @dom.find('#toggle_button_group_checks')

    @radio_link = @radios_el.find('li:first-child a')
    @check_link = @checks_el.find('li:nth-child(2) a')
    @delay_link = @delays_el.find('li:last-child a')
    @btn_radio_link = @btn_radios_el.find('button:first-child')
    @btn_check_link = @btn_checks_el.find('a:nth-child(3)')

    @radio = new utensils.ToggleGroup(@radios_el)
    @check = new utensils.ToggleGroup(@checks_el)
    @delay = new utensils.ToggleGroup(@delays_el)
    @btn_radio = new utensils.ToggleGroup(@btn_radios_el)
    @btn_check = new utensils.ToggleGroup(@btn_checks_el)


  describe 'binding', ->
    it 'is registered in bindable as toggle-group', ->
      expect(utensils.Bindable.getClass('toggle-group')).toEqual(utensils.ToggleGroup)

    it 'is registered in bindable as toggle-button-group', ->
      expect(utensils.Bindable.getClass('toggle-button-group')).toEqual(utensils.ToggleGroup)


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@radio.data).toBeDefined()

    it 'activates an element on initialization from a number', ->
      togglable = new utensils.ToggleGroup(@radios_el, {activate: 1})
      expect(@radios_el.find('li:nth-child(2)')).toHaveClass('active')

    it 'activates an element on initialization from an id', ->
      li = @radios_el.find('li:nth-child(2)')
      li.attr('id', 'blah')
      togglable = new utensils.ToggleGroup(@radios_el, {activate: '#blah'})
      expect(li).toHaveClass('active')
      li.removeAttr('id')

    it 'activates an element on initialization from a number for a button group', ->
      togglable = new utensils.ToggleGroup(@btn_radios_el, {activate: 1, bindable:"toggle-button-group"})
      expect(@btn_radios_el.find('button:nth-child(2)')).toHaveClass('active')

    it 'activates an element on initialization from an id for a button group', ->
      li = @btn_radios_el.find('button:nth-child(2)')
      li.attr('id', 'blah')
      togglable = new utensils.ToggleGroup(@btn_radios_el, {activate: '#blah'})
      expect(li).toHaveClass('active')
      li.removeAttr('id')


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

    it 'uses the data-target attribute for targets on a button group', ->
      expect(@btn_check.data.target).toEqual('.btn')

    it 'uses the default attribute for targets', ->
      expect(@check.data.target).toEqual('li')

    it 'overrides the default attribute for targets for toggle-button-group', ->
      expect(@btn_radio.data.target).toEqual('a,button')

    it 'defaults to the ".group-ignore" class for ignoring elements actions', ->
      expect(@radio.data.ignore).toEqual('.group-ignore,.drop')

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

    it 'defaults the target to null for lazy lookups', ->
      expect(@radio.targets).toBeNull()
      expect(@check.targets).toBeNull()
      expect(@delay.targets).toBeNull()
      expect(@btn_radio.targets).toBeNull()
      expect(@btn_check.targets).toBeNull()

    it 'creates an instance of "Triggerable"', ->
      expect(@radio.triggerable instanceof utensils.Triggerable).toEqual(true)


  describe '#activate', ->
    it 'activates the item based on a passed index', ->
      @radio.activate(1)
      expect(@radios_el.find('li:nth-child(2)')).toHaveClass('active')

    it 'activates the item based on a passed index for a button group', ->
      @btn_radio.activate(1)
      expect(@btn_radios_el.find('button:nth-child(2)')).toHaveClass('active')

    it 'activates the item based on a passed element', ->
      li = @checks_el.find('li:first-child')
      @check.activate(li)
      expect(li).toHaveClass('active')

    it 'activates the item based on a passed element for a button group', ->
      @btn_check.activate(@btn_check_link)
      expect(@btn_check_link).toHaveClass('active')

    it 'activates the item based on a passed index performing like a check group', ->
      @check.activate(1)
      expect(@checks_el.find('li:nth-child(2)')).toHaveClass('active')
      @check.activate(2)
      expect(@checks_el.find('li:nth-child(2)')).toHaveClass('active')
      expect(@checks_el.find('li:nth-child(3)')).toHaveClass('active')

    it 'activates the item based on a passed index performing like a check group for a button group', ->
      @btn_check.activate(0)
      expect(@btn_checks_el.find('a:nth-child(1)')).toHaveClass('active')
      @btn_check.activate(2)
      expect(@btn_checks_el.find('a:nth-child(1)')).toHaveClass('active')
      expect(@btn_checks_el.find('a:nth-child(3)')).toHaveClass('active')

    it 'activates the item based on a passed element performing like a radio group', ->
      li1 = @radios_el.find('li:first-child')
      li2 = @radios_el.find('li:nth-child(2)')
      @radio.activate(li1)
      expect(li1).toHaveClass('active')
      @radio.activate(li2)
      expect(li1).not.toHaveClass('active')
      expect(li2).toHaveClass('active')

    it 'activates the item based on a passed element performing like a radio group for a button group', ->
      link1 = @btn_radios_el.find('button:first-child')
      link2 = @btn_radios_el.find('button:nth-child(2)')
      @btn_radio.activate(link1)
      expect(link1).toHaveClass('active')
      @btn_radio.activate(link2)
      expect(link1).not.toHaveClass('active')
      expect(link2).toHaveClass('active')

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

    it 'activates an element from a string', ->
      li = @radios_el.find('li:nth-child(2)')
      li.attr('id', 'blah')
      @radio.activate('#blah')
      expect(li).toHaveClass('active')
      li.removeAttr('id')

    it 'activates an element from a string for a button group', ->
      link = @btn_radios_el.find('button:nth-child(2)')
      link.attr('id', 'blah')
      @btn_radio.activate('#blah')
      expect(link).toHaveClass('active')
      link.removeAttr('id')


  describe '#deactivate', ->
    it 'deactivates the item based on a passed index', ->
      li = @checks_el.find('li:nth-child(2)')
      @check.activate(1)
      expect(li).toHaveClass('active')
      @check.deactivate(1)
      expect(li).not.toHaveClass('active')

    it 'deactivates the item based on a passed index for a button group', ->
      link = @btn_checks_el.find('a:nth-child(1)')
      @btn_check.activate(0)
      expect(link).toHaveClass('active')
      @btn_check.deactivate(0)
      expect(link).not.toHaveClass('active')

    it 'deactivates the item based on a passed element', ->
      li = @checks_el.find('li:first-child')
      @check.activate(li)
      expect(li).toHaveClass('active')
      @check.deactivate(li)
      expect(li).not.toHaveClass('active')

    it 'deactivates the item based on a passed element for a button group', ->
      link = @btn_checks_el.find('a:first-child')
      @btn_check.activate(link)
      expect(link).toHaveClass('active')
      @btn_check.deactivate(link)
      expect(link).not.toHaveClass('active')

    it 'does not deactivate the item if it is a radio group', ->
      li = @radios_el.find('li:nth-child(2)')
      @radio.activate(1)
      expect(li).toHaveClass('active')
      @radio.deactivate(1)
      expect(li).toHaveClass('active')

    it 'does not deactivate the item if it is a radio group for a button group', ->
      link = @btn_radios_el.find('button:nth-child(2)')
      @btn_radio.activate(1)
      expect(link).toHaveClass('active')
      @btn_radio.deactivate(1)
      expect(link).toHaveClass('active')

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

    it 'deactivates the item based on a passed index performing like a check group for a button group', ->
      link1 = @btn_checks_el.find('a:nth-child(1)')
      link2 = @btn_checks_el.find('a:nth-child(3)')
      @btn_check.activate(0)
      expect(link1).toHaveClass('active')
      @btn_check.activate(2)
      expect(link1).toHaveClass('active')
      expect(link2).toHaveClass('active')
      @btn_check.deactivate(0)
      expect(link1).not.toHaveClass('active')
      expect(link2).toHaveClass('active')
      @btn_check.deactivate(2)
      expect(link1).not.toHaveClass('active')
      expect(link2).not.toHaveClass('active')

    it 'deactivates an element from a string', ->
      li = @checks_el.find('li:first-child')
      li.attr('id', 'blah')
      @check.activate(li)
      expect(li).toHaveClass('active')
      @check.deactivate('#blah')
      expect(li).not.toHaveClass('active')
      li.removeAttr('id')

    it 'deactivates an element from a string for a button group', ->
      link = @btn_checks_el.find('a:first-child')
      link.attr('id', 'blah')
      @btn_check.activate(link)
      expect(link).toHaveClass('active')
      @btn_check.deactivate('#blah')
      expect(link).not.toHaveClass('active')
      link.removeAttr('id')


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

    it 'does not toss an error if disposing multiple times', ->
      @radio.dispose()
      @radio.dispose()
      expect(@radio.dispose).not.toThrow()


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

    it 'triggers an element in a radio group for a button group', ->
      link2 = @btn_radios_el.find('button:nth-child(2)')
      @btn_radio_link.click()
      expect(@btn_radio_link).toHaveClass('active')
      link2.click()
      expect(@btn_radio_link).not.toHaveClass('active')
      expect(link2).toHaveClass('active')

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

    it 'triggers an element in a check group for a button group', ->
      link2 = @btn_checks_el.find('a:first-child')
      @btn_check_link.click()
      expect(@btn_check_link).toHaveClass('active')
      link2.click()
      expect(@btn_check_link).toHaveClass('active')
      expect(link2).toHaveClass('active')

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


  describe '#setTargets', ->
    it 'finds the targets when passed via a data attribute', ->
      expect(@radio.targets).toBeNull()
      @radio_link.click()
      expect(@radio.targets.length).toEqual(3)
      expect(@radio.targets).toHaveClass('radio-li')

    it 'finds the targets when passed via a data attribute for a button group', ->
      expect(@btn_check.targets).toBeNull()
      @btn_check_link.click()
      expect(@btn_check.targets.length).toEqual(4)
      expect(@btn_check.targets).toHaveClass('btn')

    it 'finds the li elements by default when no target is passed', ->
      expect(@check.targets).toBeNull()
      @check_link.click()
      expect(@check.targets.length).toEqual(3)

    it 'finds the elements by default when no target is passed for a button group', ->
      expect(@btn_radio.targets).toBeNull()
      @btn_radio_link.click()
      expect(@btn_radio.targets.length).toEqual(7)

    it 'ignores targets via a data attribute when the markup contains a ".group-ignore" class', ->
      expect(@radio.targets).toBeNull()
      @radio_link.click()
      expect(@radio.targets).not.toHaveClass('group-ignore')

    it 'ignores targets when the markup contains a ".group-ignore" class through the default li search', ->
      expect(@check.targets).toBeNull()
      @check_link.click()
      expect(@check.targets).not.toHaveClass('group-ignore')


  describe '#findElementFromType', ->
    it 'calls #findElementByIndex when passed a number', ->
      spyEvent = spyOn(@radio, 'findElementByIndex')
      @radio.findElementFromType(1)
      expect(spyEvent).toHaveBeenCalled()

    it 'calls #findElementByString when passed a string', ->
      spyEvent = spyOn(@check, 'findElementByString')
      @check.findElementFromType('li:first-child')
      expect(spyEvent).toHaveBeenCalled()

    it 'calls #findElementBySelector when passed a selector', ->
      spyEvent = spyOn(@check, 'findElementBySelector')
      @check.findElementFromType(@check_link)
      expect(spyEvent).toHaveBeenCalled()


  describe '#findElementByIndex', ->
    it 'finds the element via an index', ->
      el = @radio.findElementByIndex(1)
      expect(el).toBe(@radios_el.find('li:nth-child(2) a'))

    it 'finds the element via an index for a button group', ->
      el = @btn_radio.findElementByIndex(1)
      expect(el).toBe(@btn_radios_el.find('button:nth-child(2)'))


  describe '#findElementByString', ->
    it 'finds the element via a string', ->
      el = @radio.findElementByString('li:first-child')
      expect(el).toBe(@radios_el.find('li:nth-child(1) a'))

    it 'finds the element via a string for a button group', ->
      el = @btn_radio.findElementByString('button:nth-child(2)')
      expect(el).toBe(@btn_radios_el.find('button:nth-child(2)'))


  describe '#findElementBySelector', ->
    it 'finds the element via a selector', ->
      li = @radios_el.find('li:first-child')
      el = @radio.findElementBySelector(li)
      expect(el).toBe(li.find('a'))

    it 'finds the element via a selector for a button group', ->
      btn = @btn_radios_el.find('button:nth-child(2)')
      el = @btn_radio.findElementBySelector(btn)
      expect(el).toBe(btn)

