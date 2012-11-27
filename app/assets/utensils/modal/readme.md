
# Modal
Base styles and behaviors for displaying elements within a modal window.
Modals automatically create a backdrop which blocks user interaction
from other elements while the modal is shown. Modals can be disengaged
by including buttons with the `data-dismiss="modal"` attribute, clicking
on the backdrop or triggering the `escape` key.

Styles are not included for the contents of a modal (rather just the
modal and backdrop itself). This is better suited for other components
or custom layouts within the application.

```sass
@import utensils/modal/modal
```

```html
data-bindable="modal"
```

## Usage Example
[<~Example](markup/modal.html.haml)


## Options

Attribute   | Default     | Description
----------- | ----------- | -------------------------------------------
`namespace` | `modal`     | The namespace to use for dispatching events
`keyboard`  | `true`      | Whether to allow the `escape` key to close the modal
`activate`  | `undefined` | Allows the modal to activate on load
`href`      | _none_      | DOM element `id` for the contents of the `Modal`

See `Triggerable` for other options

### Referencing DOM elements
The `modal` trigger element needs to reference an element within the DOM
via an `id`. The target element can live either as the `href` or
`target` attribute. By default, any elements with the `.modal` class are
set to `display:none`.


## API

### #new
Create a new instance of `Modal` programmatically. Normally this is
handled through `Bindable`.

```coffee
#= require modal

@el = $('#modal')
@modal = new utensils.Modal(@el, {target:'#my_modal'})
```

### #toggle
Typically called through user input, but can be triggered by the
elements toggle event.

```coffee
@el.trigger('click')
```

### #activate
Show the modal

```coffee
@modal.activate()
```

### #deactivate
Removes the modal

```coffee
@modal.deactivate()
```

### #dispose
Remove the modal behavior

```coffee
@modal.dispose()
```

### Requires
- `utensils/utensils`
- `utensils/bindable`
- `utensils/triggerable`
- `utensils/detect`

`Modal` utilizes `Triggerable` via composition.


## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `modal.sass` is loaded.

Variable                  | Default                          | Description
------------------------- | -------------------------------- | -------------------------------------------
`$modal-bgc`              | `$base-bgc`                      | The `background-color` of the `.modal-backdrop`
`$modal-opacity-in`       | `0.8`                            | The `opacity` value of the `.modal-backdrop`
`$modal-width`            | `($base-width - 200) * 1px`      | The `width` of the modal
`$modal-height`           | `round($modal-width * (9 / 16))` | The `max-height` of the modal
`$modal-offset-top`       | `round($modal-height * 0.5)`     | The `margin-top` of the modal
`$modal-offset-left`      | `round($modal-width * 0.5)`      | The `margin-left` of the modal

Modal sizing is setup in a 16:9 ratio and centered within the browser
based of the `$base-width` of the site. Specific media queries should be
setup to handle various sizing based on the device's viewport.


###### Warning
- **Heads Up!** The configuration file needs to define the
  `$zindex-modal` and `$zindex-modal-backdrop` values before this file is
  imported, this is done to keep managing `z-index` mappings in one
  place.

