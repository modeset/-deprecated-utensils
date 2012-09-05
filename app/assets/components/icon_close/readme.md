
# Icon Close
Use the close icon to dismiss modals, notifications and other elements.

```sass
@import roos/components/icon_close/close
```

## Usage Example

<!--~ markup/close.html.haml -->
```haml
.well(style="background-color:#CEE6F6; border-color:#78B9E6;")
  %a.close(href="#") &times;

.well(style="background-color:#333; border-color:#000;")
  %a.close.alt(href="#") &times;
```
<!-- end -->

###### Notes
- **Pro Tip!** In your markup use `&times;` for the content of the close icon

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `close.sass` is loaded.

Attribute               | Default                | Description
----------------------- | ---------------------  | -------------------------------------------
`$close-size`           | `$base-font-size + 6`  | The size of the font
`$close-opacity`        | `0.3`                  | The opacity level in the static state
`$close-opacity-active` | `0.5`                  | The opacity level when hovered or active
`$close-color`          | `$black`               | The default color of the `.close` element
`$close-color-alt`      | `invert($close-color)` | The default color of the `.close.alt` element
`$close-shadow`         | `$small-drop-lite`     | The text shadow for the `.close` element
`$close-shadow-alt`     | `$small-drop-dark`     | The text shadow for the `.close.alt` element

