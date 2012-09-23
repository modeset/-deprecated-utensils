
#= require utensil
#= require bindable
#= require togglable
#= require directional

class utensil.Drop extends utensil.Togglable
  constructor: (@el, data) ->
    super(@el, data)

  options: ->
    @html = $('html')
    @data.toggle = 'open active'
    @placement = @data.placement || 'south'
    super()

  initialize: ->
    @menu = @findMenu()
    @directional = new utensil.Directional(@menu, @el, @placement)
    @cardinals = @directional.getCardinals()
    super()

  # PROTECTED #

  setActivate: (e) ->
    e?.stopPropagation()
    @html.on('click', @clearMenus)
    super(e)

  setDeactivate: (e) =>
    if $(e.target).parents('.menu').length <= 0 then e.stopPropagation()
    @html.off('click', @clearMenus)
    super(e)

  activeState: (e) ->
    super(e)
    position = @directional.getPlacementAndConstrain()
    if position.cardinal != @placement
      @menu.removeClass(@cardinals).addClass(position.cardinal)

  clearMenus: (e) =>
    if @is_active then @deactivate(e)

  findMenu: ->
    child = @target.find('.menu')
    if child.length > 0 then return child

    sibling = @target.next('.menu')
    if sibling.length > 0 then return sibling

    return null

Bindable.register 'drop', utensil.Drop

