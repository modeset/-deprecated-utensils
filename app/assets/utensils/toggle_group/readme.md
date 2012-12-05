# Toggle Group
Base class for adding, removing and toggling classes on a group of
elements. These are predominantly used in navigation type systems. A
`ToggleGroup` can function either like radio buttons or check boxes.

Utilize the `toggle-group` value for most navigation styles that are
`li` based. For `.button-groups` and `.button-toolbar` where links are
flat, use `toggle-button-group` value. See the usage example for more
information.

`ToggleGroup` utilizes `Triggerable` through composition.

[<~Example](markup/toggle_group.html.haml)


## Options

Attribute   | Default               | Description
----------- | --------------------- | -------------------------------------------
`namespace` | `toggle_group`        | The namespace to use for dispatching events
`toggle`    | `active`              | The class(es) to toggle when triggered
`behavior`  | `radio`               | Set to `radio` for radio style toggling or `checkbox` for check box style toggling
`target`    | `li`                  | The identifier for looking up child elements to operate on.
`activate`  | `false`               | If present, this will auto activate the element
`ignore`    | `.group-ignore,.drop` | Elements in the stack to ignore trigger events from

See `Triggerable` for more options.

When specifying a `bindable` as `toggle-button-group`, the default
`target` attribute becomes `a,button` instead of `li`. This can be overridden by
supplying a `data-target` attribute.


## API
```coffee
#= require toggle_group
```

```haml
data-bindable="toggle-group"
data-bindable="toggle-button-group"
```

### #new
Create a new instance of `ToggleGroup` programatically, typically this
is instantiated through `Bindable`

```coffee
#= require toggle_group

@radios = $('#radios')
@checks = $('#checks')

@radio_group = new utensils.ToggleGroup radios, {behavior: 'radio'}
@check_group = new utensils.ToggleGroup checks, {behavior: 'checkbox'}
```

### #activate
Activate can take either an index, string or element as it's target
parameter.  Activating will add the toggle classes to the element. If
behavior is set to `radio`, activate will remove the toggle classes from
other elements within the group. Dispatches a `toggle_group:activated`
event.

```coffee
# activate by index
@radio_group.activate 1
@check_group.activate 1

# activate by string
@radio_group.activate 'li:first'
@check_group.activate 'li:first'

# activate by element
@radio_group.activate @radios.find 'li:first'
@check_group.activate @checks.find 'li:first'
```

### #deactivate
Deactivate can take either an index, string or element as it's target
parameter.  Deactivating will remove the toggle classes from the
element. Dispatches a `toggle_group:activated` event.

```coffee
# deactivate by index
@radio_group.deactivate 1
@check_group.deactivate 1

# deactivate by string
@radio_group.deactivate 'li:first' 
@check_group.deactivate 'li:first' 

# deactivate by element
@radio_group.deactivate @radios.find 'li:first'
@check_group.deactivate @checks.find 'li:first'
```

### #dispose
Cleans up any internal references

```coffee
@radio_group.dispose()
@check_group.dispose()
```

### Requires
```coffee
utensils/utensils
utensils/bindable
utensils/triggerable
```

Any events dispatched from `ToggleGroup` contain the `event` property as
the first parameter and the `activator/deactivator` as the second
parameter. This is done to ensure scope is transferred correctly and for
a quicker lookup from the class utilizing a `ToggleGroup` instance.

