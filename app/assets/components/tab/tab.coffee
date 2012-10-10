
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
    @related = @data.related                # Need to perform a lookup
    @toggle_classes = @data.toggle
    @related_classes = @data.relatedToggle
    @toggler = new utensil.ToggleGroup(@el, @data)

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
    @el.on('tab:triggered', => @triggered arguments...)

  removeListeners: ->
    @el.off('tab:triggered')

  # This is a really slow lookup ATM, need to search once and optimize
  # Also, we need to use a lookup if data-related is passed
  triggered: (e, link) ->
    container = @el.parent().next()
    selector = $(link).find('[data-target]').data('target') ||
               $(link).find('[href]').attr('href')

    element = $(selector)
    if element.length > 0
      container.find('.active').removeClass('active')
      element.addClass('active')

Bindable.register('tab', utensil.Tab)

