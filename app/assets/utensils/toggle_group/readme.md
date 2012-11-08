
# Toggle Group
Base class for adding, removing and toggling classes on a group of
elements. These are predominantly used in navigation type systems. A
`ToggleGroup` can function either like radio buttons or check boxes.

`ToggleGroup` utilizes `Triggerable` through composition.

```html
data-bindable="toggle-group"
data-bindable="toggle-button-group"
```

Utilize the `toggle-group` value for most navigation styles that are
`li` based. For `.button-groups` and `.button-toolbar` where links are
flat, use `toggle-button-group` value. See the usage example for more
information.

## Usage Example

<!--~ markup/toggle_group.html.haml -->
```haml
%nav(role="navigation")
  %ul#toggle_group_radios.nav.inline(data-bindable="toggle-group" data-target=".radio-li")
    %li.radio-li<
      %a(href="#") Radio 1
    %li.radio-li<
      %a(href="#") Radio 2
    %li.radio-li<
      %a(href="#") Radio 3
    %li.radio-li.group-ignore Not a link

%hr
%nav(role="navigtion")
  %ul#toggle_group_checks.nav.inline(data-bindable="toggle-group" data-behavior="checkbox" data-ignore=".text-ignore")
    %li<
      %a(href="#") Checkbox 1
    %li<
      %a(href="#") Checkbox 2
    %li<
      %a(href="#") Checkbox 3
    %li.text-ignore Not a link

%hr
%nav(role="navigation")
  %ul#toggle_group_delay.nav.inline(data-bindable="toggle-group" data-delay="500, 500" data-toggle="active on" data-namespace="toggle_delay")
    %li<
      %a(href="#") Radio Delay 1
    %li<
      %a(href="#") Radio Delay 2
    %li<
      %a(href="#") Radio Delay 3
    %li.group-ignore Not a link

%hr
%nav(role="navigtion")
  %ul#toggle_group_spans.nav.inline(data-bindable="toggle-group" data-behavior="checkbox")
    %li<
      %a(href="#") Checkbox 1 <span>I'm a span</span>
    %li<
      %a(href="#") Checkbox 2 <span>I'm a span</span>
    %li<
      %a(href="#") Checkbox 3 <span>I'm a span</span>

%hr
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

%hr
%nav#toggle_button_group_checks.button-group(data-bindable="toggle-button-group" data-behavior="checkbox" data-target=".btn" role="navigation")
  %a.btn(href="#") Left <span>Span</span>
  %a.btn.active(href="#") Middle 1
  %a.btn(href="#") Middle 2
  %a.btn(href="#") Right
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

When specifying a `bindable` as `toggle-button-group`, the default
`target` attribute becomes `a,button` instead of `li`. This can be overridden by
supplying a `data-target` attribute.


## API

### #new
Create a new instance of `ToggleGroup` programatically, typically this
is instantiated through `Bindable`

```coffee
#= require toggle_group

@radios = $('#radios')
@checks = $('#checks')

@radio_group = new utensils.ToggleGroup(radios, {behavior: 'radio'})
@check_group = new utensils.ToggleGroup(checks, {behavior: 'checkbox'})
```

### #activate
Activate can take either an index, string or element as it's target
parameter.  Activating will add the toggle classes to the element. If
behavior is set to `radio`, activate will remove the toggle classes from
other elements within the group.

##### dispatches:
- `toggle_group:activated`

```coffee
# activate by index
@radio_group.activate(1)
@check_group.activate(1)

# activate by string
@radio_group.activate('li:first')
@check_group.activate('li:first')

# activate by element
@radio_group.activate(@radios.find('li:first'))
@check_group.activate(@checks.find('li:first'))
```

### #deactivate
Deactivate can take either an index, string or element as it's target
parameter.  Deactivating will remove the toggle classes from the
element.

##### dispatches:
- `toggle_group:deactivated`

```coffee
# deactivate by index
@radio_group.deactivate(1)
@check_group.deactivate(1)

# deactivate by string
@radio_group.deactivate('li:first')
@check_group.deactivate('li:first')

# deactivate by element
@radio_group.deactivate(@radios.find('li:first'))
@check_group.deactivate(@checks.find('li:first'))
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
- `utensils/triggerable`

Any events dispatched from `ToggleGroup` contain the `event` property as
the first parameter and the `activator/deactivator` as the second
parameter. This is done to ensure scope is transferred correctly and for
a quicker lookup from the class utilizing a `ToggleGroup` instance.

