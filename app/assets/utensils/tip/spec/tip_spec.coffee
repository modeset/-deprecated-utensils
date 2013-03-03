#= require utensils/tip
#= require utensils/directional
fixture.preload 'tip/markup/tip'

describe 'Tip', ->

  beforeEach ->
    # Add extra data which we might not want to be shown in documentation from the fixture
    extra = """
            <a id="overrides" data-toggle="active" data-trigger="click" data-effect="move" data-target="#jasmine-fixtures" data-title="The Overrides Tip">Overrides</a>
            """

    fixture.load 'tip/markup/tip'
    @dom = $(fixture.el)
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
      expect(utensils.Bindable.getClass('tip')).to.be utensils.Tip


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@north_tip.data).not.to.be undefined


  describe '#options', ->
    it 'sets default namespace', ->
      expect(@north_tip.data.namespace).to.be 'tip'

    it 'sets the default data.trigger state to "hover"', ->
      expect(@north_tip.data.trigger).to.be 'hover'

    it 'overrides the default data.trigger state to "click"', ->
      expect(@image_tip.data.trigger).to.be 'click'

    it 'sets the default data.toggle classes to "active in"', ->
      expect(@north_tip.data.toggle).to.be 'active in'

    it 'overrides the default data.toggle classes', ->
      expect(@override_tip.data.toggle).to.be 'active'

    it 'sets the default data.placement to "north"', ->
      expect(@north_tip.data.placement).to.be 'north'

    it 'overrides the default data.placement', ->
      expect(@south_tip.data.placement).to.be 'south'

    it 'sets the default data.title from data-title attribute', ->
      expect(@override_tip.data.title).to.be 'The Overrides Tip'

    it 'sets the default data.title from the title attribute', ->
      expect(@south_tip.data.title).to.be 'The Southern Tip'

    it 'sets the default data.effect to "fade"', ->
      expect(@north_tip.data.effect).to.be 'fade'

    it 'overrides the default data.effect', ->
      expect(@override_tip.data.effect).to.be 'move'


  describe '#initialize', ->
    it 'instantiates a class properties with null values', ->
      expect(@north_tip.tip).to.be null

    it 'sets the default container to null', ->
      expect(@north_tip.container).to.be null

    it 'sets default namespace', ->
      expect(@east_tip.namespace).to.be 'tip'

    it 'sets the default toggle classes to "active in"', ->
      expect(@north_tip.toggle_classes).to.be 'active in'

    it 'overrides the default toggle classes', ->
      expect(@override_tip.toggle_classes).to.be 'active'

    it 'sets the default placement to "north"', ->
      expect(@north_tip.placement).to.be 'north'

    it 'overrides the default placement', ->
      expect(@south_tip.placement).to.be 'south'

    it 'sets the default title from data-title attribute', ->
      expect(@override_tip.title).to.be 'The Overrides Tip'

    it 'sets the default title from the title attribute', ->
      expect(@south_tip.title).to.be 'The Southern Tip'

    it 'sets the default effect to "fade"', ->
      expect(@north_tip.effect).to.be 'fade'

    it 'overrides the default effect', ->
      expect(@override_tip.effect).to.be 'move'

    it 'creates an instance of "Triggerable"', ->
      expect(@north_tip.triggerable).to.be.a utensils.Triggerable

    it 'blows away the title attribute contents', ->
      expect(@north_el.attr('title')).to.be ''
      expect(@south_el.attr('title')).to.be ''

    it 'uses Triggerables trigger types', ->
      expect(@east_tip.triggerable.trigger_type).to.eql(on:'mouseenter.tip focus.tip', off:'mouseleave.tip blur.tip')
      expect(@override_tip.triggerable.trigger_type).to.eql(on:'click.tip', off:'click.tip')


  describe '#setup', ->
    it 'creates an instance of "Directional"', ->
      @north_tip.setup()
      expect(@north_tip.directional).to.be.a utensils.Directional

    it 'memoizes the cardinals from "Directional"', ->
      @north_tip.setup()
      expect(@north_tip.cardinals).to.be new utensils.Directional().getCardinals()


  describe '#toggle', ->
    it 'calls through #toggle on the "Triggerable" instance', ->
      spy = sinon.spy @image_tip.triggerable, 'toggle'
      @image_el.click()
      expect(spy.called).to.be.ok()

    it 'shows a tip from an elements action', ->
      @image_el.click()
      tip = $('.tip').first()
      expect(tip.hasClass('fade')).to.be true

    it 'show a tip after a delay', (done) ->
      @north_tip.triggerable.delay.activate = 50
      @north_tip.triggerable.delay.deactivate = 50
      @north_el.trigger('mouseover')
      setTimeout(( =>
        tip = $('.tip').first()
        expect(tip.hasClass('fade')).to.be true
        done()
      ), 50)

    it 'hides a tip after a delay', (done) ->
      @north_tip.triggerable.delay.activate = 0
      @north_tip.triggerable.delay.deactivate = 50
      @north_tip.activated()
      @north_el.trigger('mouseout')
      setTimeout(( =>
        tip = $('.tip').first()
        expect(tip.hasClass('in')).to.be false
        done()
      ), 50)


  describe '#activate', ->
    it 'activates a tip', ->
      @west_tip.activate()
      tip = $('.tip').first()
      expect(tip.hasClass('fade')).to.be true


  describe '#deactivate', ->
    it 'deactivates a tip', ->
      @west_tip.activate()
      @west_tip.deactivate()
      tip = $('.tip').first()
      expect(tip.hasClass('in')).to.be false


  describe '#dispose', ->
    it 'removes listeners when disposed', ->
      spy = sinon.spy @west_tip, 'removeListeners'
      @west_tip.dispose()
      expect(spy.called).to.be.ok()

    it 'gets rid of triggerable', ->
      @west_tip.dispose()
      expect(@west_tip.triggerable).to.be null

    it 'gets rid of directional', ->
      @west_tip.setup()
      @west_tip.dispose()
      expect(@west_tip.directional).to.be null

    it 'does not respond to any further events', ->
      spy = sinon.spy @west_tip, 'activate'
      @west_tip.dispose()
      @west_el.trigger('mouseover')
      expect(spy.called).not.to.be.ok()

    it 'removes the tip when disposed', ->
      @override_el.click()
      expect($('.tip').length).to.be.above 0
      @override_tip.dispose()
      expect($('.tip').length).to.be 0

    it 'does not freak out if disposing multiple times', ->
      @west_tip.dispose()
      @west_tip.dispose()
      expect(@west_tip.dispose).not.to.throwException()


  describe '#activated', ->
    it 'activates a tip immediately even though it has a delay', ->
      @north_tip.activated()
      tip = $('.tip').first()
      expect(tip.hasClass('fade')).to.be true
      expect(@north_el.hasClass('selected')).to.be true


  describe '#deactivated', ->
    it 'deactivates a tip immediately even though it has a delay', ->
      @north_tip.activated()
      @north_tip.deactivated()
      tip = $('.tip').first()
      expect(tip.hasClass('in')).to.be false
      expect(@north_el.hasClass('selected')).to.be false


  describe '#add', ->
    it 'sets the default container to body', ->
      @north_tip.activated()
      expect(@north_tip.container.html()).to.be $('body').html()

    it 'adds a tip to the viewport', ->
      expect($('.tip').length).to.be 0
      @east_el.trigger('mouseover')
      expect($('.tip').length).to.be.above 0


  describe '#remove', ->
    it 'removes a tip', ->
      @west_tip.activate()
      @west_tip.remove()
      tip = $('.tip').first()
      expect(tip.length).to.be 0
      expect(@west_tip.tip).to.be null


  describe '#render', ->
    it 'returns a string for rendering the default markup of a tip', ->
      west_render = @west_tip.render()
      expect(west_render.hasClass('tip west fade')).to.be true
      expect(west_render.find('.tip-inner').html()).to.contain 'The Western Tip'

