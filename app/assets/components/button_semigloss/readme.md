
# Button Semigloss
A semi-glossy button created via various mixins. By default, no classes
are added to the style sheet unless told to do so.

```sass
@import utensils/components/button_semigloss/button-semigloss
```

## Usage Examples

<!--~ markup/button-semigloss.html.haml -->
```haml
%section.demo(data-target=".btn" data-remove="active error disabled")
  %button.btn Default
  %button.btn.inverse Inverse
  %button.btn.standard Standard
  %button.btn.info Info
  %button.btn.important Important
  %button.btn.success Success
  %button.btn.warning Warning
  %button.btn.danger Danger
  %button.btn.primary Primary

%h5(style="margin-bottom:1em; margin-top:3em;") Select to view states
%nav.radio-demo.button-group(data-bindable="togglable-group" data-target=".btn")
  %a.btn.active(href="#" data-add="") Normal
  %a.btn(href="#" data-add="active") Active
  %a.btn(href="#" data-add="error") Error
  %a.btn(href="#" data-add="disabled") Disabled
```
<!-- end -->

The semigloss-button class can be applied to `<a>`, `<button>` and `<input>` elements.

```haml
%section.semigloss-btn-demo
  %a.btn(href="#") Link
  %button.btn(type="submit") Button
  %input.btn(type="button" value="Input")
  %input.btn(type="submit" value="Submit")
```


## Options
Semigloss button contains 3 mixins. 

### Mixin: `semigloss-button`

Generates the base class for modifiers to extend.

Parameter          | Default          | Description
------------------ | ---------------- | -------------------------------------------
`$bg`              | _none_           | This is a required parameter
`$color`           | `#fff`           | The text `color`
`$hover-percent`   | `10%`            | The percentage to darken the `background-color` on hover
`$active-percent`  | `15%`            | The percentage to darken the `background-color` on press and `.active`
`$border-percent`  | `30%`            | The percentage to darken the `border-color` against `$bg`
`$padding`         | `0.5em 0.8em`    | The `padding` within the button
`$radii`           | `$radii`         | The button's `border-radius`

```sass
.btn
  +semigloss-button($body-bgc, $link-color)
```

### Mixin: `semigloss-button-modifier`

Generates the modifier classes from the base class. This limits the
amount of output for a given button.

Parameter          | Default          | Description
------------------ | ---------------- | -------------------------------------------
`$bg`              | _none_           | This is a required parameter
`$color`           | `#fff`           | The text `color` to override from the base button
`$hover-percent`   | `10%`            | The percentage to darken the `background-color` on hover
`$active-percent`  | `12.5%`          | The percentage to darken the `background-color` on press and `.active`
`$border-percent`  | `15%`            | The percentage to darken the `border-color` against `$bg`

```sass
.btn
  &.important
    +semigloss-button-modifier($important, $white)
  &.success
    +semigloss-button-modifier($success, $white)
  &.warning
    +semigloss-button-modifier($warning, $white)
```

### Mixin: `generate-semigloss-buttons`

Generates the base class and modifier classes from the list directly to
the style sheet.

Parameter          | Default          | Description
------------------ | ---------------- | -------------------------------------------
`$name`            | _none_           | The base class name to call it (`btn`, `action`, ...), required parameter
`$list`            | _none_           | A `list` of named status classes, passing an empty list does not generate any modifiers


```sass
+generate-semigloss-buttons(btn, $base-level-list)

// results in styles for..
.btn
  // styles...

.btn.important
  // modified styles...

.btn.success
  // modified styles...

.btn.warning
  // modified styles...

.btn.danger
  // modified styles...
```

The base class (in these cases `.btn`) adds all of the necessary
properties to render a button. The modifiers (`.success`, `.important`)
mainly override the color values for various states. To keep the output
as small as possible, just mixin or generate the states needed within the
project or application.

#### Auto Generation
To auto generate buttons into the style sheet, within `config.sass` add
the following:

```sass
$auto-generate-semigloss: btn, $base-status-list
```

This will create a base button with the class of `.btn` and
modifiers for each of the elements within the `$base-status-list`. By
default this is set to `false` so no buttons are created.

## Todo:
- This is a bit wordy here.. document how lists in sass work somewhere
  else
- The sass file could use a little cleaning.

