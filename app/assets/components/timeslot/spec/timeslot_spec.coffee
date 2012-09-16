
#= require timeslot

describe 'Timeslot', ->

  beforeEach ->
    @timeslot = new utensil.Timeslot()
    @num_like = 100
    @array_like = "200, 300"
    @hash_like = "{activate:400, deactivate:500}"
    @hash_like_cs = "activate:600, deactivate: 700"
    @hash_like_custom = "show:600, hide: 700"
    @hash_like_reversed = "off:100, on: 1000"

  afterEach ->

  describe '#constructor', ->
    it 'constructs the class with parameters', ->
      expect(@timeslot).toBeDefined()

  describe '#getTimeslotFromData', ->
    it 'returns 0, 0 when null or undefined', ->
      expect(@timeslot.getTimeslotFromData()).toEqual(activate:0, deactivate:0)
      expect(@timeslot.getTimeslotFromData(null)).toEqual(activate:0, deactivate:0)

    it 'returns 100 for both activate and deactivate from a number', ->
      expect(@timeslot.getTimeslotFromData(@num_like)).toEqual(activate:100, deactivate:100)

    it 'returns the hash when passed an array like string', ->
      expect(@timeslot.getTimeslotFromData(@array_like)).toEqual(activate:200, deactivate:300)

    it 'returns the hash when passed a hash like string', ->
      expect(@timeslot.getTimeslotFromData(@hash_like)).toEqual(activate:400, deactivate:500)

    it 'returns the hash when passed a coffeescript hash like string', ->
      expect(@timeslot.getTimeslotFromData(@hash_like_cs)).toEqual(activate:600, deactivate:700)

    it 'overrides the returned keys when passed as a parameter', ->
      times = @timeslot.getTimeslotFromData(@num_like, 'show', 'hide')
      expect(times).toEqual(show:100, hide:100, activate:100, deactivate:100)

    it 'overrides the returned keys when set as a hash', ->
      times = @timeslot.getTimeslotFromData(@hash_like_custom)
      expect(times).toEqual(show:600, hide:700, activate:600, deactivate:700)

    it 'figures out the right values if they are not in order', ->
      times = @timeslot.getTimeslotFromData(@hash_like_reversed)
      expect(times).toEqual(off:100, on:1000, deactivate:100, activate:1000)


  describe '#getClosestMatch', ->
    it 'returns activate from a few common test cases', ->
      expect(@timeslot.getClosestMatch('shown')).toEqual('activate')
      expect(@timeslot.getClosestMatch('on')).toEqual('activate')
      expect(@timeslot.getClosestMatch('start')).toEqual('activate')

    it 'returns deactivate from a few common test cases', ->
      expect(@timeslot.getClosestMatch('hide')).toEqual('deactivate')
      expect(@timeslot.getClosestMatch('off')).toEqual('deactivate')
      expect(@timeslot.getClosestMatch('disable')).toEqual('deactivate')

    it 'returns activate from a missed test case relying on an index', ->
      expect(@timeslot.getClosestMatch('mansfield', 0)).toEqual('activate')

    it 'returns deactivate from a missed test case relying on an index', ->
      expect(@timeslot.getClosestMatch('mansfield', 1)).toEqual('deactivate')

