
# Form Controls
Contains the style definitions for form control elements, form control
states, and basic structure for containers. Form controls are typically
paired with one of the form layout components.

```sass
@import utensils/components/form_controls/form-controls
```

## Text based input controls
Represents the basic controls for creating forms. Contains support for all of the HTML5 types.

### Usage Examples

<!--~ markup/form-controls-inputs.html.haml -->
```haml
%form.sherpa-clearfix
  %fieldset.sherpa-split-pull
    %legend Common input controls
    .control-group
      .controls
        %input(type="text" placeholder="text")
    .control-group
      .controls
        %input(type="email" placeholder="name@example.com")
    .control-group
      .controls
        %input(type="password" placeholder="password")
    .control-group
      .controls
        %input(type="url" placeholder="www.example.com")
    .control-group
      .controls
        %input(type="tel" placeholder="303-867-5309")
    .control-group
      .controls
        %input(type="search" placeholder="search")
    .control-group
      .controls
        %input(type="date" placeholder="date")
    .control-group
      .controls
        %input(type="number" placeholder="number" max="10" min="0")

  %fieldset.sherpa-split-push
    %legend Less common input controls
    .control-group
      .controls
        %input(type="datetime" placeholder="datetime")
    .control-group
      .controls
        %input(type="datetime-local" placeholder="datetime-local")
    .control-group
      .controls
        %input(type="time" placeholder="time")
    .control-group
      .controls
        %input(type="month" placeholder="month")
    .control-group
      .controls
        %input(type="week" placeholder="week")
    .control-group
      .controls
        %input(type="range" placeholder="range" max="10" min="0" step=".5")
    .control-group
      .controls
        %input(type="color" value="#ff00ff")
    .control-group
      .controls
        %input(type="file" value="file")
    .control-group
      %label.control-label <abbr title="The input field's type is set to hidden">Hidden Input Field</abbr>
      .controls
        %input(type="hidden" placeholder="hidden")
```
<!-- end -->

## Search controls
Represents a search form control. These are set by adding the class
`.search-query` to any text input control element.

### Usage Examples

<!--~ markup/form-controls-search.html.haml -->
```haml
%form
  %fieldset
    %legend Search Elements
    .control-group
      .controls
        %input.search-query(type="search" placeholder="search")
```
<!-- end -->

###### Warning
- **Heads Up!** `input[type="search"]` renders the same as
  other text input controls. These types of inputs require the
  `.search-query` class to be added to the control.


## Textarea controls
Represents a multi-line plain-text editing control.

### Usage Examples

<!--~ markup/form-controls-textarea.html.haml -->
```haml
%form
  %fieldset
    %legend Textarea Controls
    .control-group
      .controls
        %textarea(placeholder="Enter the textarea..." rows="8")
```
<!-- end -->


## Select controls
Represents a control that presents a menu of options.

### Usage Examples

<!--~ markup/form-controls-select.html.haml -->
```haml
%form
  %fieldset
    %legend Select Controls
    .control-group
      .controls
        %select
          %optgroup(label="Colorado")
            %option(selected="selected" value="denver") Denver
            %option(value="boulder") Boulder
          %optgroup(label="California")
            %option(value="los angeles") Los Angeles
            %option(value="san francisco") San Francisco
    .control-group
      %label.control-label(for="fcsm_select") Multiple Select
      .controls
        %select#fcsm_select(multiple)
          %option(value="1") One
          %option(selected="selected" value="2") Two
          %option(value="3") Three
          %option(value="4") Four
          %option(value="5") Five
```
<!-- end -->


## Radio &amp; Checkbox controls
Radio and checkboxes are for selecting options within a list. Radios are
used for selecting a single option, while checkboxes are for selecting
zero to many options.

### Usage Examples

