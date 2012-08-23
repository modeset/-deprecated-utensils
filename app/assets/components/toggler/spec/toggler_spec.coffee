
#= require toggler
describe 'Toggler', ->

  beforeEach ->
    html = """
          <section class="shell">
             <div id="parent" data-target="#defaulter" data-solo="true">
               <a id="defaulter">More</a>
               <a id="overrider" href="#parent" data-toggle="in bordered" data-lookup="closest" data-event="hover">More</a>
               <a id="this_hash" href="#this">More</a>
               <a id="just_hash" href="#">More</a>
               <a id="stnd_link" href="/some-url">More</a>
               <a id="by_target" href="#" data-target="#parent" data-lookup="closest">More</a>
             </div>
           </section>
           """
    @html = $(html)
    setFixtures(@html)
    @parent = new roos.Toggler(@html.find('#parent'))
    @defaulter = new roos.Toggler(@html.find('#defaulter'))
    @overrider = new roos.Toggler(@html.find('#overrider'))
    @this_hash = new roos.Toggler(@html.find('#this_hash'))
    @just_hash = new roos.Toggler(@html.find('#just_hash'))
    @stnd_link = new roos.Toggler(@html.find('#stnd_link'))
    @by_target = new roos.Toggler(@html.find('#by_target'))

    @$defaults = @html.find('#defaulter')
    @$override = @html.find('#overrider')
    @$parent = @html.find('#parent')

  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(Bindable.getClass('toggler')).toEqual(roos.Toggler)

  describe '#constructor', ->
    it 'defaults to inactive', ->
      expect(@defaulter.is_active).toEqual(false)
    it 'sets up a data object', ->
      expect(@defaulter.data).toBeDefined()

  describe '#options', ->
    it 'sets default options', ->
      expect(@defaulter.toggle_classes).toEqual('active')
      expect(@defaulter.event_type).toEqual('click')
      expect(@defaulter.lookup).toEqual('find')

    it 'overrides default options', ->
      expect(@overrider.toggle_classes).toEqual('in bordered')
      expect(@overrider.event_type).toEqual('hover')
      expect(@overrider.lookup).toEqual('closest')

    it 'sets the ability for dual toggles by default', ->
      expect(@overrider.dual_toggle).toEqual(true)

    it 'sets the ability for dual toggles by default', ->
      expect(@overrider.dual_toggle).toEqual(true)

    it 'does not set dual toggle when passed as an attribute', ->
      expect(@parent.dual_toggle).toEqual(false)


  describe '#getTarget', ->
    it 'finds itself as an element when there is no href or data-target present', ->
      expect(@defaulter.target).toEqual(@$defaults)

    it 'returns itself when there is an "#this" target attached to the href', ->
      expect(@this_hash.target).toEqual(@html.find('#this_hash'))

    it 'returns itself when there is a "#" target attached to the href', ->
      expect(@just_hash.target).toEqual(@html.find('#just_hash'))

    it 'returns itself when there is a "#" target attached to the href', ->
      expect(@just_hash.target).toEqual(@html.find('#just_hash'))

    it 'returns itself when there is a "normal link" target attached to the href', ->
      expect(@stnd_link.target).toEqual(@html.find('#stnd_link'))

    it 'finds the parent element from a selector within the href attribute', ->
      expect(@overrider.target.html()).toEqual(@$parent.html())

    it 'finds the parent element from a "data-target" attribute', ->
      expect(@by_target.target.html()).toEqual(@$parent.html())

    it 'uses $.find by default', ->
      expect(@parent.lookup).toEqual('find')
      expect(@parent.target.html()).toEqual(@$defaults.html())

    it 'uses $.closest when provided as a lookup fn', ->
      expect(@overrider.lookup).toEqual('closest')
      expect(@overrider.target.html()).toEqual(@$parent.html())

  describe '#toggle', ->
    # TODO: Not sure why this isn't working
    xit 'toggles the correct classes from a trigger', ->
      spyEvent = spyOn(@defaulter, 'toggle').andCallThrough()
      # spyEvent = spyOn(roos.Toggler.prototype, 'toggle').andCallThrough()
      @$defaults.click()
      expect(spyEvent).toHaveBeenCalled()


    it 'toggles the default classes from a call', ->
      expect(@$defaults).not.toHaveClass('active')
      expect(@defaulter.is_active).toEqual(false)

      @defaulter.toggle()
      expect(@$defaults).toHaveClass('active')
      expect(@defaulter.is_active).toEqual(true)

      @defaulter.toggle()
      expect(@$defaults).not.toHaveClass('active')
      expect(@defaulter.is_active).toEqual(false)

    it 'toggles the custom classes from a call on both the element and target', ->
      expect(@$override).not.toHaveClass('in bordered')
      expect(@$parent).not.toHaveClass('in bordered')
      expect(@overrider.is_active).toEqual(false)

      @overrider.toggle()
      expect(@$override).toHaveClass('in bordered')
      expect(@$parent).toHaveClass('in bordered')
      expect(@overrider.is_active).toEqual(true)

      @overrider.toggle()
      expect(@$override).not.toHaveClass('in bordered')
      expect(@$parent).not.toHaveClass('in bordered')
      expect(@overrider.is_active).toEqual(false)

    it 'toggles only the target and not the element when specified', ->
      expect(@$defaults).not.toHaveClass('active')
      expect(@$parent).not.toHaveClass('active')

      @parent.toggle()
      expect(@$defaults).toHaveClass('active')
      expect(@$parent).not.toHaveClass('active')

      @parent.toggle()
      expect(@$defaults).not.toHaveClass('active')
      expect(@$parent).not.toHaveClass('active')

  describe '#activate', ->
    it 'adds classes to the element', ->
      expect(@$defaults).not.toHaveClass('active')
      expect(@defaulter.is_active).toEqual(false)

      @defaulter.activate()
      expect(@$defaults).toHaveClass('active')
      expect(@defaulter.is_active).toEqual(true)

  describe '#deactivate', ->
    it 'removes classes from the element', ->
      expect(@$defaults).not.toHaveClass('active')
      expect(@defaulter.is_active).toEqual(false)

      @defaulter.activate()
      expect(@$defaults).toHaveClass('active')
      expect(@defaulter.is_active).toEqual(true)

      @defaulter.deactivate()
      expect(@$defaults).not.toHaveClass('active')
      expect(@defaulter.is_active).toEqual(false)

  describe '#dispose', ->
    # TODO: Not sure why this isn't working
    xit 'cleans up its own mess', ->
      spyEvent = spyOn(@defaulter, 'toggle')
      @$defaults.click()
      expect(spyEvent).toHaveBeenCalled()

      spyEvent.reset()
      @defaulter.dispose()
      @$defaults.click()
      expect(spyEvent).not.toHaveBeenCalled()

