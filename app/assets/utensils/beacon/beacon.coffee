#= require utensils/utensils

class utensils.Beacon
  constructor: (@dispatcher, @data={}) ->
    @timer = null
    @index = @data.index or 0
    @total = @data.total or 1
    @duration = @data.duration or 1000
    @is_continuous = if @data.continuous is true then true else false


# PUBLIC #

  start: ->
    @send 'started'
    @timer = setTimeout(( => @ticked()), @duration)


  pause: ->
    @send 'paused'


  stop: ->
    @index = @data.index ? 0
    @send 'stopped'


  tick: ->
    @send 'ticked'
    @index += 1


  finish: ->
    @stop()
    @send 'finished'


  dispose: ->
    @clear()
    @dispatcher.off "beacon:started beacon:paused beacon:stopped beacon:ticked beacon:finished"


# PROTECTED #

  ticked: ->
    @tick()
    return @finish() if @index >= @total
    @start() if @is_continuous


  send: (event_type) ->
    @clear()
    @dispatcher.trigger "beacon:#{event_type}", {index: @index, total: @total}


  clear: ->
    clearTimeout @timer if @timer
    @timer = null

