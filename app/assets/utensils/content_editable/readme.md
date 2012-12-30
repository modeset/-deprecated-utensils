# Content Editable
Apply the attribute `contenteditable="true"` to a given element,
allows the user to change it's contents.

[<~Example](markup/content_editable.html.haml)


## Style Settings
```sass
@import utensils/content_editable
```

To override the default settings, set the variable and it's value
within your `config.sass` file or before `content_editable.sass` is loaded.

Variable                 | Default              | Description
------------------------ | -------------------- | -------------------------------------------
`$editable-border-hover` | `$base-border-hover` | The `border-color` while the region is hovered
`$editable-focus-bgc`    | `$focus-bgc`         | The `background-color` while the region is focused
`$editable-focus-glow`   | `$focus-glow`        | The glow while the region is focused

