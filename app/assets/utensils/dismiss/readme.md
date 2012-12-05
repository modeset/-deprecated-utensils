# Dismiss
Remove an element from the DOM.

[<~Example](markup/dismiss.html.haml)


## Options

Attribute      | Default                  | Description
-------------- | ------------------------ | -------------------------------------------
`namespace`    | `dismiss`                | The namespace to use for dispatching events
`parents`      | `.notification,.dismiss` | The default classes to search for if an `href` or `target` is not defined
`auto-dismiss` | `undefined`              | Pass the time in milliseconds and the element will automatically remove itself from the DOM.

See `Triggerable` for other options

**Pro Tip!** If the target element has the class `in` it will remove
this class first and wait for the transition to finish


## API
```coffee
#= require utensils/dismiss
```

```haml
data-bindable="dismiss"
```

### #new
Create a new instance of `Dismiss` programmatically. Normally this is
handled through `Bindable`.

```coffee
#= require dismiss

@el = $('#dismiss')
@dismiss = new utensils.Dismiss @el, {target: @el.find('.notification')}
```

### #remove
Removes the element from the DOM, if the `in` class is on the target, it
will animate out and call `#removeTarget`. Dispatches a
`dismiss:dismiss` event.

```coffee
@dismiss.remove()
```

### #removeTarget
Removes the element from the DOM immediately. Dispatches a
`dismiss:dismissed` event.

```coffee
@dismiss.removeTarget()
```

### #dispose
Cleans up all listeners, but does not remove the element from the DOM.

```coffee
@dismiss.dispose()
```

### Requires
```coffee
utesnils/utensils
utesnils/bindable
utesnils/triggerable
utesnils/detect
```

`Dismiss` utilizes `Triggerable` via composition.

