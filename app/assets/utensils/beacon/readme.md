# Beacon
Triggers an event based on a passage of time via a `setTimeout`.


## Options
Beacon accepts 2 arguments, a `@dispatcher` element  and a `@data`
object. The `@data` object defaults to the following: 

Attribute    | Default      | Description
------------ | ------------ | -------------------------------------------
`index`      | `0`          | The initial starting position
`total`      | `1`          | The number of times a beacon can dispatch it's events
`duration`   | `1000`       | The duration of the `setTimeout`
`continuous` | `false`      | Whether to recursively create the `setTimeout`

`Beacon` will automatically dispose of internals and stop dispatching
events once the `index` value is equal to the `total` value.


## API

### #new
Create a new instance of `Beacon`, typically used via an instance. 

```coffee
#= require utensils/beacon
@beacon = new utensils.Beacon @el, {total: 5, duration: 500, continuous: true}
```

### #start
Starts the beacon and dispatches a `beacon:started` event.

```coffee
@beacon.start()
```

### #pause
Pauses the beacon and dispatches a `beacon:paused` event.

```coffee
@beacon.pause()
```

### #stop
Stops the beacon, resets the `index` to it's initial value and dispatches a `beacon:stopped` event.

```coffee
@beacon.stop()
```

### #tick
Manually trigger the `beacon:ticked` event and increment the `index`
value. This is called after a `beacon` has been started and completed
it's timeout. If set to `continuous` this will be triggered until the
`index` is equal to the `total`.

```coffee
@beacon.tick()
```

### #dispose
Clean up the `beacon` instance and remove the event triggers created on
the `@dispatcher`.

```coffee
@beacon.dispose()
```

Once the `index` is equal to the `total`, a `beacon:finished` event
will be triggered. It's up to the instance that created the `beacon` to
either call `dispose` or reset the `index`.

All events triggered, pass a `data` object consisting of the `index` and
it's current value and the `total` number of ticks.

