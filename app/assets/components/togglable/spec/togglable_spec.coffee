
#= require togglable

describe 'Togglable', ->

  beforeEach ->
    extra = """
            <a id="stnd_link" href="/some-url">More</a>
            <div id="empty"></div>
            <a id="by_target" data-target="#togglable_heading" data-lookup="siblings">By Target</a>
            <a id="by_href" href="#togglable_heading" data-lookup="siblings">By href</a>
            <a id="related" href="#" data-related="body" data-related-context="#jasmine-fixtures" data-related-lookup="parent">Related</a>
            """

    loadFixtures('togglable')
    @dom = $('#jasmine-fixtures')
    @dom.append(extra)

    @nav = @dom.find('.nav')
    @one = @dom.find('#one > a')
    @two = @dom.find('#two > a')
    @three = @dom.find('#three > a')
    @four = @dom.find('#four > a')
    @five = @dom.find('#five > a')
    @six = @dom.find('#six > a')
    @seven = @dom.find('#seven > a')
    @eight = @dom.find('#eight > a')
    @link = @dom.find('#stnd_link')
    @empty = @dom.find('#empty')
    @context_el = @dom.find('#context')
    @by_target_el = @dom.find('#by_target')
    @by_href_el = @dom.find('#by_href')
    @related_el = @dom.find('#related')

    @defaulter = new utensil.Togglable(@one)
    @overrider = new utensil.Togglable(@two)
    @spanner = new utensil.Togglable(@three)
    @closest = new utensil.Togglable(@four)
    @bubbler = new utensil.Togglable(@five)
    @active = new utensil.Togglable(@six)
    @contexter = new utensil.Togglable(@seven)
    @delayer = new utensil.Togglable(@eight)
    @stnd_link = new utensil.Togglable(@link)
    @by_target = new utensil.Togglable(@by_target_el)
    @by_href = new utensil.Togglable(@by_href_el)
    @related = new utensil.Togglable(@related_el)


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
      expect(@defaulter.trigger).toEqual(on:'click.togglable', off:'click.togglable')
      expect(@defaulter.lookup).toEqual('find')

    it 'overrides default options', ->
      expect(@overrider.toggle_classes).toEqual('fade')
      expect(@overrider.trigger).toEqual(on:'mouseenter.togglable', off:'mouseleave.togglable')
      expect(@closest.lookup).toEqual('closest')

    it 'sets the ability for dual toggles when there is related content', ->
      expect(@spanner.related).not.toBeNull()

    it 'sets "related" to null when not found', ->
      expect(@defaulter.related).toBeNull()

    it 'sets default values from a javascript class', ->
      togglable = new utensil.Togglable(@empty, {toggle: 'show', trigger: 'hover', lookup: 'closest'})
      expect(togglable.toggle_classes).toEqual('show')
      expect(togglable.trigger).toEqual(on:'mouseenter.togglable', off:'mouseleave.togglable')
      expect(togglable.lookup).toEqual('closest')
      expect(togglable.target).toEqual(@empty)

    it 'sets the correct context for lookups', ->
      expect(@contexter.context).toEqual($('body'))
      expect(@defaulter.context).toEqual(@one)


  describe '#relatedOptions', ->
    it 'sets the related classes the same as toggle classes', ->
      expect(@related.related_classes).toEqual(@related.toggle_classes)

    it 'sets the related context to the fixtures container', ->
      expect(@related.related_context).toEqual($('#jasmine-fixtures'))

    it 'sets the related lookup fn to siblings', ->
      expect(@related.related_lookup).toEqual('parent')

    it 'sets the related element to the togglable heading', ->
      expect(@related.related).toBe($('body'))


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

    it 'toggles the custom classes from a call on only the target and not the @el', ->
      expect(@four).not.toHaveClass('inline')
      expect(@nav).toHaveClass('inline')
      expect(@closest.is_active).toEqual(true)

      @closest.toggle()
      expect(@four).not.toHaveClass('active')
      expect(@nav).not.toHaveClass('inline')
      expect(@closest.is_active).toEqual(false)

      @closest.toggle()
      expect(@four).not.toHaveClass('inline')
      expect(@nav).toHaveClass('inline')
      expect(@closest.is_active).toEqual(true)

    it 'toggles the target with a normal "active" state and a related element with "in"', ->
      expect(@three.find('span')).toHaveClass('in')
      expect(@three).not.toHaveClass('active')

      @spanner.toggle()
      expect(@three.find('span')).not.toHaveClass('in')
      expect(@three).not.toHaveClass('in')
      expect(@three).toHaveClass('active')

      @spanner.toggle()
      expect(@three.find('span')).toHaveClass('in')
      expect(@three).not.toHaveClass('active')

    it 'toggles a context object searching from the body', ->
      heading = $('#togglable_heading')
      expect(heading).toHaveClass('in')

      @contexter.toggle()
      expect(heading).not.toHaveClass('in')

      @contexter.toggle()
      expect(heading).toHaveClass('in')


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
      expect(type).toEqual(on:'mouseenter.togglable', off:'mouseleave.togglable')

    it 'sets different event types for on and off from focus', ->
      type = @defaulter.setTriggerEventTypes('focus')
      expect(type).toEqual(on:'focus.togglable', off:'blur.togglable')

    it 'sets the same event types for on and off from click', ->
      type = @defaulter.setTriggerEventTypes('click')
      expect(type).toEqual(on:'click.togglable', off:'click.togglable')

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


  describe '#setDelay', ->
    it 'reports a togglable element has delays', ->
      expect(@delayer.delay).toBeDefined()
      expect(@defaulter.delay).not.toBeDefined()


  describe '#findTarget', ->
    it 'finds itself as an element when there is no href or data-target present', ->
      expect(@defaulter.target).toBe(@one)

    it 'returns itself when there is "this" target attached to the "data-target" attribute', ->
      expect(@overrider.target).toBe(@two)

    it 'returns itself when there is a "#" target attached to the href', ->
      expect(@active.target).toBe(@six)

    it 'finds the target when the href is a selector', ->
      expect(@by_href.target).toBe(@dom.find('#togglable_heading'))

    it 'returns itself when there is a "normal link" target attached to the href', ->
      expect(@stnd_link.target).toBe(@link)

    it 'finds the parent element from a selector within the href attribute', ->
      expect(@closest.target).toBe(@nav)

    it 'finds the parent element from a "data-target" attribute', ->
      expect(@by_target.target).toBe(@dom.find('#togglable_heading'))

    it 'uses $.find by default to search', ->
      expect(@bubbler.lookup).toEqual('find')
      expect(@bubbler.target).toBe(@five.find('#find_bang'))

    it 'uses $.closest when provided as a lookup fn', ->
      expect(@closest.lookup).toEqual('closest')
      expect(@closest.target).toBe(@nav)

