
# Button Modifiers
A set of modifier classes which can be added to any button, regardless
of their base class,  to adjust various aspects around a button's display
type, sizing, or positioning.

```sass
@import utensils/button_modifiers/button-modifiers
```

## Usage Examples

<!--~ markup/button-modifiers.html.haml -->
```haml
%section.demo(data-target=".btn" data-remove="btn-xsmall btn-small btn-large btn-xlarge")
  %input.btn.standard(type="submit" value="Submit")
  %button.btn.inverse Inverse
  %button.btn.important Important
  %a.btn.success(href="#") Success

%h5(style="margin-top:3em; margin-bottom:1em;") Select to view states
%section.button-toolbar
  %nav.check-demo.button-group(data-bindable="toggle-button-group" data-behavior="checkbox")
    %a.btn(href="#" data-toggle="btn-block") Block
    %a.btn(href="#" data-toggle="btn-transition") Transition

  %nav.radio-demo.button-group(data-bindable="toggle-button-group")
    %a.btn.active(href="#" data-add="") Normal
    %a.btn(href="#" data-add="btn-xsmall") XS
    %a.btn(href="#" data-add="btn-small") Small
    %a.btn(href="#" data-add="btn-large") Large
    %a.btn(href="#" data-add="btn-xlarge") XL
```
<!-- end -->

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
To override the default settings, set the variable and it's value
within your `config.sass` file or before `button-modifiers.sass` is loaded.

Variable                 | Default              | Description
------------------------ | -------------------- | -------------------------------------------
`$btn-block-spacing`     | `0.5em`              | The `margin-top` between stacked button blocks
`$btn-speed`             | `$speed`             | The duration for `.btn-transition`
`$btn-timing-function`   | `linear`             | The timing function for `.btn-transition`
`$btn-base-font-size`    | `$base-font-size`    | The base `font-size` to use for incrementing button sizes
`$btn-base-line-height`  | `$base-line-height`  | The base `line-height` to use for incrementing button sizes
`$btn-size-multiplier`   | `2`                  | The base multiplier to use for changing a button size

