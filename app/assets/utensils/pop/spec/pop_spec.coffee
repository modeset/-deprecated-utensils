
#= require utensils/pop
#= require utensils/directional

describe 'Pop', ->

  beforeEach ->
    # Add extra data which we might not want to be shown in documentation from the fixture
    extra = """
            <a id="overrides" data-toggle="active" data-trigger="focus" data-effect="move" data-title="The Overrides Pop" data-content="The content" data-placement="east">Overrides</a>
            <a id="auto_activated" data-title="The Active Pop" data-content="The content" data-activate="true">Auto Activated</a>
            """

    loadFixtures('pop')
    @dom = $('#jasmine-fixtures')
    @dom.append(extra)

    @north_el = @dom.find('#pop_north')
    @south_el = @dom.find('#pop_south')
    @east_el = @dom.find('#pop_east')
    @west_el = @dom.find('#pop_west')
    @no_title_el = @dom.find('#pop_no_title')
    @ext_el = @dom.find('#pop_selector')
    @ext_content = @dom.find('#pop_exterior_content')
    @override_el = @dom.find('#overrides')
    @auto_el = @dom.find('#auto_activated')

    @north_pop = new utensils.Pop(@north_el)
    @south_pop = new utensils.Pop(@south_el)
    @east_pop = new utensils.Pop(@east_el)
    @west_pop = new utensils.Pop(@west_el)
    @no_title_pop = new utensils.Pop(@no_title_el)
    @ext_pop = new utensils.Pop(@ext_el)

    @auto_pop = new utensils.Pop(@auto_el)
    @override_pop = new utensils.Pop(@override_el)

  afterEach ->
    $('.pop').remove()


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('pop')).toEqual(utensils.Pop)


  describe '#constructor', ->
    it 'displays like a tip', ->
      expect(@north_pop.is_tip_like).toEqual(true)

    it 'does not display like a tip', ->
      expect(@ext_pop.is_tip_like).toEqual(false)

    it 'sets up a data object like a tip', ->
      expect(@north_pop.data).toBeDefined()

    it 'finds the data object when not tip like', ->
      expect(@ext_pop.data).toBeDefined()
      expect(@ext_pop.data.placement).toEqual('west')

    it 'auto activates a pop', ->
      expect(@auto_el).toHaveClass('selected')


  describe '#options', ->
    it 'sets default namespace', ->
      expect(@north_pop.data.namespace).toEqual('pop')

    it 'sets the default data.toggle classes to "active in"', ->
      expect(@north_pop.data.toggle).toEqual('active in')

    it 'overrides the default data.toggle classes', ->
      expect(@override_pop.data.toggle).toEqual('active')

    it 'sets the default data.placement to "north"', ->
      expect(@north_pop.data.placement).toEqual('north')

    it 'overrides the default data.placement', ->
      expect(@south_pop.data.placement).toEqual('south')

    it 'sets the default data.title from data-title attribute', ->
      expect(@override_pop.data.title).toEqual('The Overrides Pop')

    it 'sets the default data.title from the title attribute', ->
      expect(@south_pop.data.title).toEqual('The Southern Pop')

    it 'sets the data.content from the content attribute', ->
      expect(@south_pop.data.content).toContain('snow goes in the summer')

    it 'sets the default data.effect to "fade"', ->
      expect(@north_pop.data.effect).toEqual('fade')

    it 'overrides the default data.effect', ->
      expect(@override_pop.data.effect).toEqual('move')


  describe '#initialize', ->
    it 'instantiates a class properties with null values', ->
      expect(@north_pop.pop).toBeNull()
      expect(@north_pop.cached_markup).toBeNull()

    it 'sets the default container to null', ->
      expect(@north_pop.container).toBeNull()

    it 'sets default namespace', ->
      expect(@east_pop.namespace).toEqual('pop')

    it 'sets the default toggle classes to "active in"', ->
      expect(@north_pop.toggle_classes).toEqual('active in')

    it 'overrides the default toggle classes', ->
      expect(@override_pop.toggle_classes).toEqual('active')

    it 'sets the default placement to "north"', ->
      expect(@north_pop.placement).toEqual('north')

    it 'overrides the default placement', ->
      expect(@south_pop.placement).toEqual('south')

    it 'sets the default title from data-title attribute', ->
      expect(@override_pop.title).toEqual('The Overrides Pop')

    it 'sets the default title from the title attribute', ->
      expect(@south_pop.title).toEqual('The Southern Pop')

    it 'sets the content from the content attribute', ->
      expect(@south_pop.content).toContain('snow goes in the summer')

    it 'sets the default effect to "fade"', ->
      expect(@north_pop.effect).toEqual('fade')

    it 'overrides the default effect', ->
      expect(@override_pop.effect).toEqual('move')

    it 'creates an instance of "Triggerable"', ->
      expect(@north_pop.triggerable instanceof utensils.Triggerable).toEqual(true)

    it 'blows away the title attribute contents', ->
      expect(@north_el.attr('title')).toEqual('')
      expect(@south_el.attr('title')).toEqual('')

    it 'uses Triggerables trigger types', ->
      expect(@north_pop.triggerable.trigger_type).toEqual(on:'click.pop', off:'click.pop')
      expect(@east_pop.triggerable.trigger_type).toEqual(on:'mouseenter.pop focus.pop', off:'mouseleave.pop blur.pop')
      expect(@override_pop.triggerable.trigger_type).toEqual(on:'focus.pop', off:'blur.pop')


  describe '#setup', ->
    it 'creates an instance of "Directional"', ->
      @north_pop.setup()
      expect(@north_pop.directional instanceof utensils.Directional).toEqual(true)

    it 'memoizes the cardinals from "Directional"', ->
      @north_pop.setup()
      expect(@north_pop.cardinals).toEqual(new utensils.Directional().getCardinals())


  describe '#toggle', ->
    it 'calls through #toggle on the "Triggerable" instance', ->
      spyEvent = spyOn(@north_pop.triggerable, 'toggle')
      @north_el.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'shows a pop from an elements action', ->
      @west_el.click()
      pop = $('.pop').first()
      expect(pop).toHaveClass('fade')

    it 'shows and hides a pop on an elements action after a delay', ->
      # override the delay to speed up the tests.
      @north_pop.triggerable.delay.activate = 50
      @north_pop.triggerable.delay.deactivate = 50

      runs ->
        @north_el.trigger('click')
      waits 50
      runs ->
        pop = $('.pop').first()
        expect(pop).toHaveClass('fade')
      waits 50
      runs ->
        @north_el.trigger('click')
      waits 50
      runs ->
        pop = $('.pop').first()
        expect(pop).not.toHaveClass('in')


  describe '#activate', ->
    it 'activates a pop', ->
      @west_pop.activate()
      pop = $('.pop').first()
      expect(pop).toHaveClass('fade')


  describe '#deactivate', ->
    it 'deactivates a pop', ->
      @west_pop.activate()
      @west_pop.deactivate()
      pop = $('.pop').first()
      expect(pop).not.toHaveClass('in')


  describe '#dispose', ->
    it 'removes listeners when disposed', ->
      spyEvent = spyOn(@west_pop, 'removeListeners')
      @west_pop.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'gets rid of triggerable', ->
      @west_pop.dispose()
      expect(@west_pop.triggerable).toBeNull()

    it 'does not respond to any further events', ->
      spyEvent = spyOn(@west_pop, 'activate')
      @west_pop.dispose()
      @west_el.click()
      expect(spyEvent).not.toHaveBeenCalled()

    it 'removes the pop when disposed', ->
      $('.pop').remove()
      @override_el.focus()
      expect($('.pop').length).toBeGreaterThan(0)
      @override_pop.dispose()
      expect(@override_pop.pop).toBeNull()
      expect($('.pop').length).toEqual(0)

    it 'does not toss freak out if disposing multiple times', ->
      @west_pop.dispose()
      @west_pop.dispose()
      expect(@west_pop.dispose).not.toThrow()


  describe '#activated', ->
    it 'activates a pop immediately even though it has a delay', ->
      @west_pop.activated()
      pop = $('.pop').first()
      expect(pop).toHaveClass('fade')
      expect(@west_el).toHaveClass('selected')

    it 'caches internal markup', ->
      expect(@west_pop.cached_markup).toBeNull()
      @west_el.trigger('click')
      expect(@west_pop.cached_markup).not.toBeNull()
      expect(@west_pop.cached_markup.find('.pop-arrow')).toBeDefined()
      expect(@west_pop.cached_markup.find('.pop-header')).toBeDefined()

    it 'caches external markup', ->
      expect(@ext_pop.cached_markup).toBeNull()
      @ext_pop.activated()
      expect(@ext_pop.cached_markup).not.toBeNull()
      expect(@ext_pop.cached_markup.find('.pop-arrow')).toBeDefined()
      expect(@ext_pop.cached_markup.find('.pop-header').text()).toContain(('Exterior content'))


  describe '#deactivated', ->
    it 'deactivates a pop immediately even though it has a delay', ->
      @north_pop.activated()
      @north_pop.deactivated()
      pop = $('.pop').first()
      expect(pop).not.toHaveClass('in')
      expect(@north_el).not.toHaveClass('selected')


  describe '#add', ->
    it 'sets the default container to body', ->
      @north_pop.activated()
      expect(@north_pop.container).toEqual($('body'))

    it 'adds a pop to the viewport', ->
      $('.pop').remove()
      expect($('.pop').length).toEqual(0)
      @east_el.trigger('mouseover')
      expect($('.pop').length).toBeGreaterThan(0)


  describe '#remove', ->
    it 'removes a pop', ->
      $('.pop').remove()
      @west_pop.activate()
      @west_pop.remove()
      pop = $('.pop').first()
      expect(pop.length).toEqual(0)
      expect(@west_pop.pop).toBeNull()


  describe '#render', ->
    it 'returns a string for rendering the default markup of a tip', ->
      west_render = @west_pop.render()
      expect(west_render).toHaveClass('pop west fade')
      expect(west_render.find('.pop-inner').html()).toContain('The Western Pop')


  describe '#findMarkup', ->
    it 'uses the internal render string when the pop is tip like', ->
      spyEvent = spyOn(@west_pop, 'render')
      @west_pop.findMarkup()
      expect(spyEvent).toHaveBeenCalled()

    it 'does not call render when the pop is not tip like', ->
      spyEvent = spyOn(@ext_pop, 'render')
      @ext_pop.findMarkup()
      expect(spyEvent).not.toHaveBeenCalled()

    it 'removes the pop-header div when there is no title attribute', ->
      $('.pop').remove()
      @no_title_el.trigger('click')
      pop = $('.pop')
      expect(pop).toHaveClass('pop-no-header')
      expect(pop.find('.pop-header').length).toEqual(0)

