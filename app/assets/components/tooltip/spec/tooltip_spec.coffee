
#= require tooltip
describe 'Tooltip', ->

  beforeEach ->
    html = """
           <section id="shell">
             <a id="north" data-trigger="click" data-delay="100" data-title="The Northern Tip" href="#">North</a>
             <a id="south" data-delay="100,200" data-placement="south" href="#" title="The Southern Tip">South</a>
             <a id="east" data-placement="east" href="#" title="The Eastern Tip">East</a>
             <a id="west" data-trigger="click" data-placement="west" href="#" title="The Western Tip">West</a>
             <a id="image" data-toggle="active" href="#" data-trigger="click" data-target="#shell" data-effect="move" title="<img src='http://placehold.it/350x150'/>">Image</a>
             <a id="empty" title="The Empty Tip">Empty</a>
           </section>
           """
    @html = $(html)
    setFixtures(@html)
    @shell_el = @html.find('#shell')
    @north_el = @html.find('#north')
    @south_el = @html.find('#south')
    @east_el = @html.find('#east')
    @west_el = @html.find('#west')
    @image_el = @html.find('#image')
    @empty_el = @html.find('#empty')

    @north_tip = new roos.Tooltip(@north_el)
    @south_tip = new roos.Tooltip(@south_el)
    @east_tip = new roos.Tooltip(@east_el)
    @west_tip = new roos.Tooltip(@west_el)
    @image_tip = new roos.Tooltip(@image_el)

  afterEach ->
    $('.tooltip').remove()


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(Bindable.getClass('tooltip')).toEqual(roos.Tooltip)


  describe '#options', ->
    it 'sets up basic default options', ->
      expect(@north_tip.toggle_classes).toEqual('in')
      expect(@south_tip.trigger).toEqual('hover')
      expect(@north_tip.target[0]).toEqual($('body')[0])
      expect(@south_tip.effect).toEqual('fade')
      expect(@north_tip.placement).toEqual('north')
      expect(@south_tip.placement).toEqual('south')
      expect(@north_tip.lookup).toEqual('closest')

    it 'overrides the default options', ->
      expect(@image_tip.toggle_classes).toEqual('active')
      expect(@image_tip.trigger).toEqual('click')
      expect(@image_tip.target[0]).toEqual($('#shell')[0])
      expect(@image_tip.effect).toEqual('move')

    it 'sets content from the title attribute', ->
      expect(@south_tip.content).toEqual('The Southern Tip')

    it 'sets content from the data-title attribute', ->
      expect(@north_tip.content).toEqual('The Northern Tip')

    it 'sets the toggle type to trigger if the html element has the class "touch"', ->
      $('html').addClass('touch')
      tip = new roos.Tooltip(@empty_el)
      expect(tip.trigger).toEqual('click')


  describe '#initialize', ->
    it 'instantiates a class properties with null values', ->
      expect(@north_tip.tip).toBeNull()
      expect(@north_tip.timeout).toBeNull()

    it 'blows away the title attribute contents', ->
      expect(@north_el.attr('title')).toEqual('')
      expect(@south_el.attr('title')).toEqual('')


  describe '#toggle', ->
    it 'shows a tooltip on from an elements action', ->
      @west_el.trigger('click')
      tip = $('.tooltip').first()
      expect(tip).toHaveClass('fade')

    it 'shows a tooltip on an elements action after a delay', ->
      runs ->
        @north_el.trigger('click')
      waits 150
      runs ->
        tip = $('.tooltip').first()
        expect(tip).toHaveClass('fade')

    it 'hides a tooltip on an elements action after a delay', ->
      runs ->
        @north_el.trigger('click')
      waits 150
      runs ->
        tip = $('.tooltip').first()
        expect(tip).toHaveClass('fade')
      waits 150
      runs ->
        @north_el.trigger('click')
      waits 150
      runs ->
        tip = $('.tooltip').first()
        expect(tip).not.toHaveClass('in')


  describe '#activate', ->
    it 'activates a tooltip', ->
      @west_tip.activate()
      tip = $('.tooltip').first()
      expect(tip).toHaveClass('fade')

    it 'activates a tooltip immediately even though it has a delay', ->
      @north_tip.activate()
      tip = $('.tooltip').first()
      expect(tip).toHaveClass('fade')


  describe '#deactivate', ->
    it 'deactivates a tooltip', ->
      @west_tip.activate()
      @west_tip.deactivate()
      tip = $('.tooltip').first()
      expect(tip).not.toHaveClass('in')

    it 'deactivates a tooltip immediately even though it has a delay', ->
      @north_tip.activate()
      @north_tip.deactivate()
      tip = $('.tooltip').first()
      expect(tip).not.toHaveClass('in')


  describe '#remove', ->
    it 'removes a tooltip', ->
      @west_tip.activate()
      @west_tip.remove()
      tip = $('.tooltip').first()
      expect(tip.length).toEqual(0)
      expect(@west_tip.tip).toBeNull()


  describe '#render', ->
    it 'returns a string for rendering the default markup of a tool tip', ->
      west_render = @west_tip.render()
      expect(west_render).toContain('class="tooltip west fade"')
      expect(west_render).toContain('tooltip-arrow')
      expect(west_render).toContain('tooltip-inner')
      expect(west_render).toContain('The Western Tip')


  describe '#getPlacement', ->
    it 'places an item north of the link', ->
      @north_tip.activate()
      pos = @north_tip.getPlacement('north')
      elp = @north_el.offset().top
      expect(pos.top).toBeLessThan(elp)

    it 'places an item south of the link', ->
      @south_tip.activate()
      pos = @south_tip.getPlacement('south')
      elp = @south_el.offset().top
      expect(pos.top).toBeGreaterThan(elp)

    it 'places an item east of the link', ->
      @east_tip.activate()
      pos = @east_tip.getPlacement('east')
      elp = @east_el.offset().left
      expect(pos.left).toBeGreaterThan(elp)

    it 'places an item west of the link', ->
      @west_tip.activate()
      pos = @west_tip.getPlacement('west')
      elp = @west_el.offset().left
      expect(pos.left).toBeLessThan(elp)


  describe '#inBounds', ->
    it 'repositions the item on stage when north is offscreen', ->
      @north_el.css(position:'absolute', top:'0', left:'500')
      @north_tip.activate()
      expect($('.tooltip').first()).toHaveClass('south')

    it 'repositions the item on stage when south is offscreen', ->
      @south_el.css(position:'absolute', bottom:'0', left:'500')
      @south_tip.activate()
      expect($('.tooltip').first()).toHaveClass('north')

    it 'repositions the item on stage when east is offscreen', ->
      @east_el.css(position:'absolute', top:'0', right:'0')
      @east_tip.activate()
      expect($('.tooltip').first()).toHaveClass('west')

    it 'repositions the item on stage when west is offscreen', ->
      @west_el.css(position:'absolute', top:'0', left:'0')
      @west_tip.activate()
      expect($('.tooltip').first()).toHaveClass('east')


  describe '#getDelay', ->
    it 'sets up a default delay of 0 for show and hide', ->
      expect(@west_tip.delay.show).toEqual(0)
      expect(@west_tip.delay.hide).toEqual(0)

    it 'sets up delay.show and delay.hide with the same value from a number as the data attribute', ->
      expect(@north_tip.delay.show).toEqual(100)
      expect(@north_tip.delay.hide).toEqual(100)

    it 'sets up delay.show and delay.hide with the their own values from an object data attribute', ->
      expect(@south_tip.delay.show).toEqual(100)
      expect(@south_tip.delay.hide).toEqual(200)

    it 'tests various settings for show and hide attributes', ->
      show_hide = new roos.Tooltip(@shell_el, {delay: 'show:1000, hide:2000'})
      hide_show = new roos.Tooltip(@shell_el, {delay: 'hide:4000, hide:5000'})
      expect(show_hide.delay.show).toEqual(1000)
      expect(show_hide.delay.hide).toEqual(2000)
      expect(hide_show.delay.show).toEqual(4000)
      expect(hide_show.delay.hide).toEqual(5000)

