
# Togglable Group
An extension of `Togglable` for adding, removing and toggling groups of
related elements. These are predominantly used in navigation type
systems. A `TogglableGroup` can function either like radio buttons or
check boxes.

Adding `related` attributes to a `ToggableGroup` allows navigation
systems to control other components such as tabs, pills and accordions.

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
%hr
%nav(style="margin-top: 1em;")
  %ul#checks.nav.inline(data-bindable="togglable-group" data-behavior="checkbox")
    %li<
      %a(href="#") Checkbox 1
    %li<
      %a(href="#") Checkbox 2
    %li<
      %a(href="#") Checkbox 3
%hr
%nav(style="margin-top: 1em;")
  %ul#radios_delay.nav.inline(data-bindable="togglable-group" data-delay="activate: 500, deactivate: 500")
    %li.radio-li<
      %a(href="#") Radio 1 Delay
    %li.radio-li<
      %a(href="#") Radio 2 Delay
    %li.radio-li<
      %a(href="#") Radio 3 Delay

%hr
%nav(style="margin-top: 2em;")
  %ul#related_radio_nav.nav.inline(data-bindable="togglable-group" data-related="#related_radio_content .tab-pane")
    %li.active<
      %a(href="#related_rone") Related Radio 1
    %li<
      %a(href="#" data-target="#related_rtwo") Related Radio 2
    %li<
      %a(href="#related_rthree") Related Radio 3

%section#related_radio_content.tabable-content(style="margin-top:1.25em;")
  %article.tab-pane.active#related_rone
    %p Related radio content <span class="decal important">one</span>
  %article.tab-pane#related_rtwo
    %p Related radio content <span class="decal success">two</span>
  %article.tab-pane#related_rthree
    %p Related radio content <span class="decal danger">three</span>

%hr
%nav(style="margin-top: 2em;")
  %ul#related_check_nav.nav.inline(data-bindable="togglable-group" data-behavior="checkbox" data-related="#related_check_content .tab-pane")
    %li.active<
      %a(href="#related_cone") Related Check 1
    %li<
      %a(href="#" data-target="#related_ctwo") Related Check 2
    %li<
      %a(href="#related_cthree") Related Check 3

%section#related_check_content.tabable-content(style="margin-top:1.25em;")
  %article.tab-pane.active#related_cone
    %p Related checkbox content <span class="decal important">one</span>
  %article.tab-pane#related_ctwo
    %p Related checkbox content <span class="decal success">two</span>
  %article.tab-pane#related_cthree
    %p Related checkbox content <span class="decal danger">three</span>
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
- Figure out the `@is_active` value
  - The `@is_active` value from `Togglable` is being set based
    on every click. It's not used by `TogglerGroup`, but may down the
    road. Need to figure out the best way to manage this since we are
    dealing with a group. The alternative could be that `@is_active` be
    set by the state of the `e.target`?
- Clean up the fixture so it doesn't rely on tabs and is more generic
- Should we keep and index of who is selected (see the `Menu` component)

