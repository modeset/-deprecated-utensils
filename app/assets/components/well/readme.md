
# Well
Wells are used to contain components and other various elements.

```sass
@import utensils/components/well/well
```

## Usage Example

```haml
.well <code>.well</code>
.well.fill <code>.well.fill</code>
```

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `well.sass` is loaded.

Variable         | Default                 | Description
---------------- | ----------------------- | -------------------------------------------
`$well-border`   | `$base-border`          | The `border-color` for all wells
`$well-bgc`      | `$base-bgc`             | The `background-color` for `.well`
`$well-bgc-fill` | `darken($well-bgc, 8%)` | The `background-color` for `.well.fill`
`$well-radii`    | `$radii`                | The `border-radius` around wells
`$well-spacing`  | `1.25em`                | The `padding` and `margin-bottom` around wells

