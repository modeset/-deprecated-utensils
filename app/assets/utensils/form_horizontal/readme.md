# Form Horizontal
An alternative to the default stacked form, floats control labels down
the left side of the form. The markup structure remains the same as the
default layout, it only requires the class `.form-horizontal` on the
`form` element.

**Pro Tip!** Check out the "Form Structure" section under "Form
Controls" for the demo and usage example.


## Style Settings
```sass
@import utensils/form_controls/form_controls
@import utensils/form_horizontal/form_horizontal
```

To override the default settings, set the variable and it's value
within your `config.sass` file or before `form_horizontal.sass` is loaded.

Variable                     | Default                  | Description
---------------------------- | ------------------------ | -------------------------------------------
`$form-horiz-offset`         | `$horiz-offset`          | The for `.control-label`, `.controls` and `.form-actions` containers
`$form-horiz-offset-padding` | `$horiz-offset-padding`  | The padding between the `.control-label` and `.controls` containers

_Alert!_ Requires the `form_controls` utensil.

