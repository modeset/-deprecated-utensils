
# Icon Caret
Carets are used as icons and are typically wrapped in `span` elements.
Carets are similar to the `+arrow` mixin, where in the `+arrow` mixin is
used for `:before` and `:after` pseudo elements and carets are embedded
directly in the markup.

```sass
@import utensils/components/icon_caret/caret
```

## Usage Example

<!--~ markup/caret.html.haml -->
```haml
%nav.demo(data-target="#test_caret" data-remove="north south east west")
  %ul.nav.inline
    %li
      %span.caret.north
    %li
      %span.caret.south
    %li
      %span.caret.east
    %li
      %span.caret.west
    %li(style="margin-left: 5em;")
      %span.caret.transall#test_caret

%h5(style="margin-bottom:1em; margin-top:3em;") Select to spin the caret
%nav.radio-demo.button-group(data-bindable="toggle-group" data-target=".btn")
  %a.btn(href="#" data-add="north") North
  %a.btn.active(href="#" data-add="south") South
  %a.btn(href="#" data-add="east") East
  %a.btn(href="#" data-add="west") West
```
<!-- end -->

Caret's are positioned to align with one another, most likely they will
need some sort of offset based on the component they are paired with.

###### Note
- **Heads Up!** The class `.caret` and `.caret.south` are scoped to the
same styles


## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `caret.sass` is loaded.

Variable              | Default        | Description
--------------------- | -------------  | -------------------------------------------
`$caret-size`         | `6px`          | The `border-width` (size) of the caret
`$caret-color`        | `$link-color`  | The base `border-color` of the caret
`$caret-color-hover`  | `$link-hover`  | The base `border-color` of the caret when hovered
`$caret-color-active` | `$link-active` | The base `border-color` of the caret when active

