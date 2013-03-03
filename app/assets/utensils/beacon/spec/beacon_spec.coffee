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

    @dom = $(fixture.el)
    @window = $(window)
    @beacon = new utensils.Beacon(@window)
    @custom = new utensils.Beacon(@dom, data)

  afterEach ->
    @beacon.dispose()
    @custom.dispose()


  describe '#constructor', ->
    it 'sets up logical defaults', ->
      expect(@beacon.timer).to.be null
      expect(@beacon.index).to.be 0
      expect(@beacon.total).to.be 1
      expect(@beacon.duration).to.be 1000
      expect(@beacon.is_continuous).to.be false

    it 'overrides the default values', ->
      expect(@custom.timer).to.be null
      expect(@custom.index).to.be 1
      expect(@custom.total).to.be 4
      expect(@custom.duration).to.be 50
      expect(@custom.is_continuous).to.be.ok()


  describe '#start', ->
    it 'sends a "started" event', ->
      spy = sinon.spy @beacon, 'send'
      @beacon.start()
      expect(spy.calledWith('started')).to.be.ok()

    it 'clears out any timers once started', ->
      spy = sinon.spy @beacon, 'clear'
      @beacon.start()
      expect(spy.called).to.be.ok()

    it 'creates a timer for ticking', ->
      @beacon.start()
      expect(@beacon.timer).not.to.be null


  describe '#pause', ->
    it 'sends a "paused" event', ->
      spy = sinon.spy @beacon, 'send'
      @beacon.pause()
      expect(spy.calledWith('paused')).to.be.ok()

    it 'nulls out the timer on pause', ->
      @beacon.start()
      expect(@beacon.timer).not.to.be null
      @beacon.pause()
      expect(@beacon.timer).to.be null


  describe '#stop', ->
    it 'sends a "stopped" event', ->
      spy = sinon.spy @beacon, 'send'
      @beacon.stop()
      expect(spy.calledWith('stopped')).to.be.ok()

    it 'nulls out the timer on stopped', ->
      @beacon.start()
      expect(@beacon.timer).not.to.be null
      @beacon.stop()
      expect(@beacon.timer).to.be null

    it 'resets the index back to zero when stopped', ->
      @beacon.tick()
      @beacon.tick()
      expect(@beacon.index).to.be.above 1
      @beacon.stop()
      expect(@beacon.index).to.be 0

    it 'resets the index back to the default when stopped', ->
      @custom.tick()
      @custom.tick()
      expect(@custom.index).to.be.above 2
      @custom.stop()
      expect(@custom.index).to.be 1


  describe '#tick', ->
    it 'sends a "ticked" event', ->
      spy = sinon.spy @beacon, 'send'
      @beacon.tick()
      expect(spy.calledWith("ticked")).to.be.ok()

    it 'nulls out the timer on tick', ->
      @beacon.start()
      expect(@beacon.timer).not.to.be null
      @beacon.tick()
      expect(@beacon.timer).to.be null

    it 'increments the index when ticked', ->
      @beacon.tick()
      @beacon.tick()
      expect(@beacon.index).to.be 2


  describe '#finish', ->
    it 'dispatches a "finished" event when the beacon index has reached the total', ->
      spy = sinon.spy @beacon, 'send'
      @beacon.tick()
      @beacon.tick()
      @beacon.ticked()
      expect(spy.calledWith('finished')).to.be.ok()


  describe '#dispose', ->
    it 'removes the listeners on the beacons dispatchers', ->
      @beacon.dispatcher.on('beacon:ticked', => @noop arguments...)
      spy = sinon.spy @, 'noop'
      @beacon.dispose()
      @beacon.tick()
      expect(spy.called).not.to.be.ok()

    it 'nulls out the timer on disposal', ->
      @beacon.start()
      expect(@beacon.timer).not.to.be null
      @beacon.dispose()
      expect(@beacon.timer).to.be null


  describe '#ticked', ->
    it 'calls tick after a period of time', (done) ->
      spy = sinon.spy @custom, 'ticked'
      @custom.start()
      setTimeout(( =>
        expect(spy.called).to.be.ok()
        done()
      ), 100)

    it 'calls stop when the beacon index has reached the total', ->
      spy = sinon.spy @beacon, 'stop'
      @beacon.tick()
      @beacon.tick()
      @beacon.ticked()
      expect(spy.called).to.be.ok()

    it 'dispatches a "finished" event when the beacon index has reached the total', ->
      spy = sinon.spy @beacon, 'send'
      @beacon.tick()
      @beacon.tick()
      @beacon.ticked()
      expect(spy.calledWith('finished')).to.be.ok()

    it 'calls the "start" method when "is_continuous" is set', ->
      spy = sinon.spy @custom, 'start'
      @custom.ticked()
      expect(spy.called).to.be.ok()


  describe '#send', ->
    it 'send a tick event', ->
      @beacon.dispatcher.on('beacon:ticked', => @noop arguments...)
      spy = sinon.spy @, 'noop'
      @beacon.tick()
      expect(spy.called).to.be.ok()


  describe '#clear', ->
    it 'kills the timer when cleared', ->
      @beacon.start()
      expect(@beacon.timer).not.to.be null
      @beacon.tick()
      expect(@beacon.timer).to.be null

