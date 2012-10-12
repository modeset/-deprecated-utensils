
#= require utensil
#= require bindable
#= require toggle_group

class utensil.Tab
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
    @toggler = new utensil.ToggleGroup(@el, @data)
    @container = null
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

  # This is a really slow lookup ATM, need to search once and store
  triggered: (e, link) ->
    @container = @findContainer()
    selector = $(link).find('[data-target]').data('target') ||
               $(link).find('[href]').attr('href')

    element = $(selector)
    if element.length > 0
      @container.find(@related_classified).removeClass(@related_classes)
      element.addClass(@related_classes)

  findContainer: ->
    return @container if @container
    if @related
      container = @el.parent().find(@related)
      if container.length > 0 then return container else return $(@related)
    else
      return @el.parent().next()

Bindable.register('tab', utensil.Tab)

