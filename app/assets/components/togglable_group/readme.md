
# Togglable Group
An extension of `Togglable` for adding, removing and toggling groups of related elements. These are predominantly used in navigation type systems. A togglable group can function either like radio buttons or check boxes.

```html
data-bindable="togglable-group"
```

## Usage Examples

<!--~ markup/togglable_group.html.haml -->
```haml
%nav
  %ul#radios.nav.inline(data-bindable="togglable-group" data-target=".radio-li")
    %li.radio-li
      %a(href="#") Radio 1
    %li.radio-li
      %a(href="#") Radio 2
    %li.radio-li
      %a(href="#") Radio 3

%nav(style="margin-top: 2em;")
  %ul#checks.nav.inline(data-bindable="togglable-group" data-behavior="checkbox")
    %li
      %a(href="#") Checkbox 1
    %li
      %a(href="#") Checkbox 2
    %li
      %a(href="#") Checkbox 3
```
<!-- end -->

## Options

Attribute  | Default              | Description
---------- | -------------------- | -------------------------------------------
`target`   | `li`                 | The identifier for looking up child elements to operate on.
`behavior` | `radio`              | Set to `radio` for radio style toggling or `checkbox` for check box style toggling
`activate` | `element` or `index` | If present, this will auto activate the element or index item on initialization

_See `Togglable` for other options_  


## API

### #new
Create a new instance of `TogglableGroup` programatically. Normally this is
handled through `Bindable`. Most setup occurs within `Togglable`. 

```coffee
#= require togglable_group

@radios = $('#radios')
@checks = $('#checks')

@radio_group = new utensil.TogglableGroup(radios, {behavior: 'radio'})
@check_group = new utensil.TogglableGroup(checks, {behavior: 'checkbox'})
```

### #toggle
This is normally handled through events, but you can always trigger the
element's toggle event. Toggling changes the state on the current triggered
element, if the group has `radio` behavior, it will deactivate all other
elements within the group.

```coffee
$(@radios[1]).trigger('click')
$(@checks[1]).trigger('click')
```

_Note: this does not call the super's `toggle` method_

### #activate
Activate can take either an index or element as it's parameter.
Activating will add the toggle classes to the element. If behavior is
set to `radio`, activate will remove the toggle classes from other
elements within the group.

```coffee
# activate by index
@radio_group.activate(1)
@check_group.activate(1)

# activate by element
@radio_group.activate($(@radios[1]))
@check_group.activate($(@checks[1]).find('a'))
```

_Note: this does not call the super's `activate` method_

### #deactivate
Deactivate can take either an index or element as it's parameter.
Deactivating will remove the toggle classes from the element.

```coffee
# deactivate by index
@radio_group.deactivate(1)
@check_group.deactivate(1)

# deactivate by element
@radio_group.deactivate($(@radios[1]))
@check_group.deactivate($(@checks[1]).find('a'))
```

_Note: this does not call the super's `deactivate` method_

### Requires
- utensil
- bindable
- togglable

`TogglableGroup` is a subclass of `Togglable`.

