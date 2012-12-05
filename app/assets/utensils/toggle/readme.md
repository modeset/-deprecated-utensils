# Toggle
Base class for adding, removing and toggling classes on a single
element.

`Toggle` utilizes `Triggerable` through composition.

[<~Example](markup/toggle.html.haml)


## Options

Attribute   | Default      | Description
----------- | ------------ | -------------------------------------------
`namespace` | `toggle`     | The namespace to use for dispatching events
`toggle`    | `active`     | The class(es) to toggle when triggered
`activate`  | `false`      | If present, this will auto activate the element

See `Triggerable` for more options.


## API
```coffee
#= require utensils/toggle
```

```haml
data-bindable="toggle"
```

### #new
Create a new instance of `Toggle` programatically, typically this is
instantiated through `Bindable`.

```coffee
#= require toggle

@el = $('#toggle')
@toggle = new utensils.Toggle @el, {toggle: 'fade active', trigger: 'hover'}
```

### #toggle
Typically called through user input, but can be triggered by the
elements toggle event.

```coffee
@el.trigger 'click'
```

### #activate
Add the toggle classes to the targets. Dispatches a `toggle:activated`
event.

```coffee
@toggle.activate()
```

### #deactivate
Removes the toggle classes from the targets. Dispatches a
`toggle:deactivated` event.

```coffee
@toggle.deactivate()
```

### #dispose
Cleans up any internal references.

```coffee
@toggle.dispose()
```

### Requires
```coffee
utensils/utensils
utensils/bindable
utensils/triggerable
```

Any events dispatched from `Toggle` contain the `event` property as the
first parameter and the `@el` as the second parameter. This is done to
ensure scope is transferred correctly and for a quicker lookup from the
class utilizing a `Toggle` instance.

