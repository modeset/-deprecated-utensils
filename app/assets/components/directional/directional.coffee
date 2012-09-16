
#= require utensil

class utensil.Directional

  constructor: (element=null, container=null, @cardinal='north') ->
    @cardinals = "north south east west"
    @setElement(element) if element
    @setContainer(container) if container

  setElement: (@element) ->
  setContainer: (@container) ->
  setCardinal: (@cardinal) ->
  getCardinals: -> @cardinals

  getPlacementAndConstrain: () ->
    default_position = @getPlacementFromCardinal()
    return @constrainToViewport(default_position)

  getPlacementFromCardinal: (cardinal=@cardinal) ->
    ed = @getDimensions(@element)
    cd = @getDimensions(@container)

    if cardinal == 'north'
      return {
        cardinal: 'north'
        top: Math.round(cd.top - ed.height)
        left: Math.round(cd.left + cd.width * 0.5 - ed.width * 0.5)
      }
    else if cardinal == 'south'
      return {
        cardinal: 'south'
        top: Math.round(cd.top + cd.height)
        left: Math.round(cd.left + cd.width * 0.5 - ed.width * 0.5)
      }
    else if cardinal == 'east'
      return {
        cardinal: 'east'
        top: Math.round(cd.top + cd.height * 0.5 - ed.height * 0.5)
        left: Math.round(cd.left + cd.width)
      }
    else if cardinal == 'west'
      return {
        cardinal: 'west'
        top: Math.round(cd.top + cd.height * 0.5 - ed.height * 0.5)
        left: Math.round(cd.left - ed.width)
      }
    return {cardinal: cardinal, top:0, left:0}

  constrainToViewport: (position) ->
    win = $(window)
    wt = win.scrollTop()
    wl = win.scrollLeft()
    ww = win.width()
    wh = win.height()
    ew = @element.outerWidth()
    eh = @element.outerHeight()

    if (position.top < wt)
      return @getPlacementFromCardinal('south')
    if (position.top + eh > wt + wh)
      return @getPlacementFromCardinal('north')
    if (position.left + ew > wl + ww)
      return @getPlacementFromCardinal('west')
    if (position.left < wl)
      return @getPlacementFromCardinal('east')
    return position

  getDimensions: (element) ->
    eo = element.offset()
    return {
      top: eo.top
      left: eo.left
      width: element.outerWidth()
      height: element.outerHeight()
    }

