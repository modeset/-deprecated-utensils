#= require utensils/utensils
#= require utensils/bindable
#= require utensils/detect

class utensils.Collapse
  constructor: (@el, data = {}) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    if typeof @data.activate is 'number'
      @activateIndex(@data.activate)
    else if @data.activate is true
      @activateIndex(0)


  options: ->
    @data.namespace ?= 'collapse'
    @data.dimension ?= 'height'
    @data.behavior ?= 'radio'
    @data.selector ?= '> li > .collapse-toggle, > li > .accordion-toggle, > .collapse-toggle, > .accordion-toggle'


  initialize: ->
    @namespace = @data.namespace
    @dimension = @data.dimension
    @behavior = @data.behavior
    @selector = @data.selector
    @toggler = @el.find(@selector)
    @cache = {}

# PUBLIC #

  activateIndex: (index) ->
    toggleItem = $(@toggler[index])
    return if !toggleItem
    @activate(@getPanelAndParent(toggleItem))


  deactivateIndex: (index) ->
    toggleItem = $(@toggler[index])
    return if !toggleItem
    @deactivate(@getPanelAndParent(toggleItem))


  dispose: ->
    return unless @toggler
    @removeListeners()

# PROTECTED #

  addListeners: ->
    @toggler.on "click.#{@namespace}:triggered", => @triggered arguments...


  removeListeners: ->
    @toggler.off "click.#{@namespace}:triggered"


  triggered: (e) ->
    e?.preventDefault()
    link = $(e.target).closest('.collapse-toggle,.accordion-toggle')
    curToggle = @getPanelAndParent(link)
    if @behavior is 'radio'
      return if curToggle['parent'].hasClass('active')
      @deactivateAll()
    if curToggle['parent'].hasClass('active') then @deactivate(curToggle) else @activate(curToggle)


  getPanelAndParent: (link) ->
    selector = if link.data('target') then link.data('target') else link.attr('href')
    if !@cache[selector]
      @cache[selector] =
        panel: $(selector)
        parent: link.parent()
    @cache[selector]


  activate: (toggle) ->
    toggle.parent.addClass('active')
    scroll = if @dimension is 'width' then 'scrollWidth' else 'scrollHeight'
    toggle.panel[@dimension](0)
    @transition(toggle.panel, 'addClass', 'show', 'shown')
    utensils.Detect.hasTransition && toggle.panel[@dimension](toggle.panel[0]?[scroll])


  deactivate: (toggle) ->
    toggle.parent.removeClass('active')
    @reset(toggle.panel, toggle.panel[@dimension]())
    @transition(toggle.panel, 'removeClass', 'hide', 'hidden')
    toggle.panel[@dimension](0)


  deactivateAll: ->
    for toggle in @toggler
      link = $(toggle).closest('.collapse-toggle,.accordion-toggle')
      curToggle = @getPanelAndParent(link)
      @deactivate(curToggle)


  reset: (panel, size) ->
    panel.removeClass('collapse')[@dimension](size || 'auto')[0]?.offsetWidth
    panel[(if size isnt null then 'addClass' else 'removeClass')]('collapse')
    return @


  transition: (panel, method, start_event, complete_event) ->
    self = @
    complete = ->
      self.reset(panel) if start_event is 'show'
      panel.trigger("#{self.namespace}:#{complete_event}")
    panel.trigger("#{@namespace}:#{start_event}")
    panel[method]('in')
    if utensils.Detect.hasTransition and panel.hasClass('collapse')
      panel.one(utensils.Detect.transition.end, complete)
    else
      complete()

utensils.Bindable.register 'collapse', utensils.Collapse

