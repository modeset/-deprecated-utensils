
# Icon Caret
Carets are used as icons and are typically wrapped in `span` elements.
Carets are similar to the `+arrow` mixin, where in the `+arrow` mixin is
used for `:before` and `:after` pseudo elements and carets are embedded
directly in the markup.

```sass
@import utensils/icon_caret/caret
```

## Usage Example
<!--~ markup/caret.html.haml -->

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

