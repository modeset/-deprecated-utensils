
# Toggle Button Group
Base class for adding, removing and toggling classes on a button group
of elements. These are predominantly used in button group type systems.
A `ToggleButtonGroup` can function either like radio buttons or check
boxes.

`ToggleButtonGroup` is an extension of `ToggleGroup`.

```html
data-bindable="toggle-button-group"
```

## Usage Example

<!--~ markup/toggle_button_group.html.haml -->
```haml
%h5(style="margin-bottom:1em;") Button Toolbar (radio)
%section#toggle_button_group_radios.button-toolbar(data-bindable="toggle-button-group" role="navigation")
  %nav.button-group
    %button.btn 1
    %button.btn 2
    %button.btn 3
  %nav.button-group
    %button.btn.active 4
  %nav.button-group
    %button.btn 5
    %button.btn 6
    %button.btn 7

%h5(style="margin-top:3em; margin-bottom:1em;") Button Group (checkbox)
%nav#toggle_button_group_checks.button-group(data-bindable="toggle-button-group" data-behavior="checkbox" data-target=".btn" role="navigation")
  %a.btn(href="#") Left
  %a.btn.active(href="#") Middle 1
  %a.btn(href="#") Middle 2
  %a.btn(href="#") Right
```
<!-- end -->

## Options

Attribute   | Default               | Description
----------- | --------------------- | -------------------------------------------
`namespace` | `toggle_button_group` | The namespace to use for dispatching events
`target`    | `a,button`            | The identifier for looking up child elements to operate on.

See `ToggleGroup` and `Triggerable` for more options.


## API

### #new
Create a new instance of `ToggleButtonGroup` programatically, typically
this is instantiated through `Bindable`

```coffee
#= require toggle_button_group

@radios = $('#radios')
@checks = $('#checks')

@radio_group = new utensils.ToggleButtonGroup(radios, {behavior: 'radio'})
@check_group = new utensils.ToggleButtonGroup(checks, {behavior: 'checkbox'})
```

### #activate
Activate can take either an index or element as it's target parameter.
Activating will add the toggle classes to the element. If behavior is
set to `radio`, activate will remove the toggle classes from other
elements within the group.

##### dispatches:
- `toggle_button_group:activated`

```coffee
# activate by index
@radio_group.activate(1)
@check_group.activate(1)

# activate by element
@radio_group.activate($(@radios[1]))
@check_group.activate($(@checks[1]))
```

### #deactivate
Deactivate can take either an index or element as it's target parameter.
Deactivating will remove the toggle classes from the element.

##### dispatches:
- `toggle_button_group:deactivated`

```coffee
# deactivate by index
@radio_group.deactivate(1)
@check_group.deactivate(1)

# deactivate by element
@radio_group.deactivate($(@radios[1]))
@check_group.deactivate($(@checks[1]))
```

### #dispose
Cleans up any internal references 

```coffee
@radio_group.dispose()
@check_group.dispose()
```

### Requires
- `utensils/utensils`
- `utensils/bindable`
- `utensils/toggle_group`

Any events dispatched from `ToggleButtonGroup` contain the `event`
property as the first parameter and the `activator/deactivator` as the
second parameter. This is done to ensure scope is transferred correctly
and for a quicker lookup from the class utilizing a `ToggleButtonGroup`
instance.

