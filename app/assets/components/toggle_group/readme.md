
# Toggle Group
Base class for adding, removing and toggling classes on a group of
elements. These are predominantly used in navigation type systems. A
`ToggleGroup` can function either like radio buttons or check boxes.

`ToggleGroup` utilizes `Triggerable` through composition.

```html
data-bindable="toggle-group"
```


## Usage Example

<!--~ markup/toggle_group.html.haml -->
```haml
%nav
  %ul#toggle_group_radios.nav.inline(data-bindable="toggle-group" data-target=".radio-li")
    %li.radio-li<
      %a(href="#") Radio 1
    %li.radio-li<
      %a(href="#") Radio 2
    %li.radio-li<
      %a(href="#") Radio 3
    %li.radio-li.group-ignore Not a link

%hr
%nav(style="margin-top: 1em;")
  %ul#toggle_group_checks.nav.inline(data-bindable="toggle-group" data-behavior="checkbox" data-ignore=".text-ignore")
    %li<
      %a(href="#") Checkbox 1
    %li<
      %a(href="#") Checkbox 2
    %li<
      %a(href="#") Checkbox 3
    %li.text-ignore Not a link

%hr
%nav(style="margin-top: 1em;")
  %ul#toggle_group_delay.nav.inline(data-bindable="toggle-group" data-delay="500, 500" data-toggle="active on" data-namespace="toggle_delay")
    %li<
      %a(href="#") Radio Delay 1
    %li<
      %a(href="#") Radio Delay 2
    %li<
      %a(href="#") Radio Delay 3
    %li.group-ignore Not a link
```
<!-- end -->

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

## API

### #new
Create a new instance of `ToggleGroup` programatically, typically this
is instantiated through `Bindable`

```coffee
#= require toggle_group

@radios = $('#radios')
@checks = $('#checks')

@radio_group = new utensil.ToggleGroup(radios, {behavior: 'radio'})
@check_group = new utensil.ToggleGroup(checks, {behavior: 'checkbox'})
```

### #activate
Activate can take either an index or element as it's target parameter.
Activating will add the toggle classes to the element. If behavior is
set to `radio`, activate will remove the toggle classes from other
elements within the group.

##### dispatches:
- `toggle_group:activated`

```coffee
# activate by index
@radio_group.activate(1)
@check_group.activate(1)

# activate by element
@radio_group.activate($(@radios[1]))
@check_group.activate($(@checks[1]).find('a'))
```

### #deactivate
Deactivate can take either an index or element as it's target parameter.
Deactivating will remove the toggle classes from the element.

##### dispatches:
- `toggle_group:deactivated`

```coffee
# deactivate by index
@radio_group.deactivate(1)
@check_group.deactivate(1)

# deactivate by element
@radio_group.deactivate($(@radios[1]))
@check_group.deactivate($(@checks[1]).find('a'))
```

### #dispose
Cleans up any internal references 

```coffee
@radio_group.dispose()
@check_group.dispose()
```

### Requires
- `utensil`
- `bindable`
- `triggerable`

Any events dispatched from `ToggleGroup` contain the `event` property as
the first parameter and the `activator/deactivator` as the second
parameter. This is done to ensure scope is transferred correctly and for
a quicker lookup from the class utilizing a `ToggleGroup` instance.

