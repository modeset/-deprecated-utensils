#= require utensils/utensils

class utensils.Directional

  constructor: (element=null, container=null, @cardinal='north', @cardinals = "north east south west") ->
    @win = $(window)
    # The element that is to be positioned
    @setElement(element) if element
    # The container that the element will be positioned relative to
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
        offsetTop: 0
        offsetLeft: 0
      }
    else if cardinal is 'south'
      return {
        cardinal: 'south'
        top: Math.round(cd.top + cd.height)
        left: Math.round(cd.left + cd.width * 0.5 - ed.width * 0.5)
        offsetTop: 0
        offsetLeft: 0
      }
    else if cardinal is 'east'
      return {
        cardinal: 'east'
        top: Math.round(cd.top + cd.height * 0.5 - ed.height * 0.5)
        left: Math.round(cd.left + cd.width)
        offsetTop: 0
        offsetLeft: 0
      }
    else if cardinal is 'west'
      return {
        cardinal: 'west'
        top: Math.round(cd.top + cd.height * 0.5 - ed.height * 0.5)
        left: Math.round(cd.left - ed.width)
        offsetTop: 0
        offsetLeft: 0
      }
    return {cardinal: cardinal, top:0, left:0}


  constrainToViewport: (position, areas = {}) ->
    # check if our preferred cardinality is fully visible
    position = @getPlacementFromCardinal(@cardinal)
    preferredArea = @calculateOffsetFromVisibleArea(position)
    return position if preferredArea == 1

    # find the cardinality that provides the greatest visible area
    lastArea = 0
    for cardinal in @getCardinals().split(' ')
      potential = @getPlacementFromCardinal(cardinal)
      area = @calculateOffsetFromVisibleArea(potential)

      if area > lastArea || area == lastArea && cardinal == @cardinal
        position = potential
        lastArea = area

    position


  calculateOffsetFromVisibleArea: (position)->
    # window coordinates and dimensions
    ww = @win.width()
    wh = @win.height()
    wt = @win.scrollTop()
    wl = @win.scrollLeft()
    wr = wl + ww
    wb = wt + wh

    # element coordinates and dimensions
    ew = @element.outerWidth()
    eh = @element.outerHeight()
    et = position.top
    el = position.left
    er = position.left + ew
    eb = position.top + eh

    # element area
    area = ew * eh
    visibleArea = area

    # top offset, the element top is higher than the window top
    if (et < wt)
      offset = (wt - et)
      visibleArea -= offset * ew
      position.offsetTop += offset

    # right offset, the element right is passed the window right
    if (er > wr)
      offset = (er - wr)
      visibleArea -= offset * eh
      position.offsetLeft -= offset

    # bottom offset, the element bottom is below the window bottom
    if (eb > wb)
      offset = (eb - wb)
      visibleArea -= offset * ew
      position.offsetTop -= offset

    # left offset, the element left is passed the window left
    if (el < wl)
      offset = (wl - el)
      visibleArea -= offset * eh
      position.offsetLeft += offset

    # return the visible area to area ratio to quantify how much of the element is offscreen
    return visibleArea / area


  getDimensions: (element) ->
    eo = element.offset()
    return {
      top: eo.top
      left: eo.left
      width: element.outerWidth()
      height: element.outerHeight()
    }

