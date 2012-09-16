
#= require togglable

describe 'Togglable', ->

  beforeEach ->
    extra = """
            <a id="stnd_link" href="/some-url">More</a>
            <div id="empty"></div>
            """

    loadFixtures('togglable')
    @html = $('#jasmine-fixtures')
    @html.append(extra)

    @nav = @html.find('.nav')
    @one = @html.find('#one > a')
    @two = @html.find('#two > a')
    @three = @html.find('#three > a')
    @four = @html.find('#four > a')
    @five = @html.find('#five > a')
    @six = @html.find('#six > a')
    @seven = @html.find('#seven > a')
    @eight = @html.find('#eight > a')
    @link = @html.find('#stnd_link')
    @empty = @html.find('#empty')
    @context_el = @html.find('#context')

    @defaulter = new utensil.Togglable(@one)
    @overrider = new utensil.Togglable(@two)
    @spanner = new utensil.Togglable(@three)
    @closest = new utensil.Togglable(@four)
    @bubbler = new utensil.Togglable(@five)
    @active = new utensil.Togglable(@six)
    @contexter = new utensil.Togglable(@seven)
    @delayer = new utensil.Togglable(@eight)
    @stnd_link = new utensil.Togglable(@link)


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(Bindable.getClass('togglable')).toEqual(utensil.Togglable)


  describe '#constructor', ->
    it 'defaults to inactive', ->
      expect(@defaulter.is_active).toEqual(false)
    it 'sets up a data object', ->
      expect(@defaulter.data).toBeDefined()

    it 'sets up a dispatcher property', ->
      expect(@defaulter.dispatcher).toEqual(@one)


  describe '#options', ->
    it 'sets default options', ->
      expect(@defaulter.toggle_classes).toEqual('active')
      expect(@defaulter.trigger).toEqual(on:'click', off:'click')
      expect(@defaulter.lookup).toEqual('find')

    it 'overrides default options', ->
      expect(@overrider.toggle_classes).toEqual('fade')
      expect(@overrider.trigger).toEqual(on:'mouseenter', off:'mouseleave')
      expect(@closest.lookup).toEqual('closest')

    it 'sets the ability for dual toggles by default', ->
      expect(@closest.dual_toggle).toEqual(true)

    it 'does not set the ability for dual toggles if the togglable is @el', ->
      expect(@defaulter.dual_toggle).toEqual(false)

    it 'does not set dual toggle when passed as an attribute', ->
      expect(@spanner.dual_toggle).toEqual(false)

    it 'sets default values from a javascript class', ->
      togglable = new utensil.Togglable(@empty, {toggle: 'show', trigger: 'hover', lookup: 'closest'})
      expect(togglable.toggle_classes).toEqual('show')
      expect(togglable.trigger).toEqual(on:'mouseenter', off:'mouseleave')
      expect(togglable.lookup).toEqual('closest')
      expect(togglable.target).toEqual(@empty)

    it 'sets the correct context for lookups', ->
      expect(@contexter.context).toEqual($('body'))
      expect(@defaulter.context).toEqual(@one)


  describe '#initialize', ->
    it 'activates an element on initialization', ->
      togglable = new utensil.Togglable(@empty, {activate: 'true'})
      expect(@empty).toHaveClass('active')


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
      expect(@closest.is_active).toEqual(true)

      @closest.toggle()
      expect(@four).not.toHaveClass('inline')
      expect(@nav).not.toHaveClass('inline')
      expect(@closest.is_active).toEqual(false)

      @closest.toggle()
      expect(@four).toHaveClass('inline')
      expect(@nav).toHaveClass('inline')
      expect(@closest.is_active).toEqual(true)

    it 'toggles only the target and not the element when specified', ->
      expect(@three.find('span')).not.toHaveClass('fade')
      expect(@three).not.toHaveClass('fade')

      @spanner.toggle()
      expect(@three.find('span')).toHaveClass('fade')
      expect(@three).not.toHaveClass('fade')

      @spanner.toggle()
      expect(@three.find('span')).not.toHaveClass('fade')
      expect(@three).not.toHaveClass('fade')

    it 'toggles a context object searching from the body', ->
      heading = $('#togglable_heading')
      expect(heading).not.toHaveClass('fade')

      @contexter.toggle()
      expect(heading).toHaveClass('fade')

      @contexter.toggle()
      expect(heading).not.toHaveClass('fade')


  describe '#activate', ->
    it 'adds classes to the element', ->
      expect(@one).not.toHaveClass('active')
      expect(@defaulter.is_active).toEqual(false)

      @defaulter.activate()
      expect(@one).toHaveClass('active')
      expect(@defaulter.is_active).toEqual(true)

    it 'changes the activate method when a delay is set', ->
      expect(@delayer.activate).toEqual(@delayer.activateWithDelay)


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

    it 'changes the deactivate method when a delay is set', ->
      expect(@delayer.deactivate).toEqual(@delayer.deactivateWithDelay)


  describe '#dispose', ->
    it 'cleans up its own mess', ->
      spyEvent = spyOn(@defaulter, 'toggle')
      @defaulter.dispose()
      @one.click()
      expect(spyEvent).not.toHaveBeenCalled()

    it 'removes any timeouts for delay togglables', ->
      @delayer.dispose()
      expect(@delayer.timeout).toBeNull()


  describe '#addListeners', ->
    it 'adds a listener when the event type is click', ->
      tester = new utensil.Togglable(@empty, trigger:'click')
      expect(tester.is_listening).toEqual(true)

    it 'adds a listener when the event type is hover', ->
      tester = new utensil.Togglable(@empty, trigger:'hover')
      expect(tester.is_listening).toEqual(true)

    it 'adds a listener when the event type is focus', ->
      tester = new utensil.Togglable(@empty, trigger:'focus')
      expect(tester.is_listening).toEqual(true)

    it 'does not add a listener when the event type is manual', ->
      tester = new utensil.Togglable(@empty, trigger:'manual')
      expect(tester.is_listening).toEqual(false)


  describe '#removeListeners', ->
    it 'removes a listener when the event type is click', ->
      spyme = new utensil.Togglable(@empty, trigger:'click')
      spyEvent = spyOn(spyme, 'removeListeners')
      spyme.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'removes a listener when the event type is hover', ->
      spyme = new utensil.Togglable(@empty, trigger:'hover')
      spyEvent = spyOn(spyme, 'removeListeners')
      spyme.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'removes a listener when the event type is focus', ->
      spyme = new utensil.Togglable(@empty, trigger:'focus')
      spyEvent = spyOn(spyme, 'removeListeners')
      spyme.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'does not call removeListeners when event type is manual since no listeners are added', ->
      spyme = new utensil.Togglable(@empty, trigger:'manual')
      spyEvent = spyOn(spyme, 'removeListeners')
      spyme.dispose()
      expect(spyEvent).not.toHaveBeenCalled()


  describe '#setTriggerEventTypes', ->
    it 'sets different event types for on and off from hover', ->
      type = @defaulter.setTriggerEventTypes('hover')
      expect(type).toEqual(on:'mouseenter', off:'mouseleave')

    it 'sets different event types for on and off from focus', ->
      type = @defaulter.setTriggerEventTypes('focus')
      expect(type).toEqual(on:'focus', off:'blur')

    it 'sets the same event types for on and off from click', ->
      type = @defaulter.setTriggerEventTypes('click')
      expect(type).toEqual(on:'click', off:'click')

    it 'sets the same event types for on and off from manual', ->
      type = @defaulter.setTriggerEventTypes('manual')
      expect(type).toEqual(on:'manual', off:'manual')


  describe '#setActivate', ->
    it 'dispatches a togglable:activate event', ->
      tmp = 0
      @defaulter.dispatcher.on('togglable:activate', => tmp += 1)
      @defaulter.setActivate()
      expect(tmp).not.toEqual(0)


  describe '#setDeactivate', ->
    it 'dispatches a togglable:activate event', ->
      tmp = 0
      @defaulter.dispatcher.on('togglable:deactivate', => tmp -= 1)
      @defaulter.setDeactivate()
      expect(tmp).not.toEqual(0)


  describe '#setDelay', ->
    it 'reports a togglable element has delays', ->
      expect(@delayer.delay).toBeDefined()
      expect(@defaulter.delay).not.toBeDefined()


  describe '#activateWithDelay', ->
    it 'activates a togglable element after a delay', ->
      # override the delay to speed up the tests.
      @delayer.delay.activate = 50
      @delayer.delay.deactivate = 50

      runs ->
        @eight.trigger('click')
      waits 100
      runs ->
        expect(@eight).toHaveClass('active')
        expect(@delayer.timeout).toBeNull()


  describe '#deactivateWithDelay', ->
    it 'deactivates a togglable element after a delay', ->
      # override the delay to speed up the tests.
      @delayer.delay.activate = 50
      @delayer.delay.deactivate = 50

      @delayer.setActivate()
      expect(@eight).toHaveClass('active')
      runs ->
        @eight.trigger('click')
      waits 100
      runs ->
        expect(@eight).not.toHaveClass('active')
        expect(@delayer.timeout).toBeNull()


  describe '#findTarget', ->
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


