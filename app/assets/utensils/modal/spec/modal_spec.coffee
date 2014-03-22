#= require utensils/modal
#= require utensils/detect
fixture.preload 'modal/markup/modal'

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

    fixture.load 'modal/markup/modal'
    @dom = $(fixture.el)
    @dom.append(extra)
    @body = $('body')

    @transition_state = utensils.Detect.hasTransition

    @modal_link = @dom.find('[href="#modal_href"]')
    @modal_el = @dom.find('#modal_href')

    @modal = new utensils.Modal(@modal_link)


  afterEach ->
    utensils.Detect.hasTransition = @transition_state
    @body.find('.modal-backdrop').remove()


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('modal')).to.be utensils.Modal


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@modal.data).not.to.be undefined

    it 'auto activates a modal', ->
      utensils.Detect.hasTransition = false
      auto_link = @dom.find('#auto_activate')
      auto = new utensils.Modal(auto_link)
      expect(@body.html()).to.contain(@body.find('.modal-backdrop').html())
      expect(@modal_el.hasClass('in')).to.be true
      expect(auto.is_active).to.be true


  describe '#options', ->
    it 'sets default data.namespace', ->
      expect(@modal.data.namespace).to.be 'modal'

    it 'sets default data.keyboard', ->
      expect(@modal.data.keyboard).to.be true


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@modal.namespace).to.be 'modal'

    it 'sets default keyboard', ->
      expect(@modal.keyboard).to.be true

    it 'lazy loads the lookups', ->
      expect(@modal.markup).to.be null
      expect(@modal.dismissers).to.be null

    it 'initializes with a state variable', ->
      expect(@modal.is_active).to.be false

    it 'creates an instance of "Triggerable"', ->
      expect(@modal.triggerable).to.be.a utensils.Triggerable


  describe '#activate', ->
    it 'activates a default modal', ->
      utensils.Detect.hasTransition = false
      @modal.activate()
      expect(@body.html()).to.contain(@body.find('.modal-backdrop').html())
      expect(@modal_el.hasClass('in')).to.be true
      expect(@modal.is_active).to.be true
      @modal.deactivate()


  describe '#deactivate', ->
    it 'deactivates a default modal', ->
      utensils.Detect.hasTransition = false
      @modal.activate()
      expect(@body.html()).to.contain(@body.find('.modal-backdrop').html())
      expect(@modal_el.hasClass('in')).to.be true
      expect(@modal.is_active).to.be true
      @modal.deactivate()
      expect(@modal_el.hasClass('in')).to.be false
      expect(@body.find('.modal-backdrop').length).to.be 0
      expect(@modal.is_active).to.be false


  describe '#dispose', ->
    it 'removes listeners when disposed', ->
      spy = sinon.spy @modal, 'removeListeners'
      @modal.dispose()
      expect(spy.called).to.be.ok()

    it 'gets rid of triggerable', ->
      @modal.dispose()
      expect(@modal.triggerable).to.be null

    it 'does not respond to any further events', ->
      spy = sinon.spy @modal, 'activate'
      @modal.dispose()
      @modal_link.click()
      expect(spy.called).not.to.be.ok()

    it 'does not freak out if disposing multiple times', ->
      @modal.dispose()
      @modal.dispose()
      expect(@modal.dispose).not.to.throwException()


  describe '#addListeners', ->
    it 'adds a listener for "click" event for an modal', ->
      spy = sinon.spy @modal, 'activated'
      @modal_link.click()
      expect(spy.called).to.be.ok()


  describe '#removeListeners', ->
    it 'removes a listener for "click" event for an modal', ->
      spy = sinon.spy @modal, 'activate'
      @modal.removeListeners()
      @modal_link.click()
      expect(spy.called).not.to.be.ok()


  describe '#addDocumentListeners, #keyed', ->
    it 'listens to the keydown event', ->
      utensils.Detect.hasTransition = false
      spy = sinon.spy @modal, 'deactivate'
      @modal_link.click()
      @modal.keyed(keyCode:27, preventDefault:@nooper, stopPropagation:@nooper)
      expect(spy.called).to.be.ok()

    it 'listens to the "click" event on the backdrop', ->
      utensils.Detect.hasTransition = false
      spy = sinon.spy @modal, 'deactivate'
      @modal.activate()
      @body.find('.modal-backdrop').click()
      expect(spy.called).to.be.ok()


  describe '#removeDocumentListeners', ->
    it 'stops listening to the "click" event on the backdrop', ->
      utensils.Detect.hasTransition = false
      spy = sinon.spy @modal, 'deactivate'
      @modal.activate()
      @modal.removeDocumentListeners()
      @body.find('.modal-backdrop').click()
      expect(spy.called).not.to.be.ok()


  describe '#addDismissListeners', ->
    it 'listens for dismiss event from a button inside of the modal', ->
      utensils.Detect.hasTransition = false
      spy = sinon.spy @modal, 'deactivate'
      @modal.activate()
      dismisser = @modal_el.find('[data-dismiss]').first()
      dismisser.click()
      expect(spy.called).to.be.ok()

    it 'finds multiple dismiss elements', ->
      utensils.Detect.hasTransition = false
      @modal.activate()
      expect(@modal.dismissers.length).to.be.above 1


  describe '#removeDismissListeners', ->
    it 'stop listening for dismiss event from a button inside of the modal', ->
      utensils.Detect.hasTransition = false
      spy = sinon.spy @modal, 'deactivate'
      @modal.activate()
      dismisser = @modal_el.find('[data-dismiss]').first()
      @modal.removeDismissListeners()
      dismisser.click()
      expect(spy.called).not.to.be.ok()


  describe '#transition', ->
    it 'utilizes the transition wrapper method', ->
      utensils.Detect.hasTransition = false
      spy = sinon.spy @modal, 'setTransitions'
      @modal_link.click()
      expect(spy.called).to.be.ok()


  describe '#addBackdrop', ->
    it 'adds the backdrop for the modal', ->
      utensils.Detect.hasTransition = false
      @modal_link.click()
      expect(@body.html()).to.contain(@body.find('.modal-backdrop').html())


  describe '#addModal', ->
    it 'adds the modal', ->
      utensils.Detect.hasTransition = false
      @modal_link.click()
      expect(@modal_el.hasClass('in')).to.be true


  describe '#removeModal', ->
    it 'removes the modal', ->
      utensils.Detect.hasTransition = false
      @modal.activate()
      expect(@modal_el.hasClass('in')).to.be true
      @modal.deactivate()
      expect(@modal_el.hasClass('in')).to.be false


  describe '#removeBackdrop, #cleanupBackdrop', ->
    it 'removes the backdrop for the modal', ->
      utensils.Detect.hasTransition = false
      @modal.activate()
      expect(@body.html()).to.contain(@body.find('.modal-backdrop').html())
      @modal.deactivate()
      expect(@body.find('.modal-backdrop').length).to.be 0


  describe '#findMarkup', ->
    it 'finds the markup from an href attribute', ->
      expect(@modal.findMarkup().html()).to.be @modal_el.html()

    it 'finds the markup from a data attribute', ->
      auto_link = @dom.find('#auto_activate')
      auto = new utensils.Modal(auto_link)
      expect(auto.findMarkup().html()).to.be @modal_el.html()


