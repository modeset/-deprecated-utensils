
# Well
Wells are used to contain components and other various elements.

```sass
@import roos/components/well/well
```

## Usage Example

```haml
.well .well
.well.lite .well.lite
.well.dark .well.dark
```

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `well.sass` is loaded.

Attribute            | Default               | Description
-------------------- | --------------------- | -------------------------------------------
`$well-border-color` | `invert($body-color)` | The default border color for all wells
`$well-radii`        | `$radii`              | The default border radius around wells
`$well-spacing`      | `1.25em`              | The default padding and spacing around wells
`$well-bgc`          | `transparent`         | The default background of a `.well` element
`$well-lite-bgc`     | `$off-white`          | The default background of a `.well.lite` element
`$well-dark-bgc`     | `$off-grey`           | The default background of a `.well.dark` element

