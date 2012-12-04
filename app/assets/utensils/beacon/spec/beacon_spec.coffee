#= require utensils/beacon

describe 'Beacon', ->

  beforeEach ->
    @event = null
    @element = null
    @noop = (e, element) ->
      @event = e
      @element = $(element)

    data =
      index: 1
      total: 4
      duration: 50
      continuous: true

    @dom = $('#jasmine-fixtures')
    @window = $(window)
    @beacon = new utensils.Beacon(@window)
    @custom = new utensils.Beacon(@dom, data)

  afterEach ->
    @beacon.dispose()
    @custom.dispose()


  describe '#constructor', ->
    it 'sets up logical defaults', ->
      expect(@beacon.timer).toBeNull()
      expect(@beacon.index).toEqual(0)
      expect(@beacon.total).toEqual(1)
      expect(@beacon.duration).toEqual(1000)
      expect(@beacon.is_continuous).toEqual(false)

    it 'overrides the default values', ->
      expect(@custom.timer).toBeNull()
      expect(@custom.index).toEqual(1)
      expect(@custom.total).toEqual(4)
      expect(@custom.duration).toEqual(50)
      expect(@custom.is_continuous).toEqual(true)


  describe '#start', ->
    it 'sends a "started" event', ->
      spyEvent = spyOn(@beacon, 'send')
      @beacon.start()
      expect(spyEvent).toHaveBeenCalledWith('started')

    it 'clears out any timers once started', ->
      spyEvent = spyOn(@beacon, 'clear')
      @beacon.start()
      expect(spyEvent).toHaveBeenCalled()

    it 'creates a timer for ticking', ->
      @beacon.start()
      expect(@beacon.timer).not.toBeNull()


  describe '#pause', ->
    it 'sends a "paused" event', ->
      spyEvent = spyOn(@beacon, 'send')
      @beacon.pause()
      expect(spyEvent).toHaveBeenCalledWith('paused')

    it 'nulls out the timer on pause', ->
      @beacon.start()
      expect(@beacon.timer).not.toBeNull()
      @beacon.pause()
      expect(@beacon.timer).toBeNull()


  describe '#stop', ->
    it 'sends a "stopped" event', ->
      spyEvent = spyOn(@beacon, 'send')
      @beacon.stop()
      expect(spyEvent).toHaveBeenCalledWith('stopped')

    it 'nulls out the timer on stopped', ->
      @beacon.start()
      expect(@beacon.timer).not.toBeNull()
      @beacon.stop()
      expect(@beacon.timer).toBeNull()

    it 'resets the index back to zero when stopped', ->
      @beacon.tick()
      @beacon.tick()
      expect(@beacon.index).toBeGreaterThan(1)
      @beacon.stop()
      expect(@beacon.index).toEqual(0)

    it 'resets the index back to the default when stopped', ->
      @custom.tick()
      @custom.tick()
      expect(@custom.index).toBeGreaterThan(2)
      @custom.stop()
      expect(@custom.index).toEqual(1)


  describe '#tick', ->
    it 'sends a "ticked" event', ->
      spyEvent = spyOn(@beacon, 'send')
      @beacon.tick()
      expect(spyEvent).toHaveBeenCalledWith('ticked')

    it 'nulls out the timer on tick', ->
      @beacon.start()
      expect(@beacon.timer).not.toBeNull()
      @beacon.tick()
      expect(@beacon.timer).toBeNull()

    it 'increments the index when ticked', ->
      @beacon.tick()
      @beacon.tick()
      expect(@beacon.index).toEqual(2)


  describe '#finish', ->
    it 'dispatches a "finished" event when the beacon index has reached the total', ->
      spyEvent = spyOn(@beacon, 'send')
      @beacon.tick()
      @beacon.tick()
      @beacon.ticked()
      expect(spyEvent).toHaveBeenCalledWith('finished')


  describe '#dispose', ->
    it 'removes the listeners on the beacons dispatchers', ->
      @beacon.dispatcher.on('beacon:ticked', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @beacon.dispose()
      @beacon.tick()
      expect(spyEvent).not.toHaveBeenCalled()

    it 'nulls out the timer on disposal', ->
      @beacon.start()
      expect(@beacon.timer).not.toBeNull()
      @beacon.dispose()
      expect(@beacon.timer).toBeNull()


  describe '#ticked', ->
    it 'calls tick after a period of time', ->
      spyEvent = spyOn(@custom, 'ticked')
      runs ->
        @custom.start()
      waits 100
      runs ->
        expect(spyEvent).toHaveBeenCalled()

    it 'calls stop when the beacon index has reached the total', ->
      spyEvent = spyOn(@beacon, 'stop')
      @beacon.tick()
      @beacon.tick()
      @beacon.ticked()
      expect(spyEvent).toHaveBeenCalled()

    it 'dispatches a "finished" event when the beacon index has reached the total', ->
      spyEvent = spyOn(@beacon, 'send')
      @beacon.tick()
      @beacon.tick()
      @beacon.ticked()
      expect(spyEvent).toHaveBeenCalledWith('finished')

    it 'calls the "start" method when "is_continuous" is set', ->
      spyEvent = spyOn(@custom, 'start')
      @custom.ticked()
      expect(spyEvent).toHaveBeenCalled()


  describe '#send', ->
    it 'send a tick event', ->
      @beacon.dispatcher.on('beacon:ticked', => @noop arguments...)
      spyEvent = spyOn(this, 'noop').andCallThrough()
      @beacon.tick()
      expect(spyEvent).toHaveBeenCalled()


  describe '#clear', ->
    it 'kills the timer when cleared', ->
      @beacon.start()
      expect(@beacon.timer).not.toBeNull()
      @beacon.tick()
      expect(@beacon.timer).toBeNull()

