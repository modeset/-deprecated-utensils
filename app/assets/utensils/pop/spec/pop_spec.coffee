#= require utensils/pop
#= require utensils/directional
fixture.preload 'pop/markup/pop'

describe 'Pop', ->

  beforeEach ->
    # Add extra data which we might not want to be shown in documentation from the fixture
    extra = """
            <a id="overrides" data-toggle="active" data-trigger="focus" data-effect="move" data-title="The Overrides Pop" data-content="The content" data-placement="east">Overrides</a>
            <a id="auto_activated" data-title="The Active Pop" data-content="The content" data-activate="true">Auto Activated</a>
            """

    fixture.load 'pop/markup/pop'
    @dom = $(fixture.el)
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
      expect(utensils.Bindable.getClass('pop')).to.be utensils.Pop


  describe '#constructor', ->
    it 'displays like a tip', ->
      expect(@north_pop.is_tip_like).to.be true

    it 'does not display like a tip', ->
      expect(@ext_pop.is_tip_like).to.be false

    it 'sets up a data object like a tip', ->
      expect(@north_pop.data).not.to.be undefined

    it 'finds the data object when not tip like', ->
      expect(@ext_pop.data).not.to.be undefined
      expect(@ext_pop.data.placement).to.be 'west'

    it 'auto activates a pop', ->
      expect(@auto_el.hasClass('selected')).to.be true


  describe '#options', ->
    it 'sets default namespace', ->
      expect(@north_pop.data.namespace).to.be 'pop'

    it 'sets the default data.toggle classes to "active in"', ->
      expect(@north_pop.data.toggle).to.be 'active in'

    it 'overrides the default data.toggle classes', ->
      expect(@override_pop.data.toggle).to.be 'active'

    it 'sets the default data.placement to "north"', ->
      expect(@north_pop.data.placement).to.be 'north'

    it 'overrides the default data.placement', ->
      expect(@south_pop.data.placement).to.be 'south'

    it 'sets the default data.title from data-title attribute', ->
      expect(@override_pop.data.title).to.be 'The Overrides Pop'

    it 'sets the default data.title from the title attribute', ->
      expect(@south_pop.data.title).to.be 'The Southern Pop'

    it 'sets the data.content from the content attribute', ->
      expect(@south_pop.data.content).to.contain 'snow goes in the summer'

    it 'sets the default data.effect to "fade"', ->
      expect(@north_pop.data.effect).to.be 'fade'

    it 'overrides the default data.effect', ->
      expect(@override_pop.data.effect).to.be 'move'


  describe '#initialize', ->
    it 'instantiates a class properties with null values', ->
      expect(@north_pop.pop).to.be null
      expect(@north_pop.cached_markup).to.be null

    it 'sets the default container to null', ->
      expect(@north_pop.container.html()).to.be $('body').html()

    it 'sets default namespace', ->
      expect(@east_pop.namespace).to.be 'pop'

    it 'sets the default toggle classes to "active in"', ->
      expect(@north_pop.toggle_classes).to.be 'active in'

    it 'overrides the default toggle classes', ->
      expect(@override_pop.toggle_classes).to.be 'active'

    it 'sets the default placement to "north"', ->
      expect(@north_pop.placement).to.be 'north'

    it 'overrides the default placement', ->
      expect(@south_pop.placement).to.be 'south'

    it 'sets the default title from data-title attribute', ->
      expect(@override_pop.title).to.be 'The Overrides Pop'

    it 'sets the default title from the title attribute', ->
      expect(@south_pop.title).to.be 'The Southern Pop'

    it 'sets the content from the content attribute', ->
      expect(@south_pop.content).to.contain 'snow goes in the summer'

    it 'sets the default effect to "fade"', ->
      expect(@north_pop.effect).to.be 'fade'

    it 'overrides the default effect', ->
      expect(@override_pop.effect).to.be 'move'

    it 'creates an instance of "Triggerable"', ->
      expect(@north_pop.triggerable).to.be.a utensils.Triggerable

    it 'blows away the title attribute contents', ->
      expect(@north_el.attr('title')).to.be ''
      expect(@south_el.attr('title')).to.be ''

    it 'uses Triggerables trigger types', ->
      expect(@north_pop.triggerable.trigger_type).to.eql (on:'click.pop', off:'click.pop')
      expect(@east_pop.triggerable.trigger_type).to.eql (on:'mouseenter.pop focus.pop', off:'mouseleave.pop blur.pop')
      expect(@override_pop.triggerable.trigger_type).to.eql (on:'focus.pop', off:'blur.pop')


  describe '#setup', ->
    it 'creates an instance of "Directional"', ->
      @north_pop.setup()
      expect(@north_pop.directional).to.be.a utensils.Directional

    it 'memoizes the cardinals from "Directional"', ->
      @north_pop.setup()
      expect(@north_pop.cardinals).to.be new utensils.Directional().getCardinals()


  describe '#toggle', ->
    it 'calls through #toggle on the "Triggerable" instance', ->
      spy = sinon.spy @north_pop.triggerable, 'toggle'
      @north_el.click()
      expect(spy.called).to.be.ok()

    it 'shows a pop from an elements action', ->
      @west_el.click()
      pop = $('.pop').first()
      expect(pop.hasClass('fade')).to.be true

    it 'show a pop after a delay', (done) ->
      @north_pop.triggerable.delay.activate = 50
      @north_pop.triggerable.delay.deactivate = 50
      @north_el.trigger('click')
      setTimeout(( =>
        pop = $('.pop').first()
        expect(pop.hasClass('fade')).to.be true
        done()
      ), 50)

    it 'hides a pop after a delay', (done) ->
      @north_pop.triggerable.delay.activate = 0
      @north_pop.triggerable.delay.deactivate = 50
      @north_pop.activated()
      @north_el.trigger('click')
      setTimeout(( =>
        pop = $('.pop').first()
        expect(pop.hasClass('in')).to.be false
        done()
      ), 50)


  describe '#activate', ->
    it 'activates a pop', ->
      @west_pop.activate()
      pop = $('.pop').first()
      expect(pop.hasClass('fade')).to.be true


  describe '#deactivate', ->
    it 'deactivates a pop', ->
      @west_pop.activate()
      @west_pop.deactivate()
      pop = $('.pop').first()
      expect(pop.hasClass('in')).to.be false


  describe '#dispose', ->
    it 'removes listeners when disposed', ->
      spy = sinon.spy @west_pop, 'removeListeners'
      @west_pop.dispose()
      expect(spy.called).to.be.ok()

    it 'gets rid of triggerable', ->
      @west_pop.dispose()
      expect(@west_pop.triggerable).to.be null

    it 'gets rid of directional', ->
      @west_pop.setup()
      @west_pop.dispose()
      expect(@west_pop.directional).to.be null

    it 'does not respond to any further events', ->
      spy = sinon.spy @west_pop, 'activate'
      @west_pop.dispose()
      @west_el.click()
      expect(spy.called).not.to.be.ok()

    it 'removes the pop when disposed', ->
      $('.pop').remove()
      @override_pop.activate()
      expect($('.pop').length).to.be.above 0
      @override_pop.dispose()
      expect(@override_pop.pop).to.be null
      expect($('.pop').length).to.be 0

    it 'does not toss freak out if disposing multiple times', ->
      @west_pop.dispose()
      @west_pop.dispose()
      expect(@west_pop.dispose).not.to.throwException()


  describe '#activated', ->
    it 'activates a pop immediately even though it has a delay', ->
      @west_pop.activated()
      pop = $('.pop').first()
      expect(pop.hasClass('fade')).to.be true
      expect(@west_el.hasClass('selected')).to.be true

    it 'caches internal markup', ->
      expect(@west_pop.cached_markup).to.be null
      @west_el.trigger('click')
      expect(@west_pop.cached_markup).not.to.be null
      expect(@west_pop.cached_markup.find('.pop-arrow')).not.to.be undefined
      expect(@west_pop.cached_markup.find('.pop-header')).not.to.be undefined


  describe '#deactivated', ->
    it 'deactivates a pop immediately even though it has a delay', ->
      @north_pop.activated()
      @north_pop.deactivated()
      pop = $('.pop').first()
      expect(pop.hasClass('in')).to.be false
      expect(@north_el.hasClass('selected')).to.be false


  describe '#add', ->
    it 'sets the default container to body', ->
      @north_pop.activated()
      expect(@north_pop.container.html()).to.be $('body').html()

    it 'adds a pop to the viewport', ->
      $('.pop').remove()
      expect($('.pop').length).to.be 0
      @east_el.trigger('mouseover')
      expect($('.pop').length).to.be.above 0


  describe '#remove', ->
    it 'removes a pop', ->
      $('.pop').remove()
      @west_pop.activate()
      @west_pop.remove()
      pop = $('.pop').first()
      expect(pop.length).to.be 0
      expect(@west_pop.pop).to.be null


  describe '#render', ->
    it 'returns a string for rendering the default markup of a tip', ->
      west_render = @west_pop.render()
      expect(west_render.hasClass('pop west fade')).to.be true
      expect(west_render.find('.pop-inner').html()).to.contain('The Western Pop')


  describe '#findMarkup', ->
    it 'uses the internal render string when the pop is tip like', ->
      spy = sinon.spy @west_pop, 'render'
      @west_pop.findMarkup()
      expect(spy.called).to.be.ok()

    it 'removes the pop-header div when there is no title attribute', ->
      $('.pop').remove()
      @no_title_el.trigger('click')
      pop = $('.pop')
      expect(pop.hasClass('pop-no-header')).to.be true
      expect(pop.find('.pop-header').length).to.be 0

