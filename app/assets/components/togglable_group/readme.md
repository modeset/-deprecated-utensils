
# Togglable Group
An extension of `Togglable` for adding, removing and toggling groups of
related elements. These are predominantly used in navigation type
systems. A `TogglableGroup` can function either like radio buttons or
check boxes.

```html
data-bindable="togglable-group"
```

## Usage Examples

<!--~ markup/togglable_group.html.haml -->
```haml
%nav
  %ul#radios.nav.inline(data-bindable="togglable-group" data-target=".radio-li")
    %li.radio-li<
      %a(href="#") Radio 1
    %li.radio-li<
      %a(href="#") Radio 2
    %li.radio-li<
      %a(href="#") Radio 3

%nav(style="margin-top: 1em;")
  %ul#checks.nav.inline(data-bindable="togglable-group" data-behavior="checkbox")
    %li<
      %a(href="#") Checkbox 1
    %li<
      %a(href="#") Checkbox 2
    %li<
      %a(href="#") Checkbox 3

%nav(style="margin-top: 1em;")
  %ul#radios_delay.nav.inline(data-bindable="togglable-group" data-delay="activate: 500, deactivate: 500")
    %li.radio-li<
      %a(href="#") Radio 1 Delay
    %li.radio-li<
      %a(href="#") Radio 2 Delay
    %li.radio-li<
      %a(href="#") Radio 3 Delay
```
<!-- end -->

## Options

Attribute  | Default              | Description
---------- | -------------------- | -------------------------------------------
`target`   | `li`                 | The identifier for looking up child elements to operate on.
`behavior` | `radio`              | Set to `radio` for radio style toggling or `checkbox` for check box style toggling
`activate` | `element` or `index` | If present, this will auto activate the element or index item on initialization

See `Togglable` for remaining options 


## API

### #new
Create a new instance of `TogglableGroup` programatically. Most setup
occurs within `Togglable`. 

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

_Note: this does not call the super's `#toggle` method_

### #activate
Activate can take either an index or element as it's target parameter.
Activating will add the toggle classes to the element. If behavior is
set to `radio`, activate will remove the toggle classes from other
elements within the group.

dispatches the `togglable:activate` event

```coffee
# activate by index
@radio_group.activate(target:1)
@check_group.activate(target:1)

# activate by element
@radio_group.activate(target:$(@radios[1]))
@check_group.activate(target:$(@checks[1]).find('a'))
```

### #deactivate
Deactivate can take either an index or element as it's target parameter.
Deactivating will remove the toggle classes from the element.

dispatches the `togglable:deactivate` event

```coffee
# deactivate by index
@radio_group.deactivate(target:1)
@check_group.deactivate(target:1)

# deactivate by element
@radio_group.deactivate(target:$(@radios[1]))
@check_group.deactivate(target:$(@checks[1]).find('a'))
```

### #dispose
Cleans up any internal references 

```coffee
@radio_group.dispose()
@check_group.dispose()
```

### Requires
- utensil
- bindable
- togglable

`TogglableGroup` is a subclass of `Togglable`.

## Todo
- Handling the options for solo, context/lookup, target/href
  - We are setting the target based on a navigation system,
    but this will need to change for tabs, accordions, etc.. maybe a
    subclass or composition?
- Figure out the `@is_active` value
  - The `@is_active` value from `Togglable` is being set based
    on every click. It's not used by `TogglerGroup`, but may down the
    road. Need to figure out the best way to manage this since we are
    dealing with a group. The alternative could be that `@is_active` be
    set by the state of the `e.target`?

