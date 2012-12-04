#= require utensils/utensils
#= require utensils/bindable
#= require utensils/triggerable
#= require utensils/detect

class utensils.Modal
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @activate() if @data.activate


  options: ->
    @data.namespace ?= 'modal'
    @data.keyboard ?= true


  initialize: ->
    @is_active = false
    @namespace = @data.namespace
    @keyboard = @data.keyboard
    @markup = null
    @dismissers = null
    @triggerable = new utensils.Triggerable @el, @data


# PUBLIC #

  activate: ->
    @triggerable.activate target: @el


  deactivate: ->
    @removeDocumentListeners()
    @removeModal()
    @is_active = false


  dispose: ->
    return unless @triggerable
    @removeListeners()
    @deactivate() if @is_active
    @triggerable.dispose()
    @triggerable = null


# PROTECTED #

  addListeners: ->
    @triggerable.dispatcher.on "triggerable:trigger", => @activated arguments...


  removeListeners: ->
    @triggerable.dispatcher.off "triggerable:trigger"


  activated: (e) ->
    @addBackdrop()
    @addDocumentListeners()
    @is_active = true


  addDocumentListeners: ->
    @html ?= $('html')
    @html.on "keydown.close_modal.#{@namespace}", => @keyed arguments... if @keyboard
    @backdrop.on "click.close_modal.#{@namespace}", => @deactivate arguments...


  removeDocumentListeners: ->
    @html ?= $('html')
    @html.off "keydown.close_modal.#{@namespace}" if @keyboard
    @backdrop.off "click.close_modal.#{@namespace}"


  addDismissListeners: ->
    @dismissers = @dismissers or @markup.find('[data-dismiss]')
    @dismissers.on "click.close_modal.#{@namespace}", => @deactivate arguments... if @dismissers.length


  removeDismissListeners: ->
    @dismissers.off "click.close_modal.#{@namespace}" if @dismissers && @dismissers.length


  keyed: (e) ->
    return if (!/(27)/.test(e.keyCode))
    e?.preventDefault()
    e?.stopPropagation()
    return @deactivate() if e.keyCode is 27


  transition: (element, method, fn) ->
    @setTransitions() unless @tranny_defined
    if @has_tranny then element.one @tranny_end, fn else fn()
    element[method]('in')


  addBackdrop: ->
    @container ?= $('body')
    @backdrop ?= @renderBackdrop()
    @backdrop.appendTo @container
    @backdrop[0].offsetWidth
    @transition @backdrop, 'addClass', => @addModal arguments...


  addModal: ->
    @markup ?= @findMarkup()
    @markup.css display: 'block'
    @markup[0].offsetWidth
    @markup.addClass 'in'
    @addDismissListeners()


  removeModal: ->
    @removeDismissListeners()
    @transition @markup, 'removeClass', => @removeBackdrop arguments...


  removeBackdrop: ->
    @markup.css display: 'none'
    @transition @backdrop, 'removeClass', => @cleanupBackdrop arguments...


  cleanupBackdrop: ->
    @backdrop.remove()


  setTransitions: ->
    @has_tranny = utensils.Detect.hasTransition
    @tranny_end = utensils.Detect.transition.end
    @tranny_defined = true


  findMarkup: ->
    return if @data.target then $(@data.target) else $(@el.attr('href'))


  renderBackdrop: ->
    html = """
           <div class="modal-backdrop fade"></div>
           """
    return $(html)

utensils.Bindable.register 'modal', utensils.Modal

