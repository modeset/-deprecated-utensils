
# Collapse
Allows toggling of collapsible elements associated with a link or a
navigation system such as an accordion group. 

Collapse utilizes either `Toggle` or `ToggleGroup` through composition.

```sass
@import utensils/collapse/collapse
```

```html
data-bindable="collapse"
```

## Usage Examples

<!--~ markup/collapse.html.haml -->
```haml
:ruby
  @lorem = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
  eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
  veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
  commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit
  esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
  cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est
  laborum."

%a(data-bindable="collapse" href="#collapse_height" role="tab") Single Collapse
%section.collapse#collapse_height(role="tabpanel")
  %article
    -(1..3).each do |i|
      %p=@lorem

%a(data-bindable="collapse" data-target="#collapse_auto" href="#" data-activate="true" role="tab") Single Auto Shown
%section.collapse.in#collapse_auto(role="tabpanel")
  %article
    %p=@lorem


%hr
%nav(role="navigation")
  %ul#collapse_radio(data-bindable="collapse" data-type="group" data-activate="0" role="tablist")
    -(1..3).each do |i|
      %li
        %a(href="#collapse_radio_#{i}" role="tab") Radio Collapse #{i}
        %section.collapse(id="collapse_radio_#{i}" role="tabpanel")
          %article
            %p=@lorem

%hr
%nav(role="navigation")
  %ul#collapse_checkbox(data-bindable="collapse" data-type="group" data-behavior="checkbox" role="tablist")
    -(1..3).each do |i|
      %li
        %a(href="#" data-target="#collapse_check_#{i}" role="tab") Checkbox Collapse #{i}
        %section.collapse(id="collapse_check_#{i}" role="tabpanel")
          %article
            %p=@lorem

%hr
%nav(role="navigation")
  %ul#collapse_external(data-bindable="collapse" data-type="group" data-behavior="checkbox" role="tablist")
    -(1..3).each do |i|
      %li
        %a(href="#collapse_external_#{i}" role="tab") External Checkbox Collapse #{i}

  -(1..3).each do |i|
    %section.collapse(id="collapse_external_#{i}" role="tabpanel")
      %article
        %p<
          %strong Collapse External Pane #{i}
        %p=@lorem
```
<!-- end -->

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

### #new
Create a new instance of `Collapse` programatically, typically this
is instantiated through `Bindable`

```coffee
#= require collapse

@collapse_el = $('#single')
@group_el = $('#group_el')

@collapse = new utensils.Collapse(@collapse_el)
@collapse_group = new utensils.Collapse(@group_el)
```

### #activate
Activate can take either an index, element or string as it's target
parameter if the `type` is set to `group`. Otherwise, no parameter is
required.

##### dispatches:
- `collapse:activated`

```coffee
# activate on a non-group collapse 
@collapse.activate()

# activate by index on a group
@collapse_group.activate(1)

# activate by element on a group
@collapse_group.activate(@group_el.find('li:nth-child(2)'))
```

### #deactivate
Deactivate can take either an index, element or string as it's target
parameter if the `type` is set to `group`. Otherwise, no parameter is
required.

##### dispatches:
- `collapse:deactivated`

```coffee
# deactivate on a non-group collapse 
@collapse.deactivate()

# deactivate by index on a group
@collapse_group.deactivate(1)

# deactivate by element on a group
@collapse_group.deactivate(@group_el.find('li:nth-child(2)'))
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
- `utensils/utensils`
- `utensils/bindable`
- `utensils/detect`
- `utensils/toggle`
- `utensils/toggle_group`


## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `collapse.sass` is loaded.

Variable                    | Default              | Description
--------------------------- | -------------------- | -------------------------------------------
`$collapse-duration`        | `$speed`             | Duration to collapse or expand the element
`$collapse-timing-function` | `$ease-in-out-quart` | Timing equation to fade the element


## Todo
- Should be able to collapse around the `width` property
- A few opportunities to speed up and cache lookups
- The multi method should be moved to TogglerGroup... need to figure out
  the best way to handle this though from instances using composition.

