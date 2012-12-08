#= require utensils/utensils

class utensils.Directional

  constructor: (element=null, container=null, @cardinal='north') ->
    @win = $(window)
    @cardinals = "north south east west"
    @setElement(element) if element
    @setContainer(container) if container


  setElement: (@element) ->
  setContainer: (@container) ->
  setCardinal: (@cardinal) ->
  getCardinals: -> @cardinals


  getPlacementAndConstrain: ->
    @constrainToViewport(@getPlacementFromCardinal())


  getPlacementFromCardinal: (cardinal=@cardinal) ->
    ed = @getDimensions(@element)
    cd = @getDimensions(@container)

    if cardinal is 'north'
      return {
        cardinal: 'north'
        top: Math.round(cd.top - ed.height)
        left: Math.round(cd.left + cd.width * 0.5 - ed.width * 0.5)
      }
    else if cardinal is 'south'
      return {
        cardinal: 'south'
        top: Math.round(cd.top + cd.height)
        left: Math.round(cd.left + cd.width * 0.5 - ed.width * 0.5)
      }
    else if cardinal is 'east'
      return {
        cardinal: 'east'
        top: Math.round(cd.top + cd.height * 0.5 - ed.height * 0.5)
        left: Math.round(cd.left + cd.width)
      }
    else if cardinal is 'west'
      return {
        cardinal: 'west'
        top: Math.round(cd.top + cd.height * 0.5 - ed.height * 0.5)
        left: Math.round(cd.left - ed.width)
      }
    return {cardinal: cardinal, top:0, left:0}


  constrainToViewport: (position) ->
    wt = @win.scrollTop()
    wl = @win.scrollLeft()
    ww = @win.width()
    wh = @win.height()
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

