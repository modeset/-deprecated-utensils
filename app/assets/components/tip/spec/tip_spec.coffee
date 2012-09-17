
#= require tip
describe 'Tip', ->

  beforeEach ->
    # Add extra data which we might not want to be shown in documentation from the fixture
    extra = """
            <a id="overrides" data-toggle="active" data-trigger="click" data-effect="move" data-target="#jasmine-fixtures" data-title="The Overrides Tip">Overrides</a>
            """

    loadFixtures('tip')
    @html = $('#jasmine-fixtures')
    @html.append(extra)

    @north_el = @html.find('#north_tip')
    @south_el = @html.find('#south_tip')
    @east_el = @html.find('#east_tip')
    @west_el = @html.find('#west_tip')
    @image_el = @html.find('#image_tip')
    @override_el = @html.find('#overrides')

    @north_tip = new utensil.Tip(@north_el)
    @south_tip = new utensil.Tip(@south_el)
    @east_tip = new utensil.Tip(@east_el)
    @west_tip = new utensil.Tip(@west_el)
    @image_tip = new utensil.Tip(@image_el)
    @override_tip = new utensil.Tip(@override_el)

  afterEach ->
    $('.tip').remove()


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(Bindable.getClass('tip')).toEqual(utensil.Tip)


  describe '#options', ->
    it 'sets up tip toggler options', ->
      expect(@north_tip.toggler.toggle_classes).toEqual('active in')
      expect(@south_tip.toggler.trigger).toEqual(on:'mouseenter', off:'mouseleave')

    it 'sets up tip options', ->
      expect(@south_tip.effect).toEqual('fade')
      expect(@north_tip.placement).toEqual('north')

    it 'overrides tip toggler default options', ->
      expect(@override_tip.toggler.toggle_classes).toEqual('active')
      expect(@override_tip.toggler.trigger).toEqual(on:'click', off:'click')

    it 'overrides tip default options', ->
      expect(@override_tip.toggle_classes).toEqual('active')
      expect(@override_tip.effect).toEqual('move')
      expect(@south_tip.placement).toEqual('south')

    it 'sets content from the title attribute', ->
      expect(@south_tip.title).toEqual('The Southern Tip')

    it 'sets content from the data-title attribute', ->
      expect(@override_tip.title).toEqual('The Overrides Tip')

    it 'sets the toggle type to trigger if the html element has the class "touch"', ->
      expect(@override_tip.toggler.trigger).toEqual(on:'click', off:'click')


  describe '#initialize', ->
    it 'instantiates a class properties with null values', ->
      expect(@north_tip.tip).toBeNull()

    it 'has a directional utility class for placing the tip', ->
      expect(@north_tip.directional).toBeDefined()

    it 'sets the default container to body', ->
      expect(@north_tip.container).toEqual($('body'))

    it 'blows away the title attribute contents', ->
      expect(@north_el.attr('title')).toEqual('')
      expect(@south_el.attr('title')).toEqual('')


  describe '#toggle', ->
    it 'shows a tip from an elements action', ->
      @image_el.trigger('click')
      tip = $('.tip').first()
      expect(tip).toHaveClass('fade')

    it 'shows and hides a tip on an elements action after a delay', ->
      runs ->
        @north_el.trigger('mouseover')
      waits 150
      runs ->
        tip = $('.tip').first()
        expect(tip).toHaveClass('fade')
      waits 150
      runs ->
        @north_el.trigger('mouseout')
      waits 150
      runs ->
        tip = $('.tip').first()
        expect(tip).not.toHaveClass('in')


  describe '#activate', ->
    it 'activates a tip', ->
      @west_tip.activate()
      tip = $('.tip').first()
      expect(tip).toHaveClass('fade')


  describe '#deactivate', ->
    it 'deactivates a tip', ->
      @west_tip.activate()
      @west_tip.deactivate()
      tip = $('.tip').first()
      expect(tip).not.toHaveClass('in')


  describe '#dispose', ->
    it 'gets rid of toggler', ->
      @west_tip.dispose()
      expect(@west_tip.toggler).toBeNull()

    it 'cleans up its own mess', ->
      spyEvent = spyOn(@west_tip, 'activate')
      @west_tip.dispose()
      @west_el.trigger('mouseover')
      expect(spyEvent).not.toHaveBeenCalled()

    it 'removes the tip when disposed', ->
      @override_el.click()
      expect($('.tip').length).toBeGreaterThan(0)
      @override_tip.dispose()
      expect($('.tip').length).toEqual(0)

    it 'removes listeners when disposed', ->
      spyEvent = spyOn(@west_tip, 'removeListeners')
      @west_tip.dispose()
      expect(spyEvent).toHaveBeenCalled()


  describe '#activated', ->
    it 'activates a tip immediately even though it has a delay', ->
      @north_tip.activated()
      tip = $('.tip').first()
      expect(tip).toHaveClass('fade')


  describe '#addToViewport', ->
    it 'adds a tip to the viewport', ->
      expect($('.tip').length).toEqual(0)
      @east_el.trigger('mouseover')
      expect($('.tip').length).toBeGreaterThan(0)


  describe '#deactivated', ->
    it 'deactivates a tip immediately even though it has a delay', ->
      @north_tip.activated()
      @north_tip.deactivated()
      tip = $('.tip').first()
      expect(tip).not.toHaveClass('in')


  describe '#remove', ->
    it 'removes a tip', ->
      @west_tip.activate()
      @west_tip.remove()
      tip = $('.tip').first()
      expect(tip.length).toEqual(0)
      expect(@west_tip.tip).toBeNull()


  describe '#render', ->
    it 'returns a string for rendering the default markup of a tip', ->
      west_render = @west_tip.render()
      expect(west_render).toContain('class="tip west fade"')
      expect(west_render).toContain('tip-arrow')
      expect(west_render).toContain('tip-inner')
      expect(west_render).toContain('The Western Tip')

