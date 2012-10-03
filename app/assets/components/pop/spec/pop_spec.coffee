
#= require pop
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

    @north_pop = new utensil.Pop(@north_el)
    @south_pop = new utensil.Pop(@south_el)
    @east_pop = new utensil.Pop(@east_el)
    @west_pop = new utensil.Pop(@west_el)
    @no_title_pop = new utensil.Pop(@no_title_el)
    @ext_pop = new utensil.Pop(@ext_el)

    @auto_pop = new utensil.Pop(@auto_el)
    @override_pop = new utensil.Pop(@override_el)

  afterEach ->
    $('.pop').remove()


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(Bindable.getClass('pop')).toEqual(utensil.Pop)


  describe '#constructor', ->
    it 'displays like a tip', ->
      expect(@north_pop.is_tip_like).toEqual(true)

    it 'does not display like a tip', ->
      expect(@ext_pop.is_tip_like).toEqual(false)

    it 'auto activates a pop', ->
      expect(@auto_el).toHaveClass('active')


  describe '#options', ->
    it 'sets up pop toggler options', ->
      expect(@north_pop.toggler.toggle_classes).toEqual('active in')
      expect(@north_pop.toggler.trigger).toEqual(on:'click.togglable', off:'click.togglable')

    it 'sets up pop options', ->
      expect(@north_pop.effect).toEqual('fade')
      expect(@north_pop.placement).toEqual('north')

    it 'overrides pop toggler default options', ->
      expect(@override_pop.toggler.toggle_classes).toEqual('active')
      expect(@east_pop.toggler.trigger).toEqual(on:'mouseenter.togglable', off:'mouseleave.togglable')
      expect(@override_pop.toggler.trigger).toEqual(on:'focus.togglable', off:'blur.togglable')

    it 'overrides pop default options', ->
      expect(@override_pop.toggle_classes).toEqual('active')
      expect(@override_pop.effect).toEqual('move')
      expect(@south_pop.placement).toEqual('south')

    it 'sets the title from the title attribute', ->
      expect(@south_pop.title).toEqual('The Southern Pop')

    it 'sets the title from the data-title attribute', ->
      expect(@override_pop.title).toEqual('The Overrides Pop')

    it 'sets the content from the content attribute', ->
      expect(@south_pop.content).toContain('snow goes in the summer')


  describe '#initialize', ->
    it 'instantiates a class properties with null values', ->
      expect(@north_pop.pop).toBeNull()

    it 'has a directional utility class for placing the tip', ->
      expect(@north_pop.directional).toBeDefined()

    it 'sets the default container to body', ->
      expect(@north_pop.container).toEqual($('body'))

    it 'blows away the title attribute contents', ->
      expect(@north_el.attr('title')).toEqual('')
      expect(@south_el.attr('title')).toEqual('')


  describe '#toggle', ->
    it 'shows a pop from an elements action', ->
      @west_el.trigger('click')
      pop = $('.pop').first()
      expect(pop).toHaveClass('fade')

    it 'shows and hides a pop on an elements action after a delay', ->
      runs ->
        @north_el.trigger('click')
      waits 150
      runs ->
        pop = $('.pop').first()
        expect(pop).toHaveClass('fade')
      waits 150
      runs ->
        @north_el.trigger('click')
      waits 150
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
    it 'gets rid of toggler', ->
      @west_pop.dispose()
      expect(@west_pop.toggler).toBeNull()

    it 'cleans up its own mess', ->
      spyEvent = spyOn(@west_pop, 'activate')
      @west_pop.dispose()
      @west_el.trigger('click')
      expect(spyEvent).not.toHaveBeenCalled()

    it 'removes the pop when disposed', ->
      $('.pop').remove()
      @override_el.focus()
      expect($('.pop').length).toBeGreaterThan(0)
      @override_pop.dispose()
      expect(@override_pop.pop).toBeNull()
      expect($('.pop').length).toEqual(0)

    it 'removes listeners when disposed', ->
      spyEvent = spyOn(@west_pop, 'removeListeners')
      @west_pop.dispose()
      expect(spyEvent).toHaveBeenCalled()


  describe '#activated', ->
    it 'activates a pop immediately even though it has a delay', ->
      @west_pop.activated()
      pop = $('.pop').first()
      expect(pop).toHaveClass('fade')

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


  describe '#addToViewport', ->
    it 'adds a pop to the viewport', ->
      $('.pop').remove()
      expect($('.pop').length).toEqual(0)
      @east_el.trigger('mouseover')
      expect($('.pop').length).toBeGreaterThan(0)


  describe '#deactivated', ->
    it 'deactivates a pop immediately even though it has a delay', ->
      @north_pop.activated()
      @north_pop.deactivated()
      pop = $('.pop').first()
      expect(pop).not.toHaveClass('in')


  describe '#remove', ->
    it 'removes a pop', ->
      $('.pop').remove()
      @west_pop.activate()
      @west_pop.remove()
      pop = $('.pop').first()
      expect(pop.length).toEqual(0)
      expect(@west_pop.pop).toBeNull()


  describe '#findData', ->
    it 'finds data on the @el when its tip like', ->
      expect(@west_pop.data.content).toEqual(@west_el.data('content'))

    it 'finds data on the external element when its not tip like', ->
      expect(@ext_pop.data.placement).toEqual(@ext_content.data('placement'))
      expect(@ext_pop.data.bubble).toEqual(@ext_content.data('bubble'))


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


  describe '#render', ->
    it 'returns a string for rendering the default markup of a pop', ->
      west_render = @west_pop.render()
      expect(west_render).toContain('class="pop west fade"')
      expect(west_render).toContain('pop-arrow')
      expect(west_render).toContain('pop-inner')
      expect(west_render).toContain('The Western Pop')

