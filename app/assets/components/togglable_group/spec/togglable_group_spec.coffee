
#= require togglable_group

describe 'Togglable Group', ->

  beforeEach ->
    loadFixtures('togglable_group')
    @dom = $('#jasmine-fixtures')

    @radio$ = @dom.find('#radios')
    @check$ = @dom.find('#checks')
    @delay$ = @dom.find('#radios_delay')
    @radio_kids = @radio$.find('li')
    @check_kids = @check$.find('li')
    @delay_kids = @delay$.find('li')
    @radio_group = new utensil.TogglableGroup(@radio$)
    @check_group = new utensil.TogglableGroup(@check$)
    @delay_group = new utensil.TogglableGroup(@delay$)

    @related_radio_nav_el = @dom.find('#related_radio_nav')
    @related_radio_content_el = @dom.find('#related_radio_content')
    @related_check_nav_el = @dom.find('#related_check_nav')
    @related_check_content_el = @dom.find('#related_check_content')
    @related_radio_group = new utensil.TogglableGroup(@related_radio_nav_el)
    @related_check_group = new utensil.TogglableGroup(@related_check_nav_el)


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(Bindable.getClass('togglable-group')).toEqual(utensil.TogglableGroup)


  describe '#options', ->
    it 'sets the data.target attribute', ->
      expect(@radio_group.data.target).toEqual('.radio-li')
      expect(@check_group.data.target).toEqual('li')


  describe '#initialize', ->
    it 'activates an element on initialization', ->
      togglable = new utensil.TogglableGroup(@check$, {activate: 1, behavior: 'checkbox'})
      expect($(@check_kids[1])).toHaveClass('active')

    it 'sets the toggle behavior correctly', ->
      expect(@radio_group.behavior).toEqual('radio')
      expect(@check_group.behavior).toEqual('checkbox')


  describe '#toggle', ->
    it 'toggles the correct classes from a trigger', ->
      spyEvent = spyOn(@radio_group, 'toggle').andCallThrough()
      $(@radio_kids[1]).find('a').click()
      expect(spyEvent).toHaveBeenCalled()

    it 'toggles a radio group element', ->
      $(@radio_kids[1]).find('a').click()
      expect($(@radio_kids[1])).toHaveClass('active')

      $(@radio_kids[2]).find('a').click()
      expect($(@radio_kids[2])).toHaveClass('active')
      expect($(@radio_kids[1])).not.toHaveClass('active')

    it 'toggles a checkbox group element', ->
      $(@check_kids[1]).find('a').click()
      expect($(@check_kids[1])).toHaveClass('active')

      $(@check_kids[2]).find('a').click()
      expect($(@check_kids[2])).toHaveClass('active')
      expect($(@check_kids[1])).toHaveClass('active')

    it 'does not deactivate a radio group unless an actual target is triggered', ->
      $(@radio_kids[1]).find('a').click()
      expect($(@radio_kids[1])).toHaveClass('active')
      @radio$.click()
      expect($(@radio_kids[1])).toHaveClass('active')

    it 'does not deactivate a check group unless an actual target is triggered', ->
      $(@check_kids[1]).find('a').click()
      expect($(@check_kids[1])).toHaveClass('active')
      @check$.click()
      expect($(@check_kids[1])).toHaveClass('active')

    it 'does not deactivate a radio group if triggered by a list without an a tag', ->
      $(@radio_kids[1]).find('a').click()
      expect($(@radio_kids[1])).toHaveClass('active')
      @radio$.find('.not-link').click()
      expect($(@radio_kids[1])).toHaveClass('active')

    it 'does not deactivate a check group if triggered by a list without an a tag', ->
      $(@check_kids[1]).find('a').click()
      expect($(@check_kids[1])).toHaveClass('active')
      @check$.find('.not-link').click()
      expect($(@check_kids[1])).toHaveClass('active')


  describe '#activate', ->
    it 'activates a radio group element from an index', ->
      @radio_group.activate(target:1)
      expect($(@radio_kids[1])).toHaveClass('active')

      @radio_group.activate(target:2)
      expect($(@radio_kids[2])).toHaveClass('active')
      expect($(@radio_kids[1])).not.toHaveClass('active')

    it 'activates a checkbox group element from an index', ->
      @check_group.activate(target:1)
      expect($(@check_kids[1])).toHaveClass('active')

      @check_group.activate(target:2)
      expect($(@check_kids[2])).toHaveClass('active')
      expect($(@check_kids[1])).toHaveClass('active')

    it 'activates a radio group element from a link element', ->
      link = $(@radio_kids[1]).find('a')
      @radio_group.activate(target:link)
      expect($(@radio_kids[1])).toHaveClass('active')

    it 'activates a radio group element from a list element', ->
      list = $(@radio_kids[2])
      @radio_group.activate(target:list)
      expect($(@radio_kids[2])).toHaveClass('active')

    it 'activates a checkbox group element from a link element', ->
      link = $(@check_kids[0]).find('a')
      @check_group.activate(target:link)
      expect($(@check_kids[0])).toHaveClass('active')

    it 'activates a checkbox group element from a list element', ->
      list = $(@check_kids[2])
      @check_group.activate(target:list)
      expect($(@check_kids[2])).toHaveClass('active')


  describe '#deactivate', ->
    it 'deactivates a radio group element from an index', ->
      @radio_group.activate(target:1)
      expect($(@radio_kids[1])).toHaveClass('active')
      @radio_group.activate(target:2)
      expect($(@radio_kids[1])).not.toHaveClass('active')

    it 'deactivates a radio group element from a link element', ->
      link = $(@radio_kids[1]).find('a')
      link2 = $(@radio_kids[2]).find('a')
      @radio_group.activate(target:link)
      expect($(@radio_kids[1])).toHaveClass('active')
      @radio_group.activate(target:link2)
      expect($(@radio_kids[1])).not.toHaveClass('active')

    it 'deactivates a radio group element from a list element', ->
      list = $(@radio_kids[2])
      list2 = $(@radio_kids[1])

      @radio_group.activate(target:list)
      expect($(@radio_kids[2])).toHaveClass('active')
      @radio_group.activate(target:list2)
      expect($(@radio_kids[2])).not.toHaveClass('active')

    it 'deactivates a check group element from an index', ->
      @check_group.activate(target:1)
      expect($(@check_kids[1])).toHaveClass('active')
      @check_group.deactivate(target:1)
      expect($(@check_kids[1])).not.toHaveClass('active')

    it 'deactivates a checkbox group element from a link element', ->
      link = $(@check_kids[0]).find('a')
      @check_group.activate(target:link)
      expect($(@check_kids[0])).toHaveClass('active')
      @check_group.deactivate(target:link)
      expect($(@check_kids[0])).not.toHaveClass('active')

    it 'deactivates a checkbox group element from a list element', ->
      list = $(@check_kids[2])
      @check_group.activate(target:list)
      expect($(@check_kids[2])).toHaveClass('active')
      @check_group.deactivate(target:list)
      expect($(@check_kids[2])).not.toHaveClass('active')


  describe '#activateWithDelay', ->
    it 'activates a togglable group element after a delay', ->

      # override the delay to speed up the tests.
      @delay_group.delay.activate = 50
      @delay_group.delay.deactivate = 50

      runs ->
        @delay_group.activate(target:1)
      waits 100
      runs ->
        expect($(@delay_kids[1])).toHaveClass('active')


  describe '#deactivateWithDelay', ->
    it 'deactivates a togglable group element after a delay', ->
      el1 = $(@delay_kids[1])
      el2 = $(@delay_kids[2])

      # override the delay to speed up the tests.
      @delay_group.delay.activate = 50
      @delay_group.delay.deactivate = 50

      @delay_group.setActivate(target:1)
      expect(el1).toHaveClass('active')
      runs ->
        @delay_group.activate(target:2)
      waits 100
      runs ->
        expect(el1).not.toHaveClass('active')
        expect(el2).toHaveClass('active')


  describe '#activateRelatedState, #deactivateRelatedState', ->
    it 'finds the selector based on a child of the activators "href"', ->
      first_nav = $(@related_radio_nav_el.find('li')[0])
      first_pane = $(@related_radio_content_el.find('article')[0])
      element = @related_radio_group.activateRelatedState(first_nav)
      expect(element).toBe(first_pane)

    it 'finds the selector based on a child of the activators "data-target"', ->
      second_nav = $(@related_radio_nav_el.find('li')[1])
      second_pane = $(@related_radio_content_el.find('article')[1])
      element = @related_radio_group.activateRelatedState(second_nav)
      expect(element).toBe(second_pane)

    it 'finds the selector based on a child of the deactivators "href"', ->
      first_nav = $(@related_check_nav_el.find('li')[0])
      first_pane = $(@related_check_content_el.find('article')[0])
      element = @related_check_group.deactivateRelatedState(first_nav)
      expect(element).toBe(first_pane)

    it 'finds the selector based on a child of the deactivators "data-target"', ->
      second_nav = $(@related_check_nav_el.find('li')[1])
      second_pane = $(@related_check_content_el.find('article')[1])
      element = @related_check_group.deactivateRelatedState(second_nav)
      expect(element).toBe(second_pane)

    it 'adds the active state to a related component with "radio" type behavior', ->
      first_nav = $(@related_radio_nav_el.find('li')[0])
      middle_nav = $(@related_radio_nav_el.find('li')[1])
      first_pane = $(@related_radio_content_el.find('article')[0])
      middle_pane = $(@related_radio_content_el.find('article')[1])

      middle_nav.trigger('click')
      expect(first_nav).not.toHaveClass('active')
      expect(middle_nav).toHaveClass('active')
      expect(first_pane).not.toHaveClass('active')
      expect(middle_pane).toHaveClass('active')

    it 'adds the active state to a related component with "checkbox" type behavior', ->
      first_nav = $(@related_check_nav_el.find('li')[0])
      middle_nav = $(@related_check_nav_el.find('li')[1])
      first_pane = $(@related_check_content_el.find('article')[0])
      middle_pane = $(@related_check_content_el.find('article')[1])

      middle_nav.trigger('click')
      expect(first_nav).toHaveClass('active')
      expect(middle_nav).toHaveClass('active')
      expect(first_pane).toHaveClass('active')
      expect(middle_pane).toHaveClass('active')


  describe '@dispatcher', ->
    it 'uses the base elements @el as the @dispatcher', ->
      expect(@check_group.dispatcher).toBe(@check$)
      expect(@radio_group.dispatcher).toBe(@radio$)

    it 'dispatches a Togglers togglable:activate event through TogglableGroup', ->
      tmp = 0
      @check_group.dispatcher.on('togglable:activate', => tmp += 1)
      @check_group.setActivate(target:1)
      expect(tmp).not.toEqual(0)

    it 'dispatches a Togglers togglable:deactivate event through TogglableGroup', ->
      tmp = 0
      @check_group.dispatcher.on('togglable:deactivate', => tmp -= 1)
      @check_group.setDeactivate(target:1)
      expect(tmp).not.toEqual(0)