<!--~ markup/form-controls-radio-check.html.haml -->
```haml
%form
  %fieldset
    %legend Radio Controls
    .control-group
      %label.control-label<
        %h5 Radio
      .controls
        %label.radio-label(for="fc_radio1-1")
          %input#fc_radio1-1(type="radio" name="fc[radios1]" value="true" checked) Yes, to radio buttons
        %label.radio-label(for="fc_radio1-2")
          %input#fc_radio1-2(type="radio" name="fc[radios1]" value="false") No, to radio buttons

    .control-group
      %label.control-label<
        %h5 Radio Inline
      .controls
        %label.radio-label-inline(for="fc_radio2-1")
          %input#fc_radio2-1(type="radio" name="fc[radios2]" value="true" checked) Yes, to inline radios
        %label.radio-label-inline(for="fc_radio2-2")
          %input#fc_radio2-2(type="radio" name="fc[radios2]" value="false") No, to inline radios

    %legend Checkbox Controls
    .control-group
      %label.control-label<
        %h5 Checkbox
      .controls
        %label.checkbox-label(for="fc_check1-1")
          %input#fc_check1-1(type="checkbox" value="0") Check your premises
        %label.checkbox-label(for="fc_check1-2")
          %input#fc_check1-2(type="checkbox" value="1" checked) Premises, checked.

    .control-group
      %label.control-label<
        %h5 Checkbox Inline
      .controls
        %label.checkbox-label-inline(for="fc_check2-1")
          %input#fc_check2-1(type="checkbox" value="0") Check your inline premises
        %label.checkbox-label-inline(for="fc_check2-2")
          %input#fc_check2-2(type="checkbox" value="1" checked) Premises inline, checked.
```
<!-- end -->


## Description elements
Description elements describe or act as helpers around their controls.

### Usage Examples

<!--~ markup/form-controls-description.html.haml -->
```haml
%form
  %fieldset
    %legend I am Legend

    .control-group
      %label.control-label(for="fcd_text1") Label<abbr title="Required">*</abbr>
      .controls
        %input#fcd_text1(type="text" placeholder="text")
        %p.hint-block The hint block for the control element

    %hr

    .control-group
      %label.control-label(for="fcd_text2") Label<abbr title="Required">*</abbr>
      .controls
        %input#fcd_text2(type="text" placeholder="text")
        %p.hint-inline The inline hint for the control element
```
<!-- end -->

### Usage

Element        | Description
-------------- | ----------------------------------------------------
`%legend`      | Represents a caption for the content of its parent `fieldset`
`%label`       | Associated with a control by the `for` attribute or by placing the control element inside the `%label`
`%abbr`        | Typically used within a `%label` element to denote a required control for the user
`.hint-block`  | The block level element which appears below the control. It can describe actions needed for the user
`.hint-inline` | Allows the hint to appear directly to the right of the control element

###### Notes
- **Pro Tip!** Hints support modifiers for `.success-msg` and
  `.error-msg`, these are hidden by default, but will render when the
  `.control-group` has been modified with either a `.error` or
  `.success`


## Uneditable controls
A modifier on `input` or `textarea` fields that is uneditable by the
user.

### Usage Examples

<!--~ markup/form-controls-uneditable.html.haml -->
```haml
%form
  %fieldset
    %legend Uneditable Controls
    .control-group
      %label.control-label(for="fcu_text") Uneditable field<abbr title="Fill out entire form first">!</abbr>
      .controls
        %input#fcu_text.uneditable-field(type="text" placeholder="text" value="Can't touch this!" disabled)
        %p.hint-inline Hurry up!

    .control-group
      %label.control-label(for="fcu_textarea") Uneditable field<abbr title="Fill out entire form first">!</abbr>
      .controls
        %textarea#fcu_textarea.uneditable-field(placeholder="Enter the textarea..." rows="8" disabled) Can't touch this either
```
<!-- end -->

###### Warning
- **Heads Up!** Make sure the field has the `disabled` attribute set.


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

###### Alert
- **Heads Up!** These classes set their `width` with `!important` to
  override specificity. Use them only when you mean it.

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

