
#= require toggler
describe 'Toggler', ->

  beforeEach ->
    extra = """
            <a id="stnd_link" href="/some-url">More</a>
            <div id="empty"></div>
            """

    loadFixtures('toggler')
    @html = $('#jasmine-fixtures')
    @html.append(extra)

    @nav = @html.find('.nav')
    @one = @html.find('#one > a')
    @two = @html.find('#two > a')
    @three = @html.find('#three > a')
    @four = @html.find('#four > a')
    @five = @html.find('#five > a')
    @six = @html.find('#six > a')
    @empty = @html.find('#empty')
    @link = @html.find('#stnd_link')

    @defaulter = new utensil.Toggler(@one)
    @overrider = new utensil.Toggler(@two)
    @spanner = new utensil.Toggler(@three)
    @closest = new utensil.Toggler(@four)
    @bubbler = new utensil.Toggler(@five)
    @active = new utensil.Toggler(@six)
    @stnd_link = new utensil.Toggler(@link)


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(Bindable.getClass('toggler')).toEqual(utensil.Toggler)


  describe '#constructor', ->
    it 'defaults to inactive', ->
      expect(@defaulter.is_active).toEqual(false)
    it 'sets up a data object', ->
      expect(@defaulter.data).toBeDefined()


  describe '#options', ->
    it 'sets default options', ->
      expect(@defaulter.toggle_classes).toEqual('active')
      expect(@defaulter.trigger).toEqual('click')
      expect(@defaulter.lookup).toEqual('find')

    it 'overrides default options', ->
      expect(@overrider.toggle_classes).toEqual('fade')
      expect(@overrider.trigger).toEqual('hover')
      expect(@closest.lookup).toEqual('closest')

    it 'sets the ability for dual toggles by default', ->
      expect(@closest.dual_toggle).toEqual(true)

    it 'does not set the ability for dual toggles if the toggler is @el', ->
      expect(@defaulter.dual_toggle).toEqual(false)

    it 'does not set dual toggle when passed as an attribute', ->
      expect(@spanner.dual_toggle).toEqual(false)

    it 'sets default values from a javascript class', ->
      toggler = new utensil.Toggler(@empty, {toggle: 'show', trigger: 'hover', lookup: 'closest'})
      expect(toggler.toggle_classes).toEqual('show')
      expect(toggler.trigger).toEqual('hover')
      expect(toggler.lookup).toEqual('closest')
      expect(toggler.target).toEqual(@empty)


  describe '#initialize', ->
    it 'activates an element on initialization', ->
      toggler = new utensil.Toggler(@empty, {activate: 'true'})
      expect(@empty).toHaveClass('active')


  describe '#getTarget', ->
    it 'finds itself as an element when there is no href or data-target present', ->
      expect(@defaulter.target).toEqual(@one)

    it 'returns itself when there is an "#this" target attached to the href', ->
      expect(@overrider.target).toEqual(@two)

    it 'returns itself when there is a "#" target attached to the href', ->
      expect(@active.target).toEqual(@six)

    it 'returns itself when there is a "normal link" target attached to the href', ->
      expect(@stnd_link.target).toEqual(@link)

    it 'finds the parent element from a selector within the href attribute', ->
      expect(@closest.target.html()).toEqual(@nav.html())

    it 'finds the parent element from a "data-target" attribute', ->
      expect(@bubbler.target.html()).toEqual(@nav.html())

    it 'uses $.find by default', ->
      expect(@spanner.lookup).toEqual('find')
      expect(@spanner.target.html()).toEqual(@three.find('span').html())

    it 'uses $.closest when provided as a lookup fn', ->
      expect(@closest.lookup).toEqual('closest')
      expect(@closest.target.html()).toEqual(@nav.html())


  describe '#toggle', ->
    it 'toggles the correct classes from a trigger', ->
      spyEvent = spyOn(@defaulter, 'toggle').andCallThrough()
      @one.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'toggles the default classes from a call', ->
      expect(@one).not.toHaveClass('active')
      expect(@defaulter.is_active).toEqual(false)

      @defaulter.toggle()
      expect(@one).toHaveClass('active')
      expect(@defaulter.is_active).toEqual(true)

      @defaulter.toggle()
      expect(@one).not.toHaveClass('active')
      expect(@defaulter.is_active).toEqual(false)

    it 'toggles the custom classes from a call on both the element and target', ->
      expect(@four).toHaveClass('inline')
      expect(@nav).toHaveClass('inline')
      expect(@closest.is_active).toEqual(false)

      @closest.toggle()
      expect(@four).not.toHaveClass('inline')
      expect(@nav).not.toHaveClass('inline')
      expect(@closest.is_active).toEqual(true)

      @closest.toggle()
      expect(@four).toHaveClass('inline')
      expect(@nav).toHaveClass('inline')
      expect(@closest.is_active).toEqual(false)

    it 'toggles only the target and not the element when specified', ->
      expect(@three.find('span')).not.toHaveClass('fade')
      expect(@three).not.toHaveClass('fade')

      @spanner.toggle()
      expect(@three.find('span')).toHaveClass('fade')
      expect(@three).not.toHaveClass('fade')

      @spanner.toggle()
      expect(@three.find('span')).not.toHaveClass('fade')
      expect(@three).not.toHaveClass('fade')


  describe '#activate', ->
    it 'adds classes to the element', ->
      expect(@one).not.toHaveClass('active')
      expect(@defaulter.is_active).toEqual(false)

      @defaulter.activate()
      expect(@one).toHaveClass('active')
      expect(@defaulter.is_active).toEqual(true)


  describe '#deactivate', ->
    it 'removes classes from the element', ->
      expect(@one).not.toHaveClass('active')
      expect(@defaulter.is_active).toEqual(false)

      @defaulter.activate()
      expect(@one).toHaveClass('active')
      expect(@defaulter.is_active).toEqual(true)

      @defaulter.deactivate()
      expect(@one).not.toHaveClass('active')
      expect(@defaulter.is_active).toEqual(false)


  describe '#dispose', ->
    it 'cleans up its own mess', ->
      spyEvent = spyOn(@defaulter, 'toggle')
      @defaulter.dispose()
      @one.click()
      expect(spyEvent).not.toHaveBeenCalled()

