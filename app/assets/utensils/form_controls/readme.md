# Form Controls
Contains the style definitions for form control elements, form control
states, and basic structure for containers. Form controls are typically
paired with one of the form layout components.

## Text based input controls
Represents the basic controls for creating forms. Contains support for all of the HTML5 types.

[<~Example](markup/form_controls_inputs.html.haml)


## Search controls
Represents a search form control. These are set by adding the class
`.search-query` to any text input control element.

[<~Example](markup/form_controls_search.html.haml)

_Warning!_ `input[type="search"]` renders the same as other text input
controls. These types of inputs require the `.search-query` class to be
added to the control.


## Textarea controls
Represents a multi-line plain-text editing control.

[<~Example](markup/form_controls_textarea.html.haml)


## Select controls
Represents a control that presents a menu of options.

[<~Example](markup/form_controls_select.html.haml)


## Radio &amp; Checkbox controls
Radio and checkbox are for selecting options within a list. Radios are
used for selecting a single option, while checkbox is used for selecting
zero to many options.

[<~Example](markup/form_controls_radio_check.html.haml)


## Description elements
Description elements describe or act as helpers around their controls.

[<~Example](markup/form_controls_description.html.haml)

### Usage

Element        | Description
-------------- | ----------------------------------------------------
`%legend`      | Represents a caption for the content of its parent `fieldset`
`%label`       | Associated with a control by the `for` attribute or by placing the control element inside the `%label`
`%abbr`        | Typically used within a `%label` element to denote a required control for the user
`.hint-block`  | The block level element which appears below the control. It can describe actions needed for the user
`.hint-inline` | Allows the hint to appear directly to the right of the control element

#### Status Messages
Hints support modifiers based on the `$form-status-list` variable. These
take the form of `.status-msg` based on the status types passed in. These
are hidden by default, but are shown when the parent `.control-group`
has the status type class added. The following would show only the
`.hint-inline.error-msg`

```haml
.control-group.error
  %label.control-label(for="ex_text") Text:
  .controls
    %input#ex_text(type="text" placeholder="Enter your name")
    %p.hint-inline.error-msg That failed terribly
    %p.hint-inline.success-msg Gold stars all around
```

## Uneditable controls
A modifier on `input` or `textarea` fields that is uneditable by the
user.

[<~Example](markup/form_controls_uneditable.html.haml)

_Warning!_ Make sure the field has the `disabled` attribute set.


## Sizing helpers
By default all `input`and `textarea` controls have a `width` value of
`50%`. The exceptions are inputs with the `type` of `color`, `checkbox`,
`radio`, and the button type inputs which have no `width` value
assigned. The `select` controls have a `width` value of `25%`. The
`legend` element has a `width` value of `100%`. These values can be
overridden in a configuration file.

There are a few helper classes which can be attached to individual
controls, but it's recommended to use these on a control's container.
Typically, these are applied on the `fieldset` or the `.control-group`.
It's even better practice to assign these values within a form layout.

Class          | Size
-------------- | ---------------------------------------
`field-xsmall` | <input class="field-xsmall" type="text" placeholder="12.5%" />
`field-small ` | <input class="field-small" type="text" placeholder="25%" />
`field-medium` | <input class="field-medium" type="text" placeholder="50%" />
`field-large ` | <input class="field-large" type="text" placeholder="75%" />
`field-xlarge` | <input class="field-xlarge" type="text" placeholder="100%" />

_Alert!_ These classes set their `width` with `!important` to override
specificity. Use them only when you mean it.

## Button controls
There are no specific style settings for input types of `submit`,
`reset`, `button` and `image`. Styles associated with button controls
need to be defined by either a class or by allowing a form layout to
create it's own definition.


## Form Structure, Layout and States

Form structures typically consist of:

- A top level `form` element
- One or multiple `fieldset` elements
- A `legend` for each `fieldset` describing the controls within it
- A `div.control-group` containing a `label` and `div.controls` element
- The child `label` of the `.control-group` describes the contents of
  it's `.controls` sibling
- The `div.controls` element hosting the control object, plus `.hints`
  or other descriptive helpers

[<~Example](markup/form_controls_structure.html.haml)

**Pro Tip!** Add either `.well` or `well.fill` to the `form` element to contain it from other items on the page (requires `well.sass`).

_Warning!_ Not all layouts may render in the demo if they aren't included in the project.


## Style Settings
```sass
@import utensils/form_controls
```

To override the default settings, set the variable and it's value
within your `config.sass` file or before `form_controls.sass` is loaded.

Variable                      | Default                               | Description
----------------------------- | ------------------------------------- | -------------------------------------------
`$form-bgc`                   | `$base-bgc`                           | The `background-color` of form controls
`$form-border`                | `$base-border`                        | The `border-color` of form controls
`$form-color`                 | `$base-color`                         | The text `color` of form controls
`$form-focus-bgc`             | `$focus-bgc`                          | The focus `background-color` of form controls
`$form-focus-glow`            | `$focus-glow`                         | The focus glow of form controls
`$form-inset-shadow`          | `inset 0 1px 1px rgba(black, 0.1)`    | The inset shadow of form controls
`$placeholder`                | `#ccc`                                | The text `color` of the `placeholder`
`$placeholder-search`         | `$placeholder`                        | The text `color` of the `placeholder` for controls with the `.search-query` class
`$legend-color`               | `$form-color`                         | The text `color` of `legends`
`$hint-color`                 | `$base-color-active`                  | The text `color` of `hints`
`$uneditable-color`           | `$form-color`                         | The text `color` of `.uneditable-fields`
`$uneditable-bgc`             | `$form-focus-bgc`                     | The text `background-color` of `.uneditable-fields`
`$form-disabled-color`        | `$disabled-color`                     | The text text `color` of disabled controls
`$form-disabled-bgc`          | `$disabled-bgc`                       | The text `background-color` of disabled controls
`$legend-font-size`           | `1.25em`                              | The `font-size` of `legends`
`$label-font-size`            | `0.85em`                              | The `font-size` of `labels`
`$hint-font-size`             | `0.85em`                              | The `font-size` of `hints`
`$form-input-padding`         | `0.5em`                               | The `padding` within control elements
`$form-group-spacing`         | `1em`                                 | The `spacing` between `.control-groups`
`$form-legend-width`          | `100%`                                | The default width of `legend` elements
`$form-input-width`           | `50%`                                 | The default width of most `input` and `textarea` controls
`$form-select-width`          | `25%`                                 | The default width of `select` controls
`$select-height`              | `30px`                                | The `height` of `select` menus
`$form-radii`                 | `$radii`                              | The `radii` to use for controls
`$form-status-list`           | `$success-list, $error-list`          | The `list` of modifier classes for form statuses messages
`$form-actions-well-bgc`      | `darken($base-bgc, 2%)`               | The `background-color` of `.form-actions` when `form` has a `.well` class
`$form-actions-well-fill-bgc` | `darken($form-actions-well-bgc, 10%)` | The `background-color` of `.form-actions` when `form` has a `.well.fill` class

