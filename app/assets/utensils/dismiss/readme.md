
# Dismiss
Remove an element from the DOM.

```html
data-bindable="dismiss"
```

## Usage Example
<!--~ markup/dismiss.html.haml -->


## Options

Attribute      | Default                  | Description
-------------- | ------------------------ | -------------------------------------------
`namespace`    | `dismiss`                | The namespace to use for dispatching events
`parents`      | `.notification,.dismiss` | The default classes to search for if an `href` or `target` is not defined
`auto-dismiss` | `undefined`              | Pass the time in milliseconds and the element will automatically remove itself from the DOM.

See `Triggerable` for other options

###### Notes
- **Pro Tip!** If the target element has the class `in` it will remove
  this class first and wait for the transition to finish

## API

### #new
Create a new instance of `Dismiss` programmatically. Normally this is
handled through `Bindable`.

```coffee
#= require dismiss

@el = $('#dismiss')
@dismiss = new utensils.Dismiss(@el, {target: @el.find('.notification')})
```

### #remove
Removes the element from the DOM, if the `in` class is on the target, it
will animate out and call `#removeTarget`.

##### dispatches:
- `dismiss:dismiss`

### #removeTarget
Removes the element from the DOM immediately.

##### dispatches:
- `dismiss:dismissed`

### #dispose
Cleans up all listeners, but does not remove the element from the DOM.

### Requires
- `utesnils/utensils`
- `utesnils/bindable`
- `utesnils/triggerable`
- `utesnils/detect`

`Dismiss` utilizes `Triggerable` via composition.

