#= require utensils/detect
#= require utensils/collapse
fixture.preload 'collapse/markup/collapse'

describe 'Collapse', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    fixture.load 'collapse/markup/collapse'
    @dom = $(fixture.el)

    @collapse_el = @dom.find('[href=#collapse_height]')
    @auto_el = @dom.find('[href=#collapse_auto]')
    @collapse_panel = @dom.find('#collapse_height')
    @auto_panel = @dom.find('#collapse_auto')

    @radio_el = @dom.find('#collapse_radio')
    @check_el = @dom.find('#collapse_checkbox')
    @external_el = @dom.find('#collapse_external')

    @collapse = new utensils.Collapse(@collapse_el.parent())
    @auto = new utensils.Collapse(@auto_el.parent())
    @radio = new utensils.Collapse(@radio_el)
    @check = new utensils.Collapse(@check_el)
    @external = new utensils.Collapse(@external_el)


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('collapse')).to.be utensils.Collapse


  describe '#constructor', ->
    it 'sets up a data object', ->
      expect(@collapse.data).not.to.be undefined

    it 'auto activates an element from a data attribute for a single collapse', ->
      expect(@auto_el.parent().hasClass('active')).to.be true
      expect(@auto_panel.hasClass('in')).to.be true

    it 'auto activates an element from a data attribute for a group collapse', ->
      expect(@radio_el.find('li:first-child').hasClass('active')).to.be true
      expect(@radio_el.find('#collapse_radio_1').hasClass('in')).to.be true


  describe '#options', ->
    it 'sets default data.namespace', ->
      expect(@collapse.data.namespace).to.be 'collapse'

    it 'sets the default data.dimension', ->
      expect(@collapse.data.dimension).to.be 'height'

    it 'sets the default data.behavior', ->
      expect(@radio.data.behavior).to.be 'radio'

    it 'sets the overrides data.behavior', ->
      expect(@check.data.behavior).to.be 'checkbox'

    it 'sets up a default selector list', ->
      expect(@check.data.selector).to.contain '.collapse-toggle'


  describe '#initialize', ->
    it 'sets default namespace', ->
      expect(@collapse.namespace).to.be 'collapse'

    it 'sets default dimension', ->
      expect(@collapse.dimension).to.be 'height'

    it 'sets the default behavior', ->
      expect(@radio.behavior).to.be 'radio'

    it 'sets the overrides behavior', ->
      expect(@check.behavior).to.be 'checkbox'

    it 'sets up a default selector list', ->
      expect(@check.selector).to.contain '.collapse-toggle'

    it 'finds a toggler element based on a selector', ->
      expect(@radio.toggler.html()).to.be(@radio_el.find('> li > .collapse-toggle').html())


  describe '#activate', ->
    it 'opens the panel for a single collapse element', ->
      expect(@collapse_panel.hasClass('in')).to.be false
      @collapse_el.click()
      expect(@collapse_panel.hasClass('in')).to.be true

    it 'calls the #activate method for a check group collapse', ->
      spy = sinon.spy @check, 'activate'
      @check_el.find('.collapse-toggle').first().click()
      expect(spy.called).to.be.ok()

    it 'opens the panel on a click for a check group collapse', ->
      panel = @check_el.find('#collapse_check_1')
      expect(panel.hasClass('in')).to.be false
      @check_el.find('.collapse-toggle').first().click()
      expect(panel.hasClass('in')).to.be true

    it 'opens the panel for a radio group collapse', ->
      panel = @radio_el.find('#collapse_radio_2')
      expect(panel.hasClass('in')).to.be false
      @radio_el.find('li:nth-child(2) > a').click()
      expect(panel.hasClass('in')).to.be true

    it 'closes the panel for a radio group collapse', ->
      panel1 = @radio_el.find('#collapse_radio_1')
      panel2 = @radio_el.find('#collapse_radio_2')
      expect(panel1.hasClass('in')).to.be true
      expect(panel2.hasClass('in')).to.be false
      @radio_el.find('li:nth-child(2) > a').click()
      expect(panel1.hasClass('in')).to.be false
      expect(panel2.hasClass('in')).to.be true


  describe '#deactivate', ->
    it 'closes the panel for a single collapse element', ->
      expect(@auto_panel.hasClass('in')).to.be true
      @auto_el.click()
      expect(@auto_panel.hasClass('in')).to.be false

    it 'calls the #deactivate method for a check group collapse', ->
      spy = sinon.spy @check, 'deactivate'
      @check_el.find('.collapse-toggle').first().click()
      @check_el.find('.collapse-toggle').first().click()
      expect(spy.called).to.be.ok()

    it 'closes the panel on a click for a check group collapse', ->
      panel = @check_el.find('#collapse_check_1')
      expect(panel.hasClass('in')).to.be false
      @check_el.find('.collapse-toggle').first().click()
      expect(panel.hasClass('in')).to.be true
      @check_el.find('.collapse-toggle').first().click()
      expect(panel.hasClass('in')).to.be false

    it 'does not close the panel for a radio group collapse that is active', ->
      panel = @radio_el.find('#collapse_radio_2')
      expect(panel.hasClass('in')).to.be false
      @radio_el.find('li:nth-child(2) > a').click()
      expect(panel.hasClass('in')).to.be true
      @radio_el.find('li:nth-child(2) > a').click()
      expect(panel.hasClass('in')).to.be true


  describe '#deactivateAll', ->
    it 'closes all open panels for a check group', ->
      panel1 = @check_el.find('#collapse_check_1')
      panel2 = @check_el.find('#collapse_check_2')
      @check_el.find('li:nth-child(1) > a').click()
      expect(panel1.hasClass('in')).to.be true
      expect(panel2.hasClass('in')).to.be true
      @check.deactivateAll()
      expect(panel1.hasClass('in')).to.be false
      expect(panel2.hasClass('in')).to.be false


  describe '#activateIndex', ->
    it 'activates through a passed number', ->
      panel = @check_el.find('#collapse_check_1')
      expect(panel.hasClass('in')).not.to.be true
      @check.activateIndex 0
      expect(panel.hasClass('in')).to.be true


  describe '#deactivateIndex', ->
    it 'deactivates through a passed number', ->
      panel = @check_el.find('#collapse_check_2')
      expect(panel.hasClass('in')).to.be true
      @check.deactivateIndex(1)
      expect(panel.hasClass('in')).to.be false


  describe '#dispose', ->
    it 'removes its own listeners for a single collapse', ->
      spy = sinon.spy @collapse, 'removeListeners'
      @collapse.dispose()
      expect(spy.called).to.be.ok()

    it 'removes its own listeners for a group collapse', ->
      spy = sinon.spy @check, 'removeListeners'
      @check.dispose()
      expect(spy.called).to.be.ok()

    it 'does not freak out when calling multiple disposals', ->
      @radio.dispose()
      @radio.dispose()
      expect(@radio.dispose).not.to.throwException()


  describe '#addListeners', ->
    it 'adds a listener for "click" event for a single collapse', ->
      spy = sinon.spy @collapse, 'triggered'
      @collapse_el.click()
      expect(spy.called).to.be.ok()

    it 'adds a listener for "click" event for a group collapse', ->
      spy = sinon.spy @check, 'triggered'
      @check_el.find('li:first-child > a').click()
      expect(spy.called).to.be.ok()


  describe '#removeListeners', ->
    it 'removes a listener for "click" event for a single collapse', ->
      spy = sinon.spy @collapse, 'triggered'
      @collapse.removeListeners()
      @collapse_el.click()
      expect(spy.called).not.to.be.ok()

    it 'removes a listener for "click" event for a group collapse', ->
      spy = sinon.spy @check, 'triggered'
      @check.removeListeners()
      @check_el.find('li:first-child > a').click()
      expect(spy.called).not.to.be.ok()


  describe '#triggered', ->
    it 'expands the height of a collapse panel', ->
      @collapse_el.click()
      expect(@collapse_panel.height()).to.be.above 0

    it 'contracts the height of a collapse panel', ->
      @auto_el.click()
      expect(@auto_panel.height()).to.be 0

    it 'triggers a group with radio behavior', ->
      link1 = @radio_el.find('li:nth-child(2) > a')
      link2 = @radio_el.find('li:nth-child(3) > a')
      panel1 = @radio_el.find('#collapse_radio_2')
      panel2 = @radio_el.find('#collapse_radio_3')

      link1.click()
      expect(panel1.hasClass('in')).to.be true
      expect(panel2.hasClass('in')).to.be false

      link2.click()
      expect(panel1.hasClass('in')).to.be false
      expect(panel2.hasClass('in')).to.be true

    it 'triggers a group with checkbox behavior', ->
      link1 = @check_el.find('li:first-child > a')
      panel1 = @check_el.find('#collapse_check_1')
      panel2 = @check_el.find('#collapse_check_2')

      expect(panel1.hasClass('in')).to.be false
      expect(panel2.hasClass('in')).to.be true

      link1.click()
      expect(panel1.hasClass('in')).to.be true
      expect(panel2.hasClass('in')).to.be true


  describe '#reset', ->
    it 'resets the height of a panel', ->
      spy = sinon.spy @auto, 'reset'
      @auto_el.click()
      expect(spy.called).to.be.ok()
      expect(@auto_panel.height()).to.be 0


  describe '#getPanelAndParent', ->
    it 'returns an object of a panel and parent for a given object', ->
      obj = @collapse.getPanelAndParent(@collapse_el)
      expect(obj.panel.html()).to.be @collapse_panel.html()
      expect(obj.parent.html()).to.be @collapse_el.parent().html()

    it 'caches a selection after being triggered', ->
      expect(@check.cache['#collapse_check_2']).not.to.be undefined
      @check_el.find('li:first-child > a').click()
      expect(@check.cache['#collapse_check_1']).not.to.be undefined


  describe '#transition', ->
    it 'transitions a panel when activated', ->
      spy = sinon.spy @collapse, 'transition'
      @collapse_el.click()
      expect(spy.called).to.be.ok()
      expect(@collapse_panel.height()).to.be.above 0

    it 'transitions a panel when deactivated', ->
      spy = sinon.spy @auto, 'transition'
      @auto_el.click()
      expect(spy.called).to.be.ok()
      expect(@auto_panel.height()).to.be 0

    it 'dispatches a start event for transitioning from the panel for show', ->
      @collapse_panel.on('collapse:show', => @noop arguments...)
      spy = sinon.spy @, 'noop'
      @collapse_el.click()
      expect(spy.called).to.be.ok()

    it 'dispatches a start event for transitioning from the panel for hide', ->
      @collapse_el.click()
      @collapse_panel.on('collapse:hide', => @noop arguments...)
      spy = sinon.spy @, 'noop'
      @collapse_el.click()
      expect(spy.called).to.be.ok()

    it 'dispatches a complete event for transitioning from the panel for shown', ->
      orig = utensils.Detect.hasTransition
      utensils.Detect.hasTransition = false
      @collapse_panel.on('collapse:shown', => @noop arguments...)
      spy = sinon.spy @, 'noop'
      @collapse_el.click()
      expect(spy.called).to.be.ok()
      utensils.Detect.hasTransition = orig

    it 'dispatches a complete event for transitioning from the panel for hidden', ->
      orig = utensils.Detect.hasTransition
      utensils.Detect.hasTransition = false
      @auto_panel.on('collapse:hidden', => @noop arguments...)
      spy = sinon.spy @, 'noop'
      @auto_el.click()
      expect(spy.called).to.be.ok()
      utensils.Detect.hasTransition = orig

