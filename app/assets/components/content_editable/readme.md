
# Content Editable
Apply the attribute `contenteditable="true"` to a given element,
allows the user to change it's contents.

```sass
@import utensils/components/content_editable/content-editable
```

## Usage Examples

```haml
%h2(contenteditable="true") Edit Title
%p(contenteditable="true") Edit Description
```

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `content-editable.sass` is loaded.

Attribute              | Default       | Description
---------------------- | ------------- | -------------------------------------------
`$editable-bgc`        | `$off-white`  | The `background-color` while the region is focused
`$editable-border`     | `$blue`       | The `border-color` while the region is hovered
`$editable-focus-glow` | `$focus-glow` | The glow while the region is focused

