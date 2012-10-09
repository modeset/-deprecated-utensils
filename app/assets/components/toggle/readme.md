
# Toggle
Describe this

## Usage Example

<!--~ markup/toggle.html.haml -->
```haml
%nav
  %a.btn#toggle_1(href="#" data-bindable="toggle") Toggle Default
  %a.btn#toggle_2(href="#" data-bindable="toggle" data-namespace="hoverable" data-trigger="hover" data-toggle="active on") Toggle Hover
  %a.btn#toggle_3(href="#" data-bindable="toggle" data-namespace="focusable" data-trigger="focus") Toggle Focus
  %a.btn#toggle_4(href="#" data-bindable="toggle" data-delay="500, 500") Toggle Delay
  %a.btn#toggle_5(href="#" data-bindable="toggle" data-activate="true") Toggle Auto Activate
```
<!-- end -->

## Todo
- Test the event dispatching

