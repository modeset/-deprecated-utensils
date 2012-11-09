
# Button Group
Use button groups to join multiple buttons together as one composite component.
Build them with a series of `<a>` or `<button>` elements.

Building off of the button group concept, combine multiple `.button-group`
elements under a `.button-toolbar` container to form a navigation system.

```sass
@import utensils/button_group/button_group
```

## Usage Example

<!--~ markup/button_group.html.haml -->
```haml
%h5(style="margin-bottom:1em;") Button Toolbar (radio)
%section.button-toolbar(data-bindable="toggle-button-group" role="navigation")
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
%nav.button-group(data-bindable="toggle-button-group" data-behavior="checkbox" role="navigation")
  %a.btn(href="#") Left
  %a.btn.active(href="#") Middle 1
  %a.btn(href="#") Middle 2
  %a.btn(href="#") Right
```
<!-- end -->

###### Notes
- **Pro Tip!** Button groups and tool bars play great with the `ToggleButtonGroup` behavior

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `button-group.sass` is loaded.

Variable               | Default    | Description
---------------------- | ---------- | -------------------------------------------
`$button-group-offset` | `0.5em`    | The `margin-left` for a `.button-group + .button-group`

## Todo
- Add vertical button groups

