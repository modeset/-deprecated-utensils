
#= require utensil
#= require bindable
#= require togglable
#= require directional

class utensil.Drop
  constructor: (@el, data) ->
    @html = $('html')
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @activate() if @data.activate

  options: ->
    # override togglable defaults
    @toggle_classes = @data.toggle || 'active open'
    @data.toggle = @toggle_classes
    @data.target = @el unless @data.target

    # drop options
    @use_keyboard = if @data.keyboard == false || @html.hasClass('touch') then false else true
    @placement = @data.placement || 'south'
    @select_classes = @data.select || 'selected'

  initialize: ->
    @is_sibling = false
    @toggler = new utensil.Togglable(@el, @data)
    @toggler.stop_propagation = true
    @target = @toggler.target
    @menu = @findMenu()
    @menu_items = @menu.find('li')
    @directional = new utensil.Directional(@menu, @el, @placement)
    @cardinals = @directional.getCardinals()
    @group = @findGroup() if @data.group

  # PUBLIC #

  toggle: (e) ->
    @toggler.toggle(e)

  activate: (e) ->
    @toggler.activate(e)

  deactivate: (e) ->
    @toggler.deactivate(e)

  dispose: ->
    @deactivate()
    @removeListeners()
    @toggler.dispose()
    @toggler = null

  # PROTECTED #

  addListeners: ->
    @toggler.dispatcher.on('togglable:activate', => @activated arguments...)
    @toggler.dispatcher.on('togglable:deactivate', => @deactivated arguments...)
    @group.on('togglable:activate', => @toggleSelectionFromGroup arguments...) if @group
    @menu_items.on('click.drop.menu', => @deactivate arguments...) if @is_sibling

  removeListeners: ->
    @toggler.dispatcher.off('togglable:activate')
    @toggler.dispatcher.off('togglable:deactivate')
    @group.off('togglable:activate') if @group
    @menu_items.off('click.drop.menu') if @is_sibling

  activated: (e) ->
    position = @directional.getPlacementAndConstrain()
    @menu.removeClass(@cardinals).addClass(position.cardinal)
    @html.on('keydown.menu', => @keyed arguments...) if @use_keyboard
    # @html.on('click.drop.html', => @deactivate arguments...)
    @el.focus()

  deactivated: (e) ->
    @html.off('keydown.menu') if @use_keyboard
    # @html.off('click.drop.html')

  toggleSelectionFromGroup: (e) ->
    if @menu_items.hasClass('active')
      @target.addClass(@select_classes)
    else
      @target.removeClass(@select_classes)

  keyed: (e) ->
    return if (!/(27)/.test(e.keyCode))
    e?.preventDefault()
    e?.stopPropagation()

    if e.keyCode == 27
      @deactivate(e)

  findMenu: ->
    child = @target.find('.menu')
    if child.length > 0 then return child.first()

    sibling = @target.next('.menu')
    if sibling.length > 0
      @is_sibling = true
      return sibling.first()

    return null

  findGroup: ->
    group = @menu.closest(@data.group).first()
    if group.length > 0 then return group else return null

Bindable.register('drop', utensil.Drop)

