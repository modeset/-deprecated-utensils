# Pill
Pills are similar to tabs, and follow the same markup structure as other
navigation elements. Pills like other navigation elements require the
`.nav` class for layout. Add `.nav .pill` to a `ul` or `ol` element.

To utilize a drop dead simple version of hiding and showing content, add
the `data-bindable="tab"` along with an `href` attributes pointing to
the related targets panel.

See `Tab` for more information.

[<~Example](markup/pill.html.haml)


## Style Settings
```sass
@import utensils/pill/pill
```

To override the default settings, set the variable and it's value within
your `config.sass` file or before `pill.sass` is loaded.

Variable             | Default            | Description
-------------------- | ------------------ | -------------------------------------------
`$pill-bgc-hover`    | `$base-bgc-hover`  | The `background-color` of the pill component when hovered
`$pill-bgc-active`   | `$base-bgc-active` | The `background-color` of the pill component when active
`$pill-bgc-selected` | `$base-bgc-active` | The `background-color` of the pill component when selected
`$pill-radii`        | `$radii`           | The `border-radius` of the pill link

