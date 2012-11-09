
#= require utensils/utensils
#= require utensils/bindable
#= require utensils/toggle_group

class utensils.Tab
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @activate(@data.activate) if @data.activate || typeof @data.activate == 'number'

  options: ->
    @data.namespace = @data.namespace || 'tab'
    @data.related = @data.related || null
    @data.toggle = @data.toggle || 'active'
    @data.relatedToggle = @data.relatedToggle || @data.toggle

  initialize: ->
    @namespace = @data.namespace
    @related = @data.related
    @toggle_classes = @data.toggle
    @related_classes = @data.relatedToggle
    @container = null
    @panes = {}
    @toggler = new utensils.ToggleGroup(@el, @data)
    @related_classified = "." + @related_classes.replace(/\s+/g, ' .')

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

# PROTECTED #

  addListeners: ->
    @el.on("#{@namespace}:triggered", => @triggered arguments...)

  removeListeners: ->
    @el.off("#{@namespace}:triggered")

  triggered: (e, link) ->
    @setTabableContainer() unless @container
    $referer = $(link)
    selector = $referer.find('[data-target]').data('target') ||
               $referer.find('[href]').attr('href')

    element = @getTabablePane(selector)
    if element.length
      @container.find(@related_classified).removeClass(@related_classes)
      element.addClass(@related_classes)

  getTabablePane: (selector) ->
    if !@panes[selector]
      @panes[selector] = $(selector)
    return @panes[selector]

  setTabableContainer: ->
    if @related
      container = @el.parent().find(@related)
      @container = if container.length then container else $(@related)
    else
      @container = @el.parent().next()

utensils.Bindable.register('tab', utensils.Tab)

