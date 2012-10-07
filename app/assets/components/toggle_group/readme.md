
# Toggle Group
Describe this

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

