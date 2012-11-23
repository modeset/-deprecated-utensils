
# Icon Close
Use the close icon to dismiss modals, notifications and other elements.

```sass
@import utensils/icon_close/close
```

## Usage Example
<!--~ markup/close.html.haml -->

###### Notes
- **Pro Tip!** In your markup use `&times;` for the content of the close icon

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `close.sass` is loaded.

Variable                | Default                | Description
----------------------- | ---------------------  | -------------------------------------------
`$close-size`           | `$base-font-size + 6`  | The size of the font
`$close-opacity`        | `0.3`                  | The opacity level in the static state
`$close-opacity-active` | `0.5`                  | The opacity level when hovered or active
`$close-color`          | `black`                | The default color of the `.close` element
`$close-color-inverse`  | `invert($close-color)` | The default color of the `.close.inverse` element
`$close-shadow`         | `$small-drop-lite`     | The text shadow for the `.close` element
`$close-shadow-inverse` | `$small-drop-dark`     | The text shadow for the `.close.inverse` element