### Usage Examples
<!--~ markup/form-controls-structure.html.haml -->
```haml
%section#demo_form.button-toolbar(style="margin-bottom:1em;")
  %nav.button-group(data-bindable="toggler-group" data-target=".btn" data-remove="form-vertical form-horizontal")
    %button.btn.active(href="#" data-add="") Default
    %button.btn(href="#" data-add="form-horizontal") Horizontal
  %nav.button-group(data-bindable="toggler-group" data-target=".btn" data-remove="well dark lite")
    %button.btn.active(href="#" data-add="") None
    %button.btn(href="#" data-add="well") Well
    %button.btn(href="#" data-add="well lite") Well Lite
    %button.btn(href="#" data-add="well dark") Well Dark
  %nav.button-group(data-bindable="toggler-group" data-target=".btn" data-remove="disabled error success")
    %button.btn.active(href="#" data-add="") Normal
    %button.btn(href="#" data-add="disabled") Disabled
    %button.btn(href="#" data-add="error") Error
    %button.btn(href="#" data-add="success") Success

%form
  %fieldset
    %legend Standard information
    -# Text inputs
    .control-group
      %label.control-label(for="fcs_text") Text:<abbr title="Required">*</abbr>
      .controls
        %input#fcs_text(type="text" placeholder="Enter your name")
        %p.hint-inline.error-msg That failed terribly
        %p.hint-inline.success-msg Gold stars all around
        %p.hint-block First and last name
    .control-group
      %label.control-label(for="fcs_email") Email:<abbr title="Required">*</abbr>
      .controls
        %input#fcs_email(type="email" placeholder="name@example.com")
        %p.hint-inline No AOL accounts!
        %p.hint-inline.error-msg That failed terribly
        %p.hint-inline.success-msg Gold stars all around
        %p.hint-block We won't share it
    .control-group
      %label.control-label(for="fcs_file") File Browser:
      .controls
        %input#fcs_file(type="file" value="file")
        %p.hint-inline.error-msg That failed terribly
        %p.hint-inline.success-msg Gold stars all around
    .control-group
      %label.control-label(for="fcs_textarea") Textarea:
      .controls
        %textarea#fcs_textarea(placeholder="Enter the textarea..." rows="8")
        %p.hint-inline.error-msg That failed terribly
        %p.hint-inline.success-msg Gold stars all around
    -# Uneditable
    .control-group
      %label.control-label(for="fcs_uneditable") <abbr title="Fill out entire form first">Uneditable field:</abbr>
      .controls
        %input#fcs_uneditable.uneditable-field(type="text" placeholder="text" value="Can't touch this!" disabled)
        %p.hint-inline Hurry up!
        %p.hint-inline.error-msg That failed terribly
        %p.hint-inline.success-msg Gold stars all around

  %fieldset
    %legend Make a choice
    -# Radios
    .control-group
      %label.control-label Radio:
      .controls
        %label.radio-label(for="fcs_radio1-1")
          %input#fcs_radio1-1(type="radio" name="fc[radios1]" value="true" checked) Yes, to radio buttons
        %label.radio-label(for="fcs_radio1-2")
          %input#fcs_radio1-2(type="radio" name="fc[radios1]" value="false") No, to radio buttons
    .control-group
      %label.control-label Radio Inline:
      .controls
        %label.radio-label-inline(for="fcs_radio2-1")
          %input#fcs_radio2-1(type="radio" name="fc[radios2]" value="true" checked) Yes, to inline radios
        %label.radio-label-inline(for="fcs_radio2-2")
          %input#fcs_radio2-2(type="radio" name="fc[radios2]" value="false") No, to inline radios
        %p.hint-inline.error-msg That failed terribly
        %p.hint-inline.success-msg Gold stars all around
    -# Checks
    .control-group
      %label.control-label Checkbox:
      .controls
        %label.checkbox-label(for="fcs_check1-1")
          %input#fcs_check1-1(type="checkbox" value="0") Check your premises
        %label.checkbox-label(for="fcs_check1-2")
          %input#fcs_check1-2(type="checkbox" value="1" checked) Premises, checked.
    .control-group
      %label.control-label Checkbox Inline:
      .controls
        %label.checkbox-label-inline(for="fcs_check2-1")
          %input#fcs_check2-1(type="checkbox" value="0") Check your inline premises
        %label.checkbox-label-inline(for="fcs_check2-2")
          %input#fcs_check2-2(type="checkbox" value="1" checked) Premises inline, checked.
        %p.hint-inline.error-msg That failed terribly
        %p.hint-inline.success-msg Gold stars all around
    -# Selects
    .control-group
      %label.control-label(for="fcs_multiselect") Multiple Select:
      .controls
        %select#fcs_multiselect(multiple)
          %option(value="1") One
          %option(selected="selected" value="2") Two
          %option(value="3") Three
          %option(value="4") Four
          %option(value="5") Five
        %p.hint-inline.error-msg That failed terribly
        %p.hint-inline.success-msg Gold stars all around
    .control-group
      %label.control-label(for="fcs_select") Select:
      .controls
        %select
          %option(selected="selected" value="denver") Denver
          %option(value="boulder") Boulder
          %option(value="los angeles") Los Angeles
          %option(value="san francisco") San Francisco
        %p.hint-inline.error-msg That failed terribly
        %p.hint-inline.success-msg Gold stars all around

    .form-actions
      %input.btn.standard(type="submit" value="Submit")
      %input.btn.standard(type="reset" value="Cancel")
```
<!-- end -->

