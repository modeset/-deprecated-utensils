
#= require toggler_group

describe 'Toggler Group', ->

  beforeEach ->
    html = """
          <section class="shell">
            <nav>
              <ul id="radios" class="nav" data-bindable="toggler-group" data-target=".radio-li">
                <li class="radio-li"><a href="#">Radio 1</a></li>
                <li class="radio-li"><a href="#">Radio 2</a></li>
                <li class="radio-li"><a href="#">Radio 3</a></li>
              </ul>
            </nav>

            <nav>
              <ul id="checks" class="nav" data-bindable="toggler-group" data-behavior="checkbox">
                <li><a href="#">Checkbox 1</a></li>
                <li><a href="#">Checkbox 2</a></li>
                <li><a href="#">Checkbox 3</a></li>
              </ul>
            </nav>
           </section>
           """
    @html = $(html)
    setFixtures(@html)

    @radio$ = @html.find('#radios')
    @check$ = @html.find('#checks')
    @radio_kids = @radio$.find('li')
    @check_kids = @check$.find('li')
    @radio_group = new roos.TogglerGroup(@radio$)
    @check_group = new roos.TogglerGroup(@check$)


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(Bindable.getClass('toggler-group')).toEqual(roos.TogglerGroup)


  describe '#options', ->
    it 'sets the data.target attribute', ->
      expect(@radio_group.data.target).toEqual('.radio-li')
      expect(@check_group.data.target).toEqual('li')


  describe '#initialize', ->
    it 'activates an element on initialization', ->
      toggler = new roos.TogglerGroup(@check$, {activate: 1, behavior: 'checkbox'})
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


  describe '#activate', ->
    it 'activates a radio group element from an index', ->
      @radio_group.activate(1)
      expect($(@radio_kids[1])).toHaveClass('active')

      @radio_group.activate(2)
      expect($(@radio_kids[2])).toHaveClass('active')
      expect($(@radio_kids[1])).not.toHaveClass('active')

    it 'activates a checkbox group element from an index', ->
      @check_group.activate(1)
      expect($(@check_kids[1])).toHaveClass('active')

      @check_group.activate(2)
      expect($(@check_kids[2])).toHaveClass('active')
      expect($(@check_kids[1])).toHaveClass('active')

    it 'activates a radio group element from a link element', ->
      link = $(@radio_kids[1]).find('a')
      @radio_group.activate(link)
      expect($(@radio_kids[1])).toHaveClass('active')

    it 'activates a radio group element from a list element', ->
      list = $(@radio_kids[2])
      @radio_group.activate(list)
      expect($(@radio_kids[2])).toHaveClass('active')

    it 'activates a checkbox group element from a link element', ->
      link = $(@check_kids[0]).find('a')
      @check_group.activate(link)
      expect($(@check_kids[0])).toHaveClass('active')

    it 'activates a checkbox group element from a list element', ->
      list = $(@check_kids[2])
      @check_group.activate(list)
      expect($(@check_kids[2])).toHaveClass('active')


  describe '#deactivate', ->
    it 'deactivates a radio group element from an index', ->
      @radio_group.activate(1)
      expect($(@radio_kids[1])).toHaveClass('active')
      @radio_group.deactivate(1)
      expect($(@radio_kids[1])).not.toHaveClass('active')

    it 'deactivates a check group element from an index', ->
      @check_group.activate(1)
      expect($(@check_kids[1])).toHaveClass('active')
      @check_group.deactivate(1)
      expect($(@check_kids[1])).not.toHaveClass('active')

    it 'deactivates a radio group element from a link element', ->
      link = $(@radio_kids[1]).find('a')
      @radio_group.activate(link)
      expect($(@radio_kids[1])).toHaveClass('active')
      @radio_group.deactivate(link)
      expect($(@radio_kids[1])).not.toHaveClass('active')

    it 'deactivates a radio group element from a list element', ->
      list = $(@radio_kids[2])
      @radio_group.activate(list)
      expect($(@radio_kids[2])).toHaveClass('active')
      @radio_group.deactivate(list)
      expect($(@radio_kids[2])).not.toHaveClass('active')

    it 'deactivates a checkbox group element from a link element', ->
      link = $(@check_kids[0]).find('a')
      @check_group.activate(link)
      expect($(@check_kids[0])).toHaveClass('active')
      @check_group.deactivate(link)
      expect($(@check_kids[0])).not.toHaveClass('active')

    it 'deactivates a checkbox group element from a list element', ->
      list = $(@check_kids[2])
      @check_group.activate(list)
      expect($(@check_kids[2])).toHaveClass('active')
      @check_group.deactivate(list)
      expect($(@check_kids[2])).not.toHaveClass('active')

