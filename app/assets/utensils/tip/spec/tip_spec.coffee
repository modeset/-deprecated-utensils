#= require utensils/tip
#= require utensils/directional

describe 'Tip', ->

  beforeEach ->
    # Add extra data which we might not want to be shown in documentation from the fixture
    extra = """
            <a id="overrides" data-toggle="active" data-trigger="click" data-effect="move" data-target="#jasmine-fixtures" data-title="The Overrides Tip">Overrides</a>
            """

    loadFixtures('tip')
    @dom = $('#teabag-fixtures')
    @dom.append(extra)

    @north_el = @dom.find('#north_tip')
    @south_el = @dom.find('#south_tip')
    @east_el = @dom.find('#east_tip')
    @west_el = @dom.find('#west_tip')
    @image_el = @dom.find('#image_tip')
    @override_el = @dom.find('#overrides')

    @north_tip = new utensils.Tip(@north_el)
    @south_tip = new utensils.Tip(@south_el)
    @east_tip = new utensils.Tip(@east_el)
    @west_tip = new utensils.Tip(@west_el)
    @image_tip = new utensils.Tip(@image_el)
    @override_tip = new utensils.Tip(@override_el)

  afterEach ->
    $('.tip').remove()


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('tip')).toEqual(utensils.Tip)


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@north_tip.data).toBeDefined()


  describe '#options', ->

    it 'sets default namespace', ->
      expect(@north_tip.data.namespace).toEqual('tip')

    it 'sets the default data.trigger state to "hover"', ->
      expect(@north_tip.data.trigger).toEqual('hover')

    it 'overrides the default data.trigger state to "click"', ->
      expect(@image_tip.data.trigger).toEqual('click')

    it 'sets the default data.toggle classes to "active in"', ->
      expect(@north_tip.data.toggle).toEqual('active in')

    it 'overrides the default data.toggle classes', ->
      expect(@override_tip.data.toggle).toEqual('active')

    it 'sets the default data.placement to "north"', ->
      expect(@north_tip.data.placement).toEqual('north')

    it 'overrides the default data.placement', ->
      expect(@south_tip.data.placement).toEqual('south')

    it 'sets the default data.title from data-title attribute', ->
      expect(@override_tip.data.title).toEqual('The Overrides Tip')

    it 'sets the default data.title from the title attribute', ->
      expect(@south_tip.data.title).toEqual('The Southern Tip')

    it 'sets the default data.effect to "fade"', ->
      expect(@north_tip.data.effect).toEqual('fade')

    it 'overrides the default data.effect', ->
      expect(@override_tip.data.effect).toEqual('move')


  describe '#initialize', ->
    it 'instantiates a class properties with null values', ->
      expect(@north_tip.tip).toBeNull()

    it 'sets the default container to null', ->
      expect(@north_tip.container).toBeNull()

    it 'sets default namespace', ->
      expect(@east_tip.namespace).toEqual('tip')

    it 'sets the default toggle classes to "active in"', ->
      expect(@north_tip.toggle_classes).toEqual('active in')

    it 'overrides the default toggle classes', ->
      expect(@override_tip.toggle_classes).toEqual('active')

    it 'sets the default placement to "north"', ->
      expect(@north_tip.placement).toEqual('north')

    it 'overrides the default placement', ->
      expect(@south_tip.placement).toEqual('south')

    it 'sets the default title from data-title attribute', ->
      expect(@override_tip.title).toEqual('The Overrides Tip')

    it 'sets the default title from the title attribute', ->
      expect(@south_tip.title).toEqual('The Southern Tip')

    it 'sets the default effect to "fade"', ->
      expect(@north_tip.effect).toEqual('fade')

    it 'overrides the default effect', ->
      expect(@override_tip.effect).toEqual('move')

    it 'creates an instance of "Triggerable"', ->
      expect(@north_tip.triggerable instanceof utensils.Triggerable).toEqual(true)

    it 'blows away the title attribute contents', ->
      expect(@north_el.attr('title')).toEqual('')
      expect(@south_el.attr('title')).toEqual('')

    it 'uses Triggerables trigger types', ->
      expect(@east_tip.triggerable.trigger_type).toEqual(on:'mouseenter.tip focus.tip', off:'mouseleave.tip blur.tip')
      expect(@override_tip.triggerable.trigger_type).toEqual(on:'click.tip', off:'click.tip')


  describe '#setup', ->
    it 'creates an instance of "Directional"', ->
      @north_tip.setup()
      expect(@north_tip.directional instanceof utensils.Directional).toEqual(true)

    it 'memoizes the cardinals from "Directional"', ->
      @north_tip.setup()
      expect(@north_tip.cardinals).toEqual(new utensils.Directional().getCardinals())


  describe '#toggle', ->
    it 'calls through #toggle on the "Triggerable" instance', ->
      spyEvent = spyOn(@image_tip.triggerable, 'toggle')
      @image_el.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'shows a tip from an elements action', ->
      @image_el.click()
      tip = $('.tip').first()
      expect(tip).toHaveClass('fade')

    it 'shows and hides a tip on an elements action after a delay', ->
      # override the delay to speed up the tests.
      @north_tip.triggerable.delay.activate = 50
      @north_tip.triggerable.delay.deactivate = 50

      runs ->
        @north_el.trigger('mouseover')
      waits 50
      runs ->
        tip = $('.tip').first()
        expect(tip).toHaveClass('fade')
      waits 50
      runs ->
        @north_el.trigger('mouseout')
      waits 50
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
    it 'removes listeners when disposed', ->
      spyEvent = spyOn(@west_tip, 'removeListeners')
      @west_tip.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'gets rid of triggerable', ->
      @west_tip.dispose()
      expect(@west_tip.triggerable).toBeNull()

    it 'gets rid of directional', ->
      @west_tip.setup()
      @west_tip.dispose()
      expect(@west_tip.directional).toBeNull()

    it 'does not respond to any further events', ->
      spyEvent = spyOn(@west_tip, 'activate')
      @west_tip.dispose()
      @west_el.trigger('mouseover')
      expect(spyEvent).not.toHaveBeenCalled()

    it 'removes the tip when disposed', ->
      @override_el.click()
      expect($('.tip').length).toBeGreaterThan(0)
      @override_tip.dispose()
      expect($('.tip').length).toEqual(0)

    it 'does not freak out if disposing multiple times', ->
      @west_tip.dispose()
      @west_tip.dispose()
      expect(@west_tip.dispose).not.toThrow()


  describe '#activated', ->
    it 'activates a tip immediately even though it has a delay', ->
      @north_tip.activated()
      tip = $('.tip').first()
      expect(tip).toHaveClass('fade')
      expect(@north_el).toHaveClass('selected')


  describe '#deactivated', ->
    it 'deactivates a tip immediately even though it has a delay', ->
      @north_tip.activated()
      @north_tip.deactivated()
      tip = $('.tip').first()
      expect(tip).not.toHaveClass('in')
      expect(@north_el).not.toHaveClass('selected')


  describe '#add', ->
    it 'sets the default container to body', ->
      @north_tip.activated()
      expect(@north_tip.container).toEqual($('body'))

    it 'adds a tip to the viewport', ->
      expect($('.tip').length).toEqual(0)
      @east_el.trigger('mouseover')
      expect($('.tip').length).toBeGreaterThan(0)


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
      expect(west_render).toHaveClass('tip west fade')
      expect(west_render.find('.tip-inner').html()).toContain('The Western Tip')

