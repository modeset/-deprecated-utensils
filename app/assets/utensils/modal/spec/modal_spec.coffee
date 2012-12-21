#= require utensils/modal
#= require utensils/detect

describe 'Modal', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)
    @nooper = ->

    extra = """
            <button id="auto_activate" data-target="#modal_href" data-activate="true">Auto Activator</button>
            """

    loadFixtures('modal/markup/modal')
    @dom = $('#teabag-fixtures')
    @dom.append(extra)
    @body = $('body')

    @tranny_state = utensils.Detect.hasTransition

    @modal_link = @dom.find('[href="#modal_href"]')
    @modal_el = @dom.find('#modal_href')

    @modal = new utensils.Modal(@modal_link)


  afterEach ->
    utensils.Detect.hasTransition = @tranny_state
    @body.find('.modal-backdrop').remove()


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('modal')).toEqual(utensils.Modal)


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@modal.data).toBeDefined()

    it 'auto activates a modal', ->
      utensils.Detect.hasTransition = false
      auto_link = @dom.find('#auto_activate')
      auto = new utensils.Modal(auto_link)
      expect(@body).toContain(@body.find('.modal-backdrop'))
      expect(@modal_el).toHaveClass('in')
      expect(auto.is_active).toEqual(true)


  describe '#options', ->
    it 'sets default data.namespace', ->
      expect(@modal.data.namespace).toEqual('modal')

    it 'sets default data.keyboard', ->
      expect(@modal.data.keyboard).toEqual(true)


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@modal.namespace).toEqual('modal')

    it 'sets default keyboard', ->
      expect(@modal.keyboard).toEqual(true)

    it 'lazy loads the lookups', ->
      expect(@modal.markup).toBeNull()
      expect(@modal.dismissers).toBeNull()

    it 'initializes with a state variable', ->
      expect(@modal.is_active).toEqual(false)

    it 'creates an instance of "Triggerable"', ->
      expect(@modal.triggerable instanceof utensils.Triggerable).toEqual(true)


  describe '#activate', ->
    it 'activates a default modal', ->
      utensils.Detect.hasTransition = false
      @modal.activate()
      expect(@body).toContain(@body.find('.modal-backdrop'))
      expect(@modal_el).toHaveClass('in')
      expect(@modal.is_active).toEqual(true)
      @modal.deactivate()


  describe '#deactivate', ->
    it 'deactivates a default modal', ->
      utensils.Detect.hasTransition = false
      @modal.activate()
      expect(@body).toContain(@body.find('.modal-backdrop'))
      expect(@modal_el).toHaveClass('in')
      expect(@modal.is_active).toEqual(true)
      @modal.deactivate()
      expect(@modal_el).not.toHaveClass('in')
      expect(@body.find('.modal-backdrop').length).toBe(0)
      expect(@modal.is_active).toEqual(false)


  describe '#dispose', ->
    it 'removes listeners when disposed', ->
      spyEvent = spyOn(@modal, 'removeListeners')
      @modal.dispose()
      expect(spyEvent).toHaveBeenCalled()

    it 'gets rid of triggerable', ->
      @modal.dispose()
      expect(@modal.triggerable).toBeNull()

    it 'does not respond to any further events', ->
      spyEvent = spyOn(@modal, 'activate')
      @modal.dispose()
      @modal_link.click()
      expect(spyEvent).not.toHaveBeenCalled()

    it 'does not freak out if disposing multiple times', ->
      @modal.dispose()
      @modal.dispose()
      expect(@modal.dispose).not.toThrow()


  describe '#addListeners', ->
    it 'adds a listener for "click" event for an modal', ->
      spyEvent = spyOn(@modal, 'activated')
      @modal_link.click()
      expect(spyEvent).toHaveBeenCalled()


  describe '#removeListeners', ->
    it 'removes a listener for "click" event for an modal', ->
      spyEvent = spyOn(@modal, 'activate')
      @modal.removeListeners()
      @modal_link.click()
      expect(spyEvent).not.toHaveBeenCalled()


  describe '#addDocumentListeners, #keyed', ->
    it 'listens to the keydown event', ->
      utensils.Detect.hasTransition = false
      spyEvent = spyOn(@modal, 'deactivate')
      @modal_link.click()
      @modal.keyed(keyCode:27, preventDefault:@nooper, stopPropagation:@nooper)
      expect(spyEvent).toHaveBeenCalled()

    it 'listens to the "click" event on the backdrop', ->
      utensils.Detect.hasTransition = false
      spyEvent = spyOn(@modal, 'deactivate')
      @modal.activate()
      @body.find('.modal-backdrop').click()
      expect(spyEvent).toHaveBeenCalled()


  describe '#removeDocumentListeners', ->
    it 'stops listening to the "click" event on the backdrop', ->
      utensils.Detect.hasTransition = false
      spyEvent = spyOn(@modal, 'deactivate')
      @modal.activate()
      @modal.removeDocumentListeners()
      @body.find('.modal-backdrop').click()
      expect(spyEvent).not.toHaveBeenCalled()


  describe '#addDismissListeners', ->
    it 'listens for dismiss event from a button inside of the modal', ->
      utensils.Detect.hasTransition = false
      spyEvent = spyOn(@modal, 'deactivate')
      @modal.activate()
      dismisser = @modal_el.find('[data-dismiss]').first()
      dismisser.click()
      expect(spyEvent).toHaveBeenCalled()

    it 'finds multiple dismiss elements', ->
      utensils.Detect.hasTransition = false
      @modal.activate()
      expect(@modal.dismissers.length).toBeGreaterThan(1)


  describe '#removeDismissListeners', ->
    it 'stop listening for dismiss event from a button inside of the modal', ->
      utensils.Detect.hasTransition = false
      spyEvent = spyOn(@modal, 'deactivate')
      @modal.activate()
      dismisser = @modal_el.find('[data-dismiss]').first()
      @modal.removeDismissListeners()
      dismisser.click()
      expect(spyEvent).not.toHaveBeenCalled()


  describe '#transition', ->
    it 'utilizes the transition wrapper method', ->
      utensils.Detect.hasTransition = false
      spyEvent = spyOn(@modal, 'setTransitions')
      @modal_link.click()
      expect(spyEvent).toHaveBeenCalled()


  describe '#addBackdrop', ->
    it 'adds the backdrop for the modal', ->
      utensils.Detect.hasTransition = false
      @modal_link.click()
      expect(@body).toContain(@body.find('.modal-backdrop'))


  describe '#addModal', ->
    it 'adds the modal', ->
      utensils.Detect.hasTransition = false
      @modal_link.click()
      expect(@modal_el).toHaveClass('in')


  describe '#removeModal', ->
    it 'removes the modal', ->
      utensils.Detect.hasTransition = false
      @modal.activate()
      expect(@modal_el).toHaveClass('in')
      @modal.deactivate()
      expect(@modal_el).not.toHaveClass('in')


  describe '#removeBackdrop, #cleanupBackdrop', ->
    it 'removes the backdrop for the modal', ->
      utensils.Detect.hasTransition = false
      @modal.activate()
      expect(@body).toContain(@body.find('.modal-backdrop'))
      @modal.deactivate()
      expect(@body.find('.modal-backdrop').length).toBe(0)


  describe '#findMarkup', ->
    it 'finds the markup from an href attribute', ->
      expect(@modal.findMarkup()).toBe(@modal_el)

    it 'finds the markup from a data attribute', ->
      auto_link = @dom.find('#auto_activate')
      auto = new utensils.Modal(auto_link)
      expect(auto.findMarkup()).toBe(@modal_el)


