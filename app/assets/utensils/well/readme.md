# Well
Wells are used to contain components and other various elements. Works
great with form layouts.

[<~Example](markup/well.html.haml)


## Style Settings
```sass
@import utensils/well/well
```

To override the default settings, set the variable and it's value
within your `config.sass` file or before `well.sass` is loaded.

Variable         | Default                 | Description
---------------- | ----------------------- | -------------------------------------------
`$well-bgc`      | `$base-bgc`             | The `background-color` for `.well`
`$well-border`   | `$base-border`          | The `border-color` for all wells
`$well-radii`    | `$radii`                | The `border-radius` around wells
`$well-spacing`  | `1.25em`                | The `padding` and `margin-bottom` around wells
`$well-bgc-fill` | `darken($well-bgc, 8%)` | The `background-color` for `.well.fill`

