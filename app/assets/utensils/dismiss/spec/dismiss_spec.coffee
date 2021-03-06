#= require utensils/dismiss
fixture.preload 'dismiss/markup/dismiss'

describe 'Dismiss', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    extra = """
            <div id="dismiss_auto" class="notification fade in">
              <p>This is a dismissed notification</p>
              <a class="close" data-auto-dismiss="5000" href="#">&times;</a>
            </div>
            """

    fixture.load 'dismiss/markup/dismiss'
    @dom = $(fixture.el)
    @dom.append(extra)

    @alert_el = @dom.find('.notification:first-child')
    @alert_link = @alert_el.find('> .close')
    @alert = new utensils.Dismiss(@alert_link)

    @href_el = @dom.find('#dismiss_href')
    @href_link = @href_el.find('> .close')
    @href = new utensils.Dismiss(@href_link)

    @target_el = @dom.find('#dismiss_target')
    @target_link = @target_el.find('> .close')
    @target = new utensils.Dismiss(@target_link)

    @nested_el = @dom.find('#dismiss_nested')
    @nested_link = @nested_el.find('.close')
    @nested = new utensils.Dismiss(@nested_link)

    @alone_el = @dom.find('#dismiss_alone')
    @alone = new utensils.Dismiss(@alone_el)

    @custom_el = @dom.find('#dismiss_cya')
    @custom_link = @custom_el.find('a')
    @custom = new utensils.Dismiss(@custom_link)

    @auto_el = @dom.find('#dismiss_auto')
    @auto_link = @auto_el.find('a')
    @auto = new utensils.Dismiss(@auto_link)


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('dismiss')).to.be utensils.Dismiss


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@alert.data).not.to.be undefined

    it 'auto dismisses a dismissable object when it has the auto-dismiss attribute', ->
      expect(@auto.data.autoDismiss).to.be 5000


  describe '#options', ->
    it 'sets default data.namespace', ->
      expect(@alert.data.namespace).to.be 'dismiss'

    it 'sets default data.parents', ->
      expect(@alert.data.parents).to.be '.notification, .dismiss'

    it 'overrides data.parents', ->
      expect(@custom.data.parents).to.be '#dismiss_cya'


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@alert.namespace).to.be 'dismiss'

    it 'sets default parent_classes', ->
      expect(@alert.parent_classes).to.be '.notification, .dismiss'

    it 'overrides parent_classes', ->
      expect(@custom.parent_classes).to.be '#dismiss_cya'

    it 'creates an instance of "Triggerable"', ->
      expect(@alert.triggerable).to.be.a utensils.Triggerable


  describe '#remove', ->
    it 'triggers a "dismiss" event', ->
      @alert_el.on('dismiss:dismiss', => @noop arguments...)
      spy = sinon.spy @, 'noop'
      @alert_link.click()
      expect(spy.called).to.be.ok()

    it 'removes the alert from the dom', ->
      @alert_link.click()
      expect(@alert_el.hasClass('in')).to.be false


  describe '#removeTarget', ->
    it 'removes the alert from the dom', ->
      @alert.removeTarget()
      expect(@dom).not.to.contain @alert_el

    it 'triggers a "dismissed" event', ->
      @alert_el.on('dismiss:dismissed', => @noop arguments...)
      spy = sinon.spy @, 'noop'
      @alert.removeTarget()
      expect(spy.called).to.be.ok()


  describe '#dispose', ->
    it 'removes listeners when disposed', ->
      spy = sinon.spy @alert, 'removeListeners'
      @alert.dispose()
      expect(spy.called).to.be.ok()

    it 'gets rid of triggerable', ->
      @alert.dispose()
      expect(@alert.triggerable).to.be null

    it 'does not respond to any further events', ->
      spy = sinon.spy @alert, 'deactivated'
      @alert.dispose()
      @alert_link.click()
      expect(spy.called).not.to.be.ok()

    it 'does not freak out if disposing multiple times', ->
      @alert.dispose()
      @alert.dispose()
      expect(@alert.dispose).not.to.throwException()


  describe '#addListeners', ->
    it 'adds a listener for "click" event for an alert', ->
      spy = sinon.spy @alert, 'deactivated'
      @alert_link.click()
      expect(spy.called).to.be.ok()


  describe '#removeListeners', ->
    it 'removes a listener for "click" event for an alert', ->
      spy = sinon.spy @alert, 'deactivated'
      @alert.removeListeners()
      @alert_link.click()
      expect(spy.called).not.to.be.ok()


  describe '#deactivated', ->
    it 'removes the alert element from the dom from the parent', ->
      @alert_link.click()
      expect(@alert_el.hasClass('in')).to.be false

    it 'removes the alert element from the dom from the href', ->
      @href_link.click()
      expect(@href_el.hasClass('in')).to.be false


  describe '#setTarget', ->
    it 'sets the target against the parent', ->
      @alert.setTarget()
      expect(@alert.target.html()).to.be @alert_el.html()

    it 'sets the target against the href', ->
      @href.setTarget()
      expect(@href.target.html()).to.be @href_el.html()

    it 'sets the target against the data-target', ->
      @target.setTarget()
      expect(@target.target.html()).to.be @target_el.html()

    it 'sets the target when nested', ->
      @nested.setTarget()
      expect(@nested.target.html()).to.be @nested_el.html()

    it 'defaults the target against the el', ->
      @alone.setTarget()
      expect(@alone.target.html()).to.be @alone_el.html()

    it 'sets the target against custom classes', ->
      @custom.setTarget()
      expect(@custom.target.html()).to.be @custom_el.html()

