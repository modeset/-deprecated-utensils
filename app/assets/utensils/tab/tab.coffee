
#= require utensils/utensils
#= require utensils/bindable
#= require utensils/toggle_group

class utensils.Tab
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @activate(@data.activate) if @data.activate

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
    @removeListeners()
    @toggler.dispose()
    @toggler = null

# PROTECTED #

  addListeners: ->
    @el.on("#{@namespace}:triggered", => @triggered arguments...)

  removeListeners: ->
    @el.off("#{@namespace}:triggered")

  triggered: (e, link) ->
    @container = @findContainer()
    selector = $(link).find('[data-target]').data('target') ||
               $(link).find('[href]').attr('href')

    element = @getTabablePane(selector)
    if element.length > 0
      @container.find(@related_classified).removeClass(@related_classes)
      element.addClass(@related_classes)

  getTabablePane: (selector) ->
    if !@panes[selector]
      pane = $(selector)
      @panes[selector] = pane
    return @panes[selector]

  findContainer: ->
    return @container if @container
    if @related
      container = @el.parent().find(@related)
      if container.length > 0 then return container else return $(@related)
    else
      return @el.parent().next()

utensils.Bindable.register('tab', utensils.Tab)

