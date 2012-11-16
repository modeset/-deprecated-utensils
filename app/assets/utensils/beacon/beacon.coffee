
#= require utensils/utensils

class utensils.Beacon
  constructor: (@dispatcher, @data={}) ->
    @timer = null
    @index = @data.index || 0
    @total = @data.total || 1
    @duration = @data.duration || 1000
    @is_continuous = if @data.continuous == true then true else false

  start: ->
    @send('started')
    @timer = setTimeout(( => @ticked()), @duration)

  pause: ->
    @send('paused')

  stop: ->
    @index = @data.index || 0
    @send('stopped')

  tick: ->
    @send('ticked')
    @index += 1

  dispose: ->
    @clear()
    @dispatcher.off("beacon:started beacon:paused beacon:stopped beacon:ticked beacon:finished")

  ticked: ->
    @tick()
    if @index >= @total
      @stop()
      @send('finished')
    else if @is_continuous
      @start()

  send: (event_type) ->
    @clear()
    @dispatcher.trigger("beacon:#{event_type}", {index: @index, total: @total})

  clear: ->
    clearTimeout(@timer) if @timer
    @timer = null

