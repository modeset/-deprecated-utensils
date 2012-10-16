
# Form Horizontal
An alternative to the default stacked form, floats control labels down
the left side of the form. The markup structure remains the same as the
default layout, it only requires the class `.form-horizontal` on the
`form` element.

```sass
@import utensils/form_horizontal/form-horizontal
```

###### Notes
- **Pro Tip!** Check out the "Form Structure" section under "Form
  Controls" for the demo and usage example.

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `form-horizontal.sass` is loaded.

Variable                     | Default                  | Description
---------------------------- | ------------------------ | -------------------------------------------
`$form-horiz-offset`         | `$horiz-offset`          | The for `.control-label`, `.controls` and `.form-actions` containers
`$form-horiz-offset-padding` | `$horiz-offset-padding`  | The padding between the `.control-label` and `.controls` containers

###### Notes
- **Heads Up!** Requires the `form-controls` utensil.

