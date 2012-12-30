# Button Modifiers
A set of modifier classes which can be added to any button, regardless
of their base class, to adjust various aspects around a button's display
type, sizing, or positioning.

[<~Example](markup/button_modifiers.html.haml)


## Usage

Modifier Class    | Usage
----------------- | ----------------------------------------------
`.btn-block`      | Displays the button block level filling the container `width`
`.btn-transition` | Adds CSS transitions to a buttons states (uses `transition-property:all`)
`.btn-xsmall`     | Renders the button 4x smaller based on the multiplier number
`.btn-small`      | Renders the button 2x smaller based on the multiplier number
`.btn-large`      | Renders the button 2x bigger based on the multiplier number
`.btn-xlarge`     | Renders the button 4x bigger based on the multiplier number


## Style Settings
```sass
@import utensils/button_modifiers
```

To override the default settings, set the variable and it's value
within your `config.sass` file or before `button_modifiers.sass` is loaded.

Variable                 | Default              | Description
------------------------ | -------------------- | -------------------------------------------
`$btn-block-spacing`     | `0.5em`              | The `margin-top` between stacked button blocks
`$btn-speed`             | `$speed`             | The duration for `.btn-transition`
`$btn-timing-function`   | `linear`             | The timing function for `.btn-transition`
`$btn-base-font-size`    | `$base-font-size`    | The base `font-size` to use for incrementing button sizes
`$btn-base-line-height`  | `$base-line-height`  | The base `line-height` to use for incrementing button sizes
`$btn-size-multiplier`   | `2`                  | The base multiplier to use for changing a button size

