
#= require utensils/utensils

class utensils.Progress
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @initialize()

  initialize: ->
    @bar = @el.find('.bar')
    @set(@data.initial) if @data.initial || typeof @data.initial == 'number'

# PUBLIC #

  set: (percent) ->
    @bar.css(width:"#{percent}%")
    return this

  get: ->
    return Math.round(@bar.width() / @el.width() * 100)

  reset: ->
    @bar.css(width:0)
    return this

  complete: ->
    @bar.css(width:"100%")
    return this

