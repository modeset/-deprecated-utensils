
#= require utensils/utensils
#= require utensils/bindable
#= require utensils/detect

class utensils.Modal
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()

  options: ->
    @data.namespace = @data.namespace || 'modal'

  initialize: ->
    @namespace = @data.namespace
    @keyboard = true
    @markup = null
    @dismissers = null

# PUBLIC #

  activate: (e) ->
    e?.preventDefault()
    @addBackdrop()
    @html = @html || $('html')
    @html.on("keydown.close_modal.#{@namespace}", => @keyed arguments...) if @keyboard
    # @addModal()

  deactivate: (e) ->
    e?.preventDefault()
    @removeModal()
    # @removeBackdrop()

  dispose: ->
    @html.off("keydown.close_modal.#{@namespace}") if @keyboard
    @deactivate()
    @removeListeners()

# PROTECTED #

  addListeners: ->
    @el.on("click.#{@namespace}", => @activate arguments...)

  removeListeners: ->
    @el.off("click.#{@namespace}")

  addModal: ->
    @markup = @markup || @findMarkup()
    @markup.css(display: 'block')
    @markup[0].offsetWidth
    @markup.addClass('in')
    @dismissers = @dismissers ||  @markup.find('[data-dismiss]')
    @dismissers.on("click.close_modal.#{@namespace}", => @deactivate arguments...)

  addBackdrop: ->
    @container = @container || $('body')
    @backdrop = @renderBackdrop()
    @backdrop.appendTo(@container)
    @backdrop[0].offsetWidth
    @backdrop.on("click.close_modal.#{@namespace}", => @deactivate arguments...)

    if utensils.Detect.hasTransition
      @backdrop.one(utensils.Detect.transition.end, => @addModal arguments...)
    else
      @addModal()
    @backdrop.addClass('in')

  removeModal: ->
    @dismissers.off("click.close_modal.#{@namespace}")
    if utensils.Detect.hasTransition
      @markup.one(utensils.Detect.transition.end, => @removeBackdrop arguments...)
    else
      @removeBackdrop()
    @markup.removeClass('in')

  removeBackdrop: ->
    @markup.css(display: 'none')
    @backdrop.off("click.close_modal.#{@namespace}")

    if utensils.Detect.hasTransition
      @backdrop.one(utensils.Detect.transition.end, => @cleanup arguments...)
    else
      @cleanup()
    @backdrop.removeClass('in')

  cleanup: ->
    @backdrop.remove()

  keyed: (e) ->
    return if (!/(27)/.test(e.keyCode))
    e?.preventDefault()
    e?.stopPropagation()
    if e.keyCode == 27 then return @deactivate()

  findMarkup: ->
    return $(@el.attr('href'))

  renderBackdrop: ->
    html = """
           <div class="modal-backdrop fade"></div>
           """
    return $(html)

utensils.Bindable.register('modal', utensils.Modal)

# Todo:
# - Is there always a backdrop (maybe just not visually)?
# - Clean this up
# - Test this
# - Better caching (renderBackdrop..)
# - Add auto activate
# - Do we need to create tab focus?

