#= require utensils/timeslot

describe 'Timeslot', ->

  beforeEach ->
    @timeslot = new utensils.Timeslot()
    @num_like = 100
    @array_like = "200, 300"
    @hash_like = "{activate:400, deactivate:500}"
    @hash_like_cs = "activate:600, deactivate: 700"
    @hash_like_custom = "show:600, hide: 700"
    @hash_like_reversed = "off:100, on: 1000"


  describe '#constructor', ->
    it 'constructs the class with parameters', ->
      expect(@timeslot).not.to.be undefined


  describe '#getTimeslotFromData', ->
    it 'returns 0, 0 when null or undefined', ->
      expect(@timeslot.getTimeslotFromData()).to.eql(activate:0, deactivate:0)
      expect(@timeslot.getTimeslotFromData(null)).to.eql(activate:0, deactivate:0)

    it 'returns 100 for both activate and deactivate from a number', ->
      expect(@timeslot.getTimeslotFromData(@num_like)).to.eql(activate:100, deactivate:100)

    it 'returns the hash when passed an array like string', ->
      expect(@timeslot.getTimeslotFromData(@array_like)).to.eql(activate:200, deactivate:300)

    it 'returns the hash when passed a hash like string', ->
      expect(@timeslot.getTimeslotFromData(@hash_like)).to.eql(activate:400, deactivate:500)

    it 'returns the hash when passed a coffeescript hash like string', ->
      expect(@timeslot.getTimeslotFromData(@hash_like_cs)).to.eql(activate:600, deactivate:700)

    it 'overrides the returned keys when passed as a parameter', ->
      times = @timeslot.getTimeslotFromData(@num_like, 'show', 'hide')
      expect(times).to.eql(show:100, hide:100, activate:100, deactivate:100)

    it 'overrides the returned keys when set as a hash', ->
      times = @timeslot.getTimeslotFromData(@hash_like_custom)
      expect(times).to.eql(show:600, hide:700, activate:600, deactivate:700)

    it 'figures out the right values if they are not in order', ->
      times = @timeslot.getTimeslotFromData(@hash_like_reversed)
      expect(times).to.eql(off:100, on:1000, deactivate:100, activate:1000)


  describe '#getClosestMatch', ->
    it 'returns activate from a few common test cases', ->
      expect(@timeslot.getClosestMatch('shown')).to.eql('activate')
      expect(@timeslot.getClosestMatch('on')).to.eql('activate')
      expect(@timeslot.getClosestMatch('start')).to.eql('activate')

    it 'returns deactivate from a few common test cases', ->
      expect(@timeslot.getClosestMatch('hide')).to.eql('deactivate')
      expect(@timeslot.getClosestMatch('off')).to.eql('deactivate')
      expect(@timeslot.getClosestMatch('disable')).to.eql('deactivate')

    it 'returns activate from a missed test case relying on an index', ->
      expect(@timeslot.getClosestMatch('mansfield', 0)).to.eql('activate')

    it 'returns deactivate from a missed test case relying on an index', ->
      expect(@timeslot.getClosestMatch('mansfield', 1)).to.eql('deactivate')

