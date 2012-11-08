
#= require utensils/utensils
#= require utensils/bindable
#= require utensils/detect
#= require utensils/toggle
#= require utensils/toggle_group

class utensils.Collapse
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @activate(@data.activate) if @data.activate || typeof @data.activate == 'number'
    @multi() if @data.multipleActivate && @type == 'group' && @behavior != 'radio'

  options: ->
    @data.namespace = @data.namespace || 'collapse'
    @data.dimension = @data.dimension || 'height'
    @data.type = @data.type || 'single'

  initialize: ->
    @namespace = @data.namespace
    @dimension = @data.dimension
    @type = @data.type
    @target = null

    if @type == 'group'
      @toggler = new utensils.ToggleGroup(@el, @data)
    else
      @toggler = new utensils.Toggle(@el, @data)

# PUBLIC #

  activate: (item) ->
    @toggler.activate(item)

  deactivate: (item) ->
    @toggler.deactivate(item)

  dispose: ->
    return unless @toggler
    @removeListeners()
    @toggler.dispose()
    @toggler = null

  multi: ->
    targets = @toggler.setTargets()
    for target in targets
      $target = $(target)
      @activate($target) if $target.data('activate') == true

# PROTECTED #

  addListeners: ->
    if @type == 'group'
      @el.on("#{@namespace}:triggered", => @triggered arguments...)
    else
      @el.on("#{@namespace}:activated", => @activated arguments...)
      @el.on("#{@namespace}:deactivated", => @deactivated arguments...)

  removeListeners: ->
    if @type == 'group'
      @el.off("#{@namespace}:triggered")
    else
      @el.off("#{@namespace}:activated")
      @el.off("#{@namespace}:deactivated")

  activated: (e) ->
    @setTarget() unless @target
    scroll = if @dimension == 'width' then 'scrollWidth' else 'scrollHeight'
    @target[@dimension](0)
    @transition('addClass', 'show', 'shown')
    utensils.Detect.hasTransition && @target[@dimension](@target[0][scroll])

  deactivated: (e) ->
    @setTarget() unless @target
    @reset(@target[@dimension]())
    @transition('removeClass', 'hide', 'hidden')
    @target[@dimension](0)

  triggered: (e, element) ->
    if @toggler.behavior == 'radio' && @target then @deactivated()
    activator = $(element)
    @setGroupTarget(activator)
    if activator.hasClass(@toggler.toggle_classes) then @activated(e) else @deactivated(e)

  reset: (size) ->
    @setTarget() unless @target
    @target.removeClass('collapse')[@dimension](size || 'auto')[0].offsetWidth
    @target[(if size != null then 'addClass' else 'removeClass')]('collapse')
    return this

  transition: (method, start_event, complete_event) ->
    self = this
    complete = ->
      self.reset() if start_event == 'show'
      self.target.trigger("#{self.namespace}:#{complete_event}")

    @target.trigger("#{@namespace}:#{start_event}")
    @target[method] 'in'

    if utensils.Detect.hasTransition && @target.hasClass('collapse')
      @target.one(utensils.Detect.transition.end, complete)
    else
      complete()

  setTarget: ->
    @target = if @data.target then $(@data.target) else $(@el.attr('href'))

  setGroupTarget: (activator) ->
    link = activator.find('> a,> button')
    selector = link.data('target') || link.attr('href')
    target = activator.find(selector)
    @target = if target.length > 0 then target else $(selector)

utensils.Bindable.register('collapse', utensils.Collapse)

