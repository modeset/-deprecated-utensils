
# Icon Caret
Carets are used as icons for links and are typically wrapped in `span`
elements. Carets are similar to the `+arrow` mixin, where in the `+arrow`
mixin is used for `:before` and `:after` pseudo elements and carets are
embedded directly in the markup.

```sass
@import utensils/components/icon_caret/caret
```

## Usage Example

Caret                             | Markup
--------------------------------- | --------------------------
<span class="caret"></span>       | `%span.caret` or `%span.caret.south`
<span class="caret north"></span> | `%span.caret.north`
<span class="caret east"></span>  | `%span.caret.east`
<span class="caret west"></span>  | `%span.caret.west`

There is another caret modifier for `caret.caret-center` which is used
in split drop down menus.

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `caret.sass` is loaded.

Attribute      | Default       | Description
-------------- | ------------- | -------------------------------------------
`$caret-width` | `4px`         | The `border-width` (size) of the caret
`$caret-color` | `$link-color` | The base `border-color` of the caret

