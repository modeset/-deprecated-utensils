
# Button Simple
A simple button created via a mixin or through extension of
placeholders. Simple button does not create any classes within the
style sheet. 

The placeholders automatically build states for info, important, success,
warning, danger and primary.

```sass
@import roos/components/button_simple/simple_button
```

## Usage Examples

```haml
%section.simple-btn-demo
  %button.btn Default
  %button.btn.info Info
  %button.btn.important Important
  %button.btn.success Success
  %button.btn.warning Warning
  %button.btn.danger Danger
  %button.btn.primary Primary
```

The simple-button class can be applied to `<a>`, `<button>` and `<input>` elements.

```haml
%section.simple-btn-demo
  %a.btn(href="#") Link
  %button.btn(type="submit") Button
  %input.btn(type="button" value="Input")
  %input.btn(type="submit" value="Submit")
```


## Options
Simple button contains 2 mixins. Use the `simple-button` mixin for generating
the base class and the `simple-button-override` for modifiers of the
base class.

**Mixin:** `simple-button` **parameters (in order)**

Parameter          | Default          | Description
------------------ | ---------------- | -------------------------------------------
`$bg`              | _none_           | This is a required parameter
`$color`           | `#fff`           | The text `color`
`$hover-percent`   | `10%`            | The percentage to darken the `background-color` on hover
`$active-percent`  | `15%`            | The percentage to darken the `background-color` on press and `.active`
`$border-percent`  | `30%`            | The percentage to darken the `border-color` against `$bg`
`$padding`         | `0.4em 0.7em`    | The `padding` within the button
`$radii`           | `$radii`         | The button's `border-radius`


**Mixin:** `simple-button-override` **parameters (in order)**

Parameter          | Default          | Description
------------------ | ---------------- | -------------------------------------------
`$bg`              | _none_           | This is a required parameter
`$color`           | `#fff`           | The text `color` to override from the base button
`$hover-percent`   | `10%`            | The percentage to darken the `background-color` on hover
`$active-percent`  | `12.5%`          | The percentage to darken the `background-color` on press and `.active`
`$border-percent`  | `15%`            | The percentage to darken the `border-color` against `$bg`


## Usage
To use as a mixin, add the following within a projects `.sass` file:

```sass
.btn
  +simple-button($standard, #666)
  &.info
    +simple-button-override($info, $white)
  &.important
    +simple-button-override($important, $white)
  &.success
    +simple-button-override($success, $white)
  &.warning
    +simple-button-override($warning, $white)
  &.danger
    +simple-button-override($danger, $white)
  &.primary
    +simple-button-override($primary, $white)
```

To use as a placeholder, add the following within a projects `.sass` file:


```sass
.btn
  @extend %simple-button
.btn.info
  @extend %simple-button-info
.btn.important
  @extend %simple-button-important
.btn.success
  @extend %simple-button-success
.btn.warning
  @extend %simple-button-warning
.btn.danger
  @extend %simple-button-danger
.btn.primary
  @extend %simple-button-primary
```

The base class (in this case `.btn`) adds all of the necessary
properties to render a button. The modifiers (`.success`, `.important`)
mainly override the color values for various states. To keep the output
as small as possible, just mixin or extend the states needed within the
project or application.

