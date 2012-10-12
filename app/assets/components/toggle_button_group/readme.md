
# Toggle Button Group
Describe this

## Usage Example

<!--~ markup/toggle_button_group.html.haml -->
```haml
%h5(style="margin-bottom:1em;") Button Toolbar (radio)
%section#toggle_button_group_radios.button-toolbar(data-bindable="toggle-button-group")
  %nav.button-group
    %button.btn(href="#") 1
    %button.btn(href="#") 2
    %button.btn(href="#") 3
  %nav.button-group
    %button.btn.active(href="#") 4
  %nav.button-group
    %button.btn(href="#") 5
    %button.btn(href="#") 6
    %button.btn(href="#") 7

%h5(style="margin-top:3em; margin-bottom:1em;") Button Group (checkbox)
%nav#toggle_button_group_checks.button-group(data-bindable="toggle-button-group" data-behavior="checkbox" data-target=".btn")
  %a.btn(href="#") Left
  %a.btn.active(href="#") Middle 1
  %a.btn(href="#") Middle 2
  %a.btn(href="#") Right
```
<!-- end -->

