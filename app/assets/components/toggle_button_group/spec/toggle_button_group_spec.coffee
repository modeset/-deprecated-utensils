
#= require toggle_button_group

describe 'ToggleButtonGroup', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    loadFixtures('toggle_button_group')
    @dom = $('#jasmine-fixtures')

    @radios_el = @dom.find('#toggle_button_group_radios')
    @checks_el = @dom.find('#toggle_button_group_checks')

    @radio_link = @radios_el.find('button:first-child')
    @check_link = @checks_el.find('a:nth-child(3)')

    @radio = new utensil.ToggleButtonGroup(@radios_el)
    @check = new utensil.ToggleButtonGroup(@checks_el)


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(Bindable.getClass('toggle-group')).toEqual(utensil.ToggleGroup)


  describe '#constructor', ->
    it 'extends ToggleGroup', ->
      expect(@radio instanceof utensil.ToggleGroup).toEqual(true)

    it 'sets up a data object', ->
      expect(@radio.data).toBeDefined()

    it 'activates an element on initialization from a number', ->
      togglable = new utensil.ToggleButtonGroup(@radios_el, {activate: 1})
      expect(@radios_el.find('button:nth-child(2)')).toHaveClass('active')

    it 'activates an element on initialization from an id', ->
      li = @radios_el.find('button:nth-child(2)')
      li.attr('id', 'blah')
      togglable = new utensil.ToggleButtonGroup(@radios_el, {activate: '#blah'})
      expect(li).toHaveClass('active')
      li.removeAttr('id')


  describe '#options', ->
    it 'sets default namespace', ->
      expect(@radio.data.namespace).toEqual('toggle_button_group')

    it 'sets the data.behavior to "radio" by default', ->
      expect(@radio.data.behavior).toEqual('radio')

    it 'overrides the default data.behavior to "checkbox"', ->
      expect(@check.data.behavior).toEqual('checkbox')

    it 'uses the data-target attribute for targets', ->
      expect(@check.data.target).toEqual('.btn')

    it 'uses the default attribute for targets', ->
      expect(@radio.data.target).toEqual('a,button')


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@radio.namespace).toEqual('toggle_button_group')

    it 'has target elements for a group to work on', ->
      expect(@radio.targets.length).toBeGreaterThan(1)
      expect(@check.targets.length).toBeGreaterThan(1)


  describe '#activate', ->
    it 'activates the item based on a passed index', ->
      @radio.activate(1)
      expect(@radios_el.find('button:nth-child(2)')).toHaveClass('active')

    it 'activates the item based on a passed element', ->
      @check.activate(@check_link)
      expect(@check_link).toHaveClass('active')

    it 'activates the item based on a passed index performing like a check group', ->
      @check.activate(0)
      expect(@checks_el.find('a:nth-child(1)')).toHaveClass('active')
      @check.activate(2)
      expect(@checks_el.find('a:nth-child(1)')).toHaveClass('active')
      expect(@checks_el.find('a:nth-child(3)')).toHaveClass('active')

    it 'activates the item based on a passed element performing like a radio group', ->
      link1 = @radios_el.find('button:first-child')
      link2 = @radios_el.find('button:nth-child(2)')
      @radio.activate(link1)
      expect(link1).toHaveClass('active')
      @radio.activate(link2)
      expect(link1).not.toHaveClass('active')
      expect(link2).toHaveClass('active')

    it 'activates an element from a string', ->
      link = @radios_el.find('button:nth-child(2)')
      link.attr('id', 'blah')
      @radio.activate('#blah')
      expect(link).toHaveClass('active')
      link.removeAttr('id')


  describe '#deactivate', ->
    it 'deactivates the item based on a passed index', ->
      link = @checks_el.find('a:nth-child(1)')
      @check.activate(0)
      expect(link).toHaveClass('active')
      @check.deactivate(0)
      expect(link).not.toHaveClass('active')

    it 'deactivates the item based on a passed element', ->
      link = @checks_el.find('a:first-child')
      @check.activate(link)
      expect(link).toHaveClass('active')
      @check.deactivate(link)
      expect(link).not.toHaveClass('active')

    it 'does not deactivate the item if it is a radio group', ->
      link = @radios_el.find('button:nth-child(2)')
      @radio.activate(1)
      expect(link).toHaveClass('active')
      @radio.deactivate(1)
      expect(link).toHaveClass('active')

    it 'deactivates the item based on a passed index performing like a check group', ->
      link1 = @checks_el.find('a:nth-child(1)')
      link2 = @checks_el.find('a:nth-child(3)')
      @check.activate(0)
      expect(link1).toHaveClass('active')
      @check.activate(2)
      expect(link1).toHaveClass('active')
      expect(link2).toHaveClass('active')
      @check.deactivate(0)
      expect(link1).not.toHaveClass('active')
      expect(link2).toHaveClass('active')
      @check.deactivate(2)
      expect(link1).not.toHaveClass('active')
      expect(link2).not.toHaveClass('active')

    it 'deactivates an element from a string', ->
      link = @checks_el.find('a:first-child')
      link.attr('id', 'blah')
      @check.activate(link)
      expect(link).toHaveClass('active')
      @check.deactivate('#blah')
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


  describe '#triggered', ->
    it 'triggers an element in a radio group', ->
      link2 = @radios_el.find('button:nth-child(2)')
      @radio_link.click()
      expect(@radio_link).toHaveClass('active')
      link2.click()
      expect(@radio_link).not.toHaveClass('active')
      expect(link2).toHaveClass('active')

    it 'calls through to the radio method', ->
      spyEvent = spyOn(@radio, 'radio')
      @radio_link.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'triggers an element in a check group', ->
      link2 = @checks_el.find('a:first-child')
      @check_link.click()
      expect(@check_link).toHaveClass('active')
      link2.click()
      expect(@check_link).toHaveClass('active')
      expect(link2).toHaveClass('active')

    it 'calls through to the check method', ->
      spyEvent = spyOn(@check, 'checkbox')
      @check_link.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'dispatches an event from a radio group when triggered', ->
      @radios_el.on('toggle_button_group:triggered', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @radio_link.click()
      expect(spyEvent).toHaveBeenCalled()
      expect(@element).toBe(@radio_link)

    it 'dispatches an event from a checkbox group when triggered', ->
      @checks_el.on('toggle_button_group:triggered', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @check_link.click()
      expect(spyEvent).toHaveBeenCalled()
      expect(@element).toBe(@check_link)


  describe '#findTargets', ->
    it 'finds the targets when passed via a data attribute', ->
      expect(@check.targets.length).toEqual(4)
      expect(@check.targets).toHaveClass('btn')

    it 'finds the elements by default when no target is passed', ->
      expect(@radio.targets.length).toEqual(7)