###### Notes
- **Pro Tip!** Add one of the `.well` classes to the `form` element to contain it from other items on the page

###### Warning
- **Heads Up!** Not all layouts may render in the demo if they aren't
  included in the project


## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `form-controls.sass` is loaded.

Attribute                | Default                             | Description
------------------------ | ----------------------------------- | -------------------------------------------
`$form-bgc`              | `$white`                            | The `background-color` of form controls
`$form-border-color`     | `$border-color`                     | The `border-color` of form controls
`$form-color`            | `$body-color`                       | The text `color` of form controls
`$form-focus-bgc`        | `$off-white`                        | The focus `background-color` of form controls
`$form-inset-shadow`     | `inset 0 1px 1px rgba($black, 0.1)` | The inset shadow of form controls
`$form-focus-glow`       | `$focus-glow`                       | The focus glow of form controls
`$placeholder`           | `#ccc`                              | The text `color` of the `placeholder`
`$placeholder-search`    | `$placeholder`                      | The text `color` of the `placeholder` for controls with the `.search-query` class
`$legend-color`          | `$form-color`                       | The text `color` of `legends`
`$hint-color`            | `lighten($form-color, 20%)`         | The text `color` of `hints`
`$uneditable-bgc`        | `$form-focus-bgc`                   | The text `background-color` of `.uneditable-fields`
`$uneditable-color`      | `$form-color`                       | The text `color` of `.uneditable-fields`
`$form-disabled-bgc`     | `$disabled-bgc`                     | The text `background-color` of disabled controls
`$form-disabled-color`   | `$disabled-color`                   | The text text `color` of disabled controls
`$form-input-width`      | `50%`                               | The default width of most `input` and `textarea` controls
`$form-select-width`     | `25%`                               | The default width of `select` controls
`$form-legend-width`     | `100%`                              | The default width of `legend` elements
`$legend-font-size`      | `1.25em`                            | The `font-size` of `legends`
`$label-font-size`       | `0.85em`                            | The `font-size` of `labels`
`$hint-font-size`        | `0.85em`                            | The `font-size` of `hints`
`$select-height`         | `28px`                              | The `height` of `select` menus
`$form-radii`            | `$radii`                            | The `radii` to use for controls
`$form-input-padding`    | `0.5em`                             | The `padding` within control elements
`$form-group-spacing`    | `1em`                               | The `spacing` between `.control-groups`
`$form-well-bgc`         | `$off-white`                        | The `background-color` of `.form-actions` when `form` has a `.well` class
`$form-well-lite-bgc`    | `darken($form-well-bgc, 3%)`        | The `background-color` of `.form-actions` when `form` has a `.well.lite` class
`$form-well-dark-bgc`    | `darken($off-grey, 5%)`             | The `background-color` of `.form-actions` when `form` has a `.well.dark` class
`$form-well-dark-border` | `darken($form-border-color, 5%)`    | The `border-color` of `.form-actions` when `form` has a `.well.dark` class

