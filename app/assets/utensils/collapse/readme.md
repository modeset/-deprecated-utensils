# Collapse
Allows toggling of collapsible elements associated with a link or a
navigation system such as an accordion group.

Collapse utilizes either `Toggle` or `ToggleGroup` through composition.

[<~Example](markup/collapse.html.haml)


## Options

Attribute           | Default         | Description
------------------- | --------------- | -------------------------------------------
`namespace`         | `collapse`      | The namespace to use for dispatching events
`dimension`         | `height`        | The property to collapse on
`type`              | `single`        | For multiple collapsible elements, pass `group` as the value
`multiple-activate` | `undefined`     | Searches the `.accordion-group` or `li` for the `activate` attribute and auto activates that item

See `Toggle` or `ToggleGroup` for more options.

If `type` is set to single (the default), `Collapse` will instantiate an
instance of `Toggle` for managing the links state. If `type` is set to
`group`, the `ToggleGroup` behavior is used.


## API
```coffee
#= require utensils/collapse
```

```haml
data-bindable="collapse"
```

### #new
Create a new instance of `Collapse` programatically, typically this
is instantiated through `Bindable`

```coffee
#= require collapse

@collapse_el = $('#single')
@group_el = $('#group_el')

@collapse = new utensils.Collapse @collapse_el
@collapse_group = new utensils.Collapse @group_el
```

### #activate
Activate can take either an index, element or string as it's target
parameter if the `type` is set to `group`. Otherwise, no parameter is
required. Dispatches a `collapse:activated` event.

```coffee
# activate on a non-group collapse
@collapse.activate()

# activate by index on a group
@collapse_group.activate 1

# activate by element on a group
@collapse_group.activate @group_el.find 'li:nth-child(2)'
```

### #deactivate
Deactivate can take either an index, element or string as it's target
parameter if the `type` is set to `group`. Otherwise, no parameter is
required. Dispatches a `collapse:deactivated` event.

```coffee
# deactivate on a non-group collapse
@collapse.deactivate()

# deactivate by index on a group
@collapse_group.deactivate 1

# deactivate by element on a group
@collapse_group.deactivate @group_el.find 'li:nth-child(2)'
```

### #dispose
Cleans up any internal references

```coffee
@collapse.dispose()
@collapse_group.dispose()
```

When a panel (the target with `.collapse`) is activated or deactivated
it dispatches events around it's state.

Event             | Description
----------------- | -------------------------------------------
`collapse:show`   | The start event before the transition occurs and the element is hidden
`collapse:shown`  | After the transition occurs and the element is showing
`collapse:hide`   | The start event before the transition occurs and the element is showing
`collapse:hidden` | After the transition occurs and the element is hidden


### Requires
```coffee
utensils/utensils
utensils/bindable
utensils/detect
utensils/toggle
utensils/toggle_group
```


## Style Settings
```sass
@import utensils/collapse
```

To override the default settings, set the variable and it's value
within your `config.sass` file or before `collapse.sass` is loaded.

Variable                    | Default              | Description
--------------------------- | -------------------- | -------------------------------------------
`$collapse-duration`        | `$speed`             | Duration to collapse or expand the element
`$collapse-timing-function` | `$ease-in-out-quart` | Timing equation to fade the element


## Todo
- Should be able to collapse around the `width` property

