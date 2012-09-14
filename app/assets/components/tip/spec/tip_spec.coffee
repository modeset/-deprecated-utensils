
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

    # @shell_el = @html.find('#shell')
    @north_el = @html.find('#north')
    @south_el = @html.find('#south')
    @east_el = @html.find('#east')
    @west_el = @html.find('#west')
    @image_el = @html.find('#image')
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
    it 'sets up basic default options', ->
      expect(@north_tip.toggle_classes).toEqual('in')
      expect(@south_tip.trigger).toEqual('hover')
      expect(@south_tip.target).toBe($('body'))
      expect(@south_tip.effect).toEqual('fade')
      expect(@north_tip.placement).toEqual('north')
      expect(@south_tip.placement).toEqual('south')
      expect(@north_tip.lookup).toEqual('closest')

    it 'overrides the default options', ->
      expect(@override_tip.toggle_classes).toEqual('active')
      expect(@override_tip.trigger).toEqual('click')
      expect(@override_tip.target).toBe(@html)
      expect(@override_tip.effect).toEqual('move')

    it 'sets content from the title attribute', ->
      expect(@south_tip.content).toEqual('The Southern Tip')

    it 'sets content from the data-title attribute', ->
      expect(@override_tip.content).toEqual('The Overrides Tip')

    it 'sets the toggle type to trigger if the html element has the class "touch"', ->
      expect(@override_tip.trigger).toEqual('click')


  describe '#initialize', ->
    it 'instantiates a class properties with null values', ->
      expect(@north_tip.tip).toBeNull()
      expect(@north_tip.timeout).toBeNull()

    it 'blows away the title attribute contents', ->
      expect(@north_el.attr('title')).toEqual('')
      expect(@south_el.attr('title')).toEqual('')


  describe '#toggle', ->
    it 'shows a tip on from an elements action', ->
      @image_el.trigger('click')
      tip = $('.tip').first()
      expect(tip).toHaveClass('fade')

    it 'shows a tip on an elements action after a delay', ->
      runs ->
        @north_el.trigger('mouseover')
      waits 150
      runs ->
        tip = $('.tip').first()
        expect(tip).toHaveClass('fade')

    it 'hides a tip on an elements action after a delay', ->
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

    it 'activates a tip immediately even though it has a delay', ->
      @north_tip.activate()
      tip = $('.tip').first()
      expect(tip).toHaveClass('fade')


  describe '#deactivate', ->
    it 'deactivates a tip', ->
      @west_tip.activate()
      @west_tip.deactivate()
      tip = $('.tip').first()
      expect(tip).not.toHaveClass('in')

    it 'deactivates a tip immediately even though it has a delay', ->
      @north_tip.activate()
      @north_tip.deactivate()
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


  describe '#getDelay', ->
    it 'sets up a default delay of 0 for show and hide', ->
      expect(@west_tip.delay.show).toEqual(0)
      expect(@west_tip.delay.hide).toEqual(0)

    it 'sets up delay.show and delay.hide with the same value from a number as the data attribute', ->
      expect(@north_tip.delay.show).toEqual(100)
      expect(@north_tip.delay.hide).toEqual(100)

    it 'sets up delay.show and delay.hide with the their own values from an object data attribute', ->
      expect(@south_tip.delay.show).toEqual(1000)
      expect(@south_tip.delay.hide).toEqual(2000)

    it 'tests various settings for show and hide attributes', ->
      show_hide = new utensil.Tip(@html, {delay: 'show:1000, hide:2000'})
      hide_show = new utensil.Tip(@html, {delay: 'hide:4000, hide:5000'})
      expect(show_hide.delay.show).toEqual(1000)
      expect(show_hide.delay.hide).toEqual(2000)
      expect(hide_show.delay.show).toEqual(4000)
      expect(hide_show.delay.hide).toEqual(5000)

