
# Timeslot
Utility class for finding and normalizing time slots.


## API

### #new
Create a new instance of `Timeslot`, typically used compositionally. 

```coffee
#= require timeslot

@timeslot = new utensil.Timeslot()
```

### #getTimeslotFromData
Returns an object from a hash like, array like or number like string. The object
assumes delay style timeouts with an `activate` and `deactivate` values.

```coffee
@timeslot.getTimeslotFromData('100')
# returns: {activate:100, deactivate:100}

@timeslot.getTimeslotFromData('200', 'show', 'hide')
# returns: {activate:200, deactivate:200, show:200, hide:200}

@timeslot.getTimeslotFromData('200, 300')
# returns: {activate:200, deactivate:300}, the first number is always assumed as `activate`

@timeslot.getTimeslotFromData('{activate:400, deactivate:500}')
# returns: {activate:400, deactivate:500}

@timeslot.getTimeslotFromData('activate:600, deactivate: 700')
# returns: {activate:600, deactivate:700}

@timeslot.getTimeslotFromData('show:600, hide: 700')
# returns: {activate:600, deactivate:700, show:600, hide:700}

@timeslot.getTimeslotFromData('off:100, on: 1000')
# returns: {activate:1000, deactivate:100, on:1000, off:100}
```

If slot names are not `activate` or `deactivate` an attempt is made to
find a match from common terms. If this is the case, those common terms
are returned along with the typical `activate` and `deactivate` terms.


### #getClosestMatch
Attempts to find the closest match for `activate` and `deactivate`
against a set of regular expressions.

```coffee
#= require timeslot

@timeslot.getClosestMatch('on')
# returns: 'activate'

@timeslot.getClosestMatch('hide')
# returns: 'deactivate'
```

### Requires
- `utensil`


## Todo
- The `#getTimeslotFromData` method is pretty specific, could use a
  some love and abstraction
- The regular expression matchers for `activate` and `deactivate` are
  pretty basic at the moment, could use a little tuning

