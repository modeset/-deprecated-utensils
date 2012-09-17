
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
%nav.radio-demo.button-group(data-bindable="togglable-group" data-target=".btn")
  %a.btn.active(href="#" data-add="south") Caret (South)
  %a.btn(href="#" data-add="north") North
  %a.btn(href="#" data-add="east") East
  %a.btn(href="#" data-add="west") West
```
<!-- end -->

## Usage Example

There is another caret modifier for `caret.caret-center` which is used
in split drop down menus.

Caret's are positioned to align with one another, most likely they will
need some sort of offset based on the component they are paired with.

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `caret.sass` is loaded.

Variable       | Default       | Description
-------------- | ------------- | -------------------------------------------
`$caret-size`  | `6px`         | The `border-width` (size) of the caret
`$caret-color` | `$link-color` | The base `border-color` of the caret

