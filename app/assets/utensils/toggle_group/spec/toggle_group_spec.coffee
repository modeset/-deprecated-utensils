#= require utensils/toggle_group
fixture.preload 'toggle_group/markup/toggle_group'

describe 'ToggleGroup', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    fixture.load 'toggle_group/markup/toggle_group'
    @dom = $(fixture.el)

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
      expect(utensils.Bindable.getClass('toggle-group')).to.be utensils.ToggleGroup

    it 'is registered in bindable as toggle-button-group', ->
      expect(utensils.Bindable.getClass('toggle-button-group')).to.be utensils.ToggleGroup


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@radio.data).not.to.be undefined

    it 'activates an element on initialization from a number', ->
      togglable = new utensils.ToggleGroup(@radios_el, {activate: 1})
      expect(@radios_el.find('li:nth-child(2)').hasClass('active')).to.be true

    it 'activates an element on initialization from an id', ->
      li = @radios_el.find('li:nth-child(2)')
      li.attr('id', 'blah')
      togglable = new utensils.ToggleGroup(@radios_el, {activate: '#blah'})
      expect(li.hasClass('active')).to.be true
      li.removeAttr('id')

    it 'activates an element on initialization from a number for a button group', ->
      togglable = new utensils.ToggleGroup(@btn_radios_el, {activate: 1, bindable:"toggle-button-group"})
      expect(@btn_radios_el.find('button:nth-child(2)').hasClass('active')).to.be true

    it 'activates an element on initialization from an id for a button group', ->
      li = @btn_radios_el.find('button:nth-child(2)')
      li.attr('id', 'blah')
      togglable = new utensils.ToggleGroup(@btn_radios_el, {activate: '#blah'})
      expect(li.hasClass('active')).to.be true
      li.removeAttr('id')


  describe '#options', ->
    it 'sets default namespace', ->
      expect(@radio.data.namespace).to.be 'toggle_group'

    it 'overrides the default namespace via a data attribute', ->
      expect(@delay.data.namespace).to.be 'toggle_delay'

    it 'sets the default data.toggle state to "active"', ->
      expect(@radio.data.toggle).to.be 'active'

    it 'overrides the default data.toggle state to "active on"', ->
      expect(@delay.data.toggle).to.be 'active on'

    it 'sets the data.behavior to "radio" by default', ->
      expect(@radio.data.behavior).to.be 'radio'

    it 'overrides the default data.behavior to "checkbox"', ->
      expect(@check.data.behavior).to.be 'checkbox'

    it 'uses the data-target attribute for targets', ->
      expect(@radio.data.target).to.be '.radio-li'

    it 'uses the data-target attribute for targets on a button group', ->
      expect(@btn_check.data.target).to.be '.btn'

    it 'uses the default attribute for targets', ->
      expect(@check.data.target).to.be 'li'

    it 'overrides the default attribute for targets for toggle-button-group', ->
      expect(@btn_radio.data.target).to.be 'a,button'

    it 'defaults to the ".group-ignore" class for ignoring elements actions', ->
      expect(@radio.data.ignore).to.be '.group-ignore,.drop'

    it 'overrides ignore class via a data attribute', ->
      expect(@check.data.ignore).to.be '.text-ignore'


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@radio.namespace).to.be 'toggle_group'

    it 'overrides the default namespace via a data attribute', ->
      expect(@delay.namespace).to.be 'toggle_delay'

    it 'sets the default toggle state to "active"', ->
      expect(@radio.toggle_classes).to.be 'active'

    it 'overrides the default toggle state to "active on"', ->
      expect(@delay.toggle_classes).to.be 'active on'

    it 'sets the radio group behavior to "radio" by default', ->
      expect(@radio.behavior).to.be 'radio'

    it 'overrides the default radio behavior to "checkbox"', ->
      expect(@check.behavior).to.be 'checkbox'

    it 'defaults the target to null for lazy lookups', ->
      expect(@radio.targets).to.be null
      expect(@check.targets).to.be null
      expect(@delay.targets).to.be null
      expect(@btn_radio.targets).to.be null
      expect(@btn_check.targets).to.be null

    it 'creates an instance of "Triggerable"', ->
      expect(@radio.triggerable).to.be.a utensils.Triggerable


  describe '#activate', ->
    it 'activates the item based on a passed index', ->
      @radio.activate 1
      expect(@radios_el.find('li:nth-child(2)').hasClass('active')).to.be true

    it 'activates the item based on a passed index for a button group', ->
      @btn_radio.activate 1
      expect(@btn_radios_el.find('button:nth-child(2)').hasClass('active')).to.be true

    it 'activates the item based on a passed element', ->
      li = @checks_el.find('li:first-child')
      @check.activate(li)
      expect(li.hasClass('active')).to.be true

    it 'activates the item based on a passed element for a button group', ->
      @btn_check.activate(@btn_check_link)
      expect(@btn_check_link.hasClass('active')).to.be true

    it 'activates the item based on a passed index performing like a check group', ->
      @check.activate(1)
      expect(@checks_el.find('li:nth-child(2)').hasClass('active')).to.be true
      @check.activate(2)
      expect(@checks_el.find('li:nth-child(2)').hasClass('active')).to.be true
      expect(@checks_el.find('li:nth-child(3)').hasClass('active')).to.be true

    it 'activates the item based on a passed index performing like a check group for a button group', ->
      @btn_check.activate(0)
      expect(@btn_checks_el.find('a:nth-child(1)').hasClass('active')).to.be true
      @btn_check.activate(2)
      expect(@btn_checks_el.find('a:nth-child(1)').hasClass('active')).to.be true
      expect(@btn_checks_el.find('a:nth-child(3)').hasClass('active')).to.be true

    it 'activates the item based on a passed element performing like a radio group', ->
      li1 = @radios_el.find('li:first-child')
      li2 = @radios_el.find('li:nth-child(2)')
      @radio.activate(li1)
      expect(li1.hasClass('active')).to.be true
      @radio.activate(li2)
      expect(li1.hasClass('active')).to.be false
      expect(li2.hasClass('active')).to.be true

    it 'activates the item based on a passed element performing like a radio group for a button group', ->
      link1 = @btn_radios_el.find('button:first-child')
      link2 = @btn_radios_el.find('button:nth-child(2)')
      @btn_radio.activate(link1)
      expect(link1.hasClass('active')).to.be true
      @btn_radio.activate(link2)
      expect(link1.hasClass('active')).to.be false
      expect(link2.hasClass('active')).to.be true

    it 'activates the item with a delay from a passed index', (done) ->
      @delay.activate(1)
      activated = @delays_el.find('li:nth-child(2)')
      @delay.triggerable.delay.activate = 50
      @delay.triggerable.delay.deactivate = 50

      activated.find('a').click()
      expect(activated.hasClass('active on')).to.be false
      setTimeout(( =>
        expect(activated.hasClass('active on')).to.be true
        done()
      ), 50)

    it 'activates an element from a string', ->
      li = @radios_el.find('li:nth-child(2)')
      li.attr('id', 'blah')
      @radio.activate('#blah')
      expect(li.hasClass('active')).to.be true
      li.removeAttr('id')

    it 'activates an element from a string for a button group', ->
      link = @btn_radios_el.find('button:nth-child(2)')
      link.attr('id', 'blah')
      @btn_radio.activate('#blah')
      expect(link.hasClass('active')).to.be true
      link.removeAttr('id')


  describe '#deactivate', ->
    it 'deactivates the item based on a passed index', ->
      li = @checks_el.find('li:nth-child(2)')
      @check.activate(1)
      expect(li.hasClass('active')).to.be true
      @check.deactivate(1)
      expect(li.hasClass('active')).to.be false

    it 'deactivates the item based on a passed index for a button group', ->
      link = @btn_checks_el.find('a:nth-child(1)')
      @btn_check.activate(0)
      expect(link.hasClass('active')).to.be true
      @btn_check.deactivate(0)
      expect(link.hasClass('active')).to.be false

    it 'deactivates the item based on a passed element', ->
      li = @checks_el.find('li:first-child')
      @check.activate(li)
      expect(li.hasClass('active')).to.be true
      @check.deactivate(li)
      expect(li.hasClass('active')).to.be false

    it 'deactivates the item based on a passed element for a button group', ->
      link = @btn_checks_el.find('a:first-child')
      @btn_check.activate(link)
      expect(link.hasClass('active')).to.be true
      @btn_check.deactivate(link)
      expect(link.hasClass('active')).to.be false

    it 'does not deactivate the item if it is a radio group', ->
      li = @radios_el.find('li:nth-child(2)')
      @radio.activate(1)
      expect(li.hasClass('active')).to.be true
      @radio.deactivate(1)
      expect(li.hasClass('active')).to.be true

    it 'does not deactivate the item if it is a radio group for a button group', ->
      link = @btn_radios_el.find('button:nth-child(2)')
      @btn_radio.activate(1)
      expect(link.hasClass('active')).to.be true
      @btn_radio.deactivate(1)
      expect(link.hasClass('active')).to.be true

    it 'deactivates the item based on a passed index performing like a check group', ->
      li1 = @checks_el.find('li:nth-child(2)')
      li2 = @checks_el.find('li:nth-child(3)')
      @check.activate(1)
      expect(li1.hasClass('active')).to.be true
      @check.activate(2)
      expect(li1.hasClass('active')).to.be true
      expect(li2.hasClass('active')).to.be true
      @check.deactivate(1)
      expect(li1.hasClass('active')).to.be false
      expect(li2.hasClass('active')).to.be true
      @check.deactivate(2)
      expect(li1.hasClass('active')).to.be false
      expect(li2.hasClass('active')).to.be false

    it 'deactivates the item based on a passed index performing like a check group for a button group', ->
      link1 = @btn_checks_el.find('a:nth-child(1)')
      link2 = @btn_checks_el.find('a:nth-child(3)')
      @btn_check.activate(0)
      expect(link1.hasClass('active')).to.be true
      @btn_check.activate(2)
      expect(link1.hasClass('active')).to.be true
      expect(link2.hasClass('active')).to.be true
      @btn_check.deactivate(0)
      expect(link1.hasClass('active')).to.be false
      expect(link2.hasClass('active')).to.be true
      @btn_check.deactivate(2)
      expect(link1.hasClass('active')).to.be false
      expect(link2.hasClass('active')).to.be false

    it 'deactivates an element from a string', ->
      li = @checks_el.find('li:first-child')
      li.attr('id', 'blah')
      @check.activate(li)
      expect(li.hasClass('active')).to.be true
      @check.deactivate('#blah')
      expect(li.hasClass('active')).to.be false
      li.removeAttr('id')

    it 'deactivates an element from a string for a button group', ->
      link = @btn_checks_el.find('a:first-child')
      link.attr('id', 'blah')
      @btn_check.activate(link)
      expect(link.hasClass('active')).to.be true
      @btn_check.deactivate('#blah')
      expect(link.hasClass('active')).to.be false
      link.removeAttr('id')


  describe '#dispose', ->
    it 'removes its own listeners', ->
      spy = sinon.spy @radio, 'removeListeners'
      @radio.dispose()
      expect(spy.called).to.be.ok()

    it 'calls through #dispose on the "Triggerable" instance', ->
      spy = sinon.spy @radio.triggerable, 'dispose'
      @radio.dispose()
      expect(spy.called).to.be.ok()

    it 'sets the instance of "Triggerable" to null', ->
      @radio.dispose()
      expect(@radio.triggerable).to.be null

    it 'does not toss an error if disposing multiple times', ->
      @radio.dispose()
      @radio.dispose()
      expect(@radio.dispose).not.to.throwException()


  describe '#addListeners', ->
    it 'adds a listener for "click" event', ->
      spy = sinon.spy @radio, 'triggered'
      @radio_link.click()
      expect(spy.called).to.be.ok()


  describe '#removeListeners', ->
    it 'removes a listener for "click" event', ->
      spy = sinon.spy @check, 'triggered'
      @check.removeListeners()
      @check_link.click()
      expect(spy.called).not.to.be.ok()


  describe '#triggered, #radio, #checkbox', ->
    it 'triggers an element in a radio group', ->
      link2 = @radios_el.find('li:nth-child(2) a')
      @radio_link.click()
      expect(@radios_el.find('li:first-child').hasClass('active')).to.be true
      link2.click()
      expect(@radios_el.find('li:first-child').hasClass('active')).to.be false
      expect(@radios_el.find('li:nth-child(2)').hasClass('active')).to.be true

    it 'triggers an element in a radio group for a button group', ->
      link2 = @btn_radios_el.find('button:nth-child(2)')
      @btn_radio_link.click()
      expect(@btn_radio_link.hasClass('active')).to.be true
      link2.click()
      expect(@btn_radio_link.hasClass('active')).to.be false
      expect(link2.hasClass('active')).to.be true

    it 'calls through to the radio method', ->
      spy = sinon.spy @radio, 'radio'
      @radio_link.click()
      expect(spy.called).to.be.ok()

    it 'triggers an element in a check group', ->
      link2 = @checks_el.find('li:first-child a')
      @check_link.click()
      expect(@checks_el.find('li:nth-child(2)').hasClass('active')).to.be true
      link2.click()
      expect(@checks_el.find('li:nth-child(2)').hasClass('active')).to.be true
      expect(@checks_el.find('li:first-child').hasClass('active')).to.be true

    it 'triggers an element in a check group for a button group', ->
      link2 = @btn_checks_el.find('a:first-child')
      @btn_check_link.click()
      expect(@btn_check_link.hasClass('active')).to.be true
      link2.click()
      expect(@btn_check_link.hasClass('active')).to.be true
      expect(link2.hasClass('active')).to.be true

    it 'calls through to the check method', ->
      spy = sinon.spy @check, 'checkbox'
      @check_link.click()
      expect(spy.called).to.be.ok()

    it 'dispatches an event from a radio group when triggered', ->
      @radios_el.on('toggle_group:triggered', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @radio_link.click()
      expect(spy.called).to.be.ok()
      expect(@element.html()).to.be @radio_link.closest('li').html()

    it 'dispatches an event from a checkbox group when triggered', ->
      @checks_el.on('toggle_group:triggered', => @noop arguments...)
      spy = sinon.spy this, 'noop'
      @check_link.click()
      expect(spy.called).to.be.ok()
      expect(@element.html()).to.be @check_link.closest('li').html()


  describe '#setTargets', ->
    it 'finds the targets when passed via a data attribute', ->
      expect(@radio.targets).to.be null
      @radio_link.click()
      expect(@radio.targets.length).to.be 3
      expect(@radio.targets.hasClass('radio-li')).to.be true

    it 'finds the targets when passed via a data attribute for a button group', ->
      expect(@btn_check.targets).to.be null
      @btn_check_link.click()
      expect(@btn_check.targets.length).to.be 4
      expect(@btn_check.targets.hasClass('btn')).to.be true

    it 'finds the li elements by default when no target is passed', ->
      expect(@check.targets).to.be null
      @check_link.click()
      expect(@check.targets.length).to.be 3

    it 'finds the elements by default when no target is passed for a button group', ->
      expect(@btn_radio.targets).to.be null
      @btn_radio_link.click()
      expect(@btn_radio.targets.length).to.be 7

    it 'ignores targets via a data attribute when the markup contains a ".group-ignore" class', ->
      expect(@radio.targets).to.be null
      @radio_link.click()
      expect(@radio.targets.hasClass('group-ignore')).to.be false

    it 'ignores targets when the markup contains a ".group-ignore" class through the default li search', ->
      expect(@check.targets).to.be null
      @check_link.click()
      expect(@check.targets.hasClass('group-ignore')).to.be false


  describe '#findElementFromType', ->
    it 'calls #findElementByIndex when passed a number', ->
      spy = sinon.spy @radio, 'findElementByIndex'
      @radio.findElementFromType 1
      expect(spy.called).to.be.ok()

    it 'calls #findElementByString when passed a string', ->
      spy = sinon.spy @check, 'findElementByString'
      @check.findElementFromType 'li:first-child'
      expect(spy.called).to.be.ok()

    it 'calls #findElementBySelector when passed a selector', ->
      spy = sinon.spy @check, 'findElementBySelector'
      @check.findElementFromType @check_link
      expect(spy.called).to.be.ok()


  describe '#findElementByIndex', ->
    it 'finds the element via an index', ->
      el = @radio.findElementByIndex(1)
      expect(el.html()).to.be @radios_el.find('li:nth-child(2) a').html()

    it 'finds the element via an index for a button group', ->
      el = @btn_radio.findElementByIndex(1)
      expect(el.html()).to.be @btn_radios_el.find('button:nth-child(2)').html()


  describe '#findElementByString', ->
    it 'finds the element via a string', ->
      el = @radio.findElementByString('li:first-child')
      expect(el.html()).to.be @radios_el.find('li:nth-child(1) a').html()

    it 'finds the element via a string for a button group', ->
      el = @btn_radio.findElementByString('button:nth-child(2)')
      expect(el.html()).to.be @btn_radios_el.find('button:nth-child(2)').html()


  describe '#findElementBySelector', ->
    it 'finds the element via a selector', ->
      li = @radios_el.find('li:first-child')
      el = @radio.findElementBySelector(li)
      expect(el.html()).to.be li.find('a').html()

    it 'finds the element via a selector for a button group', ->
      btn = @btn_radios_el.find('button:nth-child(2)')
      el = @btn_radio.findElementBySelector(btn)
      expect(el.html()).to.be btn.html()

