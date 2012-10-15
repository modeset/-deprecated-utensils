
# Triggerable
Base class for handling and dispatching user interactions. `Triggerable`
is used via composition by most components that trigger some sort of
stateful change.

`Triggerable` is not a `Bindable` class and needs to be instantiated via
a class instance.

## Usage
As a class making use of a `Triggerable` instance through composition:

```coffee
#= require triggerable
class utensil.MockClass
  constructor: (@el, @data) ->
    @triggerable = new utensil.Triggerable(@el, @data)
    @triggerable.dispatcher.on('triggerable:activate', => @activated arguments...)
    @triggerable.dispatcher.on('triggerable:deactivate', => @deactivated arguments...)

  toggle: ->
    @triggerable.toggle(target: @el)

  activate: ->
    @triggerable.activate(target: @el)

  deactivate: ->
    @triggerable.deactivate(target: @el)

  dispose: ->
    @removeListeners()
    @triggerable.dispose()
    @triggerable = null

  activated: (e) ->
    # activate some stuff

  deactivated: (e) ->
    # deactivate some stuff
```

## Options

Attribute   | Default       | Description
----------- | ------------- | -------------------------------------------
`namespace` | `triggerable` | The namespace to use for dispatching events
`trigger`   | `click`       | The event to trigger toggle behavior [`click`, `hover`, `focus`, `manual`]
`bubble`    | `false`       | Controls whether an action `preventsDefault`, setting to `true` will allow normal events to bubble
`delay`     | `undefined`   | The amount of time in milliseconds to delay on `activate` and `deactivate`, see the `Timeslot` class for more information

Options are typically passed up through the class instance utilizing
`Triggerable`.


### Trigger Types
The `trigger` attribute is mapped to an object with `on/off` properties
based on the following:

Attribute  | trigger.on => handler     | trigger.off => handler
---------- | ------------------------- | --------------------------------------
"click"    | `click => #toggle`        | `click => #toggle`
"hover"    | `mouseenter => #activate` | `mouseleave => #deactivate`
"focus"    | `focus => #activate`      | `blur => #deactivate`
"manual"   | _none_                    | _none_

The `manual` trigger does not add any listeners, as it's meant to be
called programmatically from another object.

Any other trigger types, not included in this list, map their `on/off`
properties to the given trigger name. They will automatically call the
`#toggle` handler.

### Delays
When `delay` is set, the `#activate` and `#deactivate` methods are
scoped to `#activateWithDelay` and `#deactivateWithDelay`. Classes
utilizing `Triggerable` through composition and a `delay` do not need to
be concerned with this in their own API. Compositional classes should
only rely on the dispatched events from their instance of `Triggerable`.

If one of the delay properties (`activate` or `deactivate`) is `0`, then
the method for that property will not be scoped through the delay
method.


## API

### #new
Create a new instance of `Triggerable` programatically. 

```coffee
#= require triggerable

@triggerable = new utensil.Triggerable(@el, @data)
```

### #toggle
Typically called through user input, but can be triggered by the
elements toggle event.

```coffee
@triggerable.toggle(target: @el)
```

### #activate
Activate a `Triggerable` instance

##### dispatches:
- `triggerable:trigger`
- `triggerable:activate`

```coffee
@triggerable.activate(target: @el)
```

### #deactivate
Deactivate a `Triggerable` instance

##### dispatches:
- `triggerable:trigger`
- `triggerable:deactivate`

```coffee
@triggerable.deactivate(target: @el)
```

### #dispose
Cleans up any internal references 

```coffee
@triggerable.dispose()
@triggerable = null
```

### Requires
- `utensil`
- `timeslot`

An instance of `Triggerable` creates a `@dispatcher` property for
dispatching events. Typically this is just the `@el` but is created for
clarity in access from a compositional class.

Any events dispatched from `Triggerable` contain the `event` property as
the first parameter and the `event.target` as the second parameter. This
is done to ensure scope is transferred correctly and for a quicker
lookup from the class utilizing a `Triggerable` instance.

By default, `Triggerable` allows an `event` to propagate. This can be
shut down by calling on the instance: `@triggerable.stop_propagation =
true`


## Todo
- Can `Triggerable` handle delays around CSS animations?

