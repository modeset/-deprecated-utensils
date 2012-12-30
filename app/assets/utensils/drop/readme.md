# Drop
Drops are used for displaying a menu within a navigation or button group
system.

Drop's utilize a `visuallyhidden` and `visuallyshown` technique rather
than a `display: none|block` to allow screen readers to still discover
the inner content.

[<~Example](markup/drop.html.haml)


## Options

Attribute   | Default         | Description
----------- | --------------- | -------------------------------------------
`namespace` | `drop`          | The namespace to use for dispatching events
`toggle`    | `active open`   | Overrides `Triggerable's` default of `active`
`placement` | `south`         | Where to position the drop menu in relation to the element: `north`, `south`, `east`, `west`
`keyboard`  | `true`          | Utilize some basic key commands for controlling the menu

**Heads Up!** `Drop` will override it's placement automatically through
`Directional` if it determines the requested position will render the
`menu` outside the viewport.

**You Need This!** The `Drop` link needs to have the class `.drop-toggle` to
help speed up lookups.

See `Triggerable` for other options


## API
```coffee
#= require utensils/drop
```

```haml
data-bindable="drop"
```

### #new
Create a new instance of `Drop` programmatically. Normally this is
handled through `Bindable`.

```coffee
#= require drop

@el = $('#drop')
@drop = new utensils.Drop @el, {placement: 'west'}
```

### #toggle
Typically called through user input, but can be triggered by the
elements toggle event.

```coffee
@el.trigger 'click'
```

### #activate
Show the drop.

```coffee
@drop.activate()
```

### #deactivate
Removes the drop.

```coffee
@drop.deactivate()
```

### #dispose
Remove the drop behavior.

```coffee
@drop.dispose()
```

### Requires
```coffee
utensils/utensils
utensils/bindable
utensils/triggerable
utensils/directional
```

`Drop` utilizes `Triggerable` via composition.


## Style Settings
```sass
@import utensils/drop
```

To override the default settings, set the variable and it's value within
your `config.sass` file or before `drop.sass` is loaded.

Variable               | Default  | Description
---------------------- | -------- | -------------------------------------------
`$drop-menu-min-width` | `160px`  | The `min-width` of the `menu`

Other default styles are set up through either `caret.sass` or
`menu.sass`

_Warning!_ Drop requires the `menu` component for styles.

_Warning!_ The configuration file needs to define the `$zindex-drop`
value before this file is imported, this is done to keep managing
`z-index` mappings in one place.

