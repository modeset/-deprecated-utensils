
# Form Controls
Contain the style definitions for `input`, `textarea`, `select`, `radio`
`checkbox`, `labels`, `.hints`, `button` elements and other common form
controls. The styles do contain some base structure, but typically
pairing the form controls with a form layout file is preferred.

```sass
@import utensils/components/form_controls/form-controls
```


## Structure

Form structures typically consist of:

- A top level `%form` element
- One or multiple `%fieldset` elements
- A `%legend` for each `%fieldset` describing the controls within it
- A `%div.control-group` containing a `%label` and `%div.controls` element
- The child `%label` of the `.control-group` describes the contents of
  it's `.controls` sibling
- The `%div.controls` element hosting the control object, plus `.hints`
  or other descriptive helpers

### Usage Examples
<!--~ markup/form-controls-structure.html.haml -->
```haml
%form
  %fieldset
    %legend I am Legend
    .control-group
      %label(for="fcs_text") Label Name<abbr title="Required">*</abbr>
      .controls
        %input#fcs_text(type="text" placeholder="text")
        %p.hint The hint for the control element
```
<!-- end -->


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
        %input.input-large(type="text" placeholder="text")
    .control-group
      .controls
        %input.input-large(type="email" placeholder="name@example.com")
    .control-group
      .controls
        %input.input-large(type="password" placeholder="password")
    .control-group
      .controls
        %input.input-large(type="url" placeholder="www.example.com")
    .control-group
      .controls
        %input.input-large(type="tel" placeholder="303-867-5309")
    .control-group
      .controls
        %input.input-large(type="search" placeholder="google")
    .control-group
      .controls
        %input.input-medium(type="date" placeholder="date")
    .control-group
      .controls
        %input.input-small(type="number" placeholder="number" max="10" min="0")

  %fieldset.sherpa-split-push
    %legend Less common input controls
    .control-group
      .controls
        %input.input-large(type="datetime" placeholder="datetime")
    .control-group
      .controls
        %input.input-large(type="datetime-local" placeholder="datetime-local")
    .control-group
      .controls
        %input.input-large(type="time" placeholder="time")
    .control-group
      .controls
        %input.input-large(type="month" placeholder="month")
    .control-group
      .controls
        %input.input-large(type="week" placeholder="week")
    .control-group
      .controls
        %input.input-medium(type="range" placeholder="range" max="10" min="0" step=".5")
    .control-group
      .controls
        %input.input-xsmall(type="color" value="#ff00ff")
    .control-group
      %label <abbr title="The input field's type is set to hidden">Hidden Input Field</abbr>
      .controls
        %input.input-small(type="hidden" placeholder="hidden")
```
<!-- end -->


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
        %textarea.input-small(placeholder="Enter the textarea..." rows="8")
```
<!-- end -->


## Select controls
Represents a control that presents menu of options.

### Usage Examples

<!--~ markup/form-controls-select.html.haml -->
```haml
%form
  %fieldset
    %legend Select Controls
    .control-group
      .controls
        %select.input-small
          %optgroup(label="Colorado")
            %option(selected="selected" value="denver") Denver
            %option(value="boulder") Boulder
          %optgroup(label="California")
            %option(value="los angeles") Los Angeles
            %option(value="san francisco") San Francisco
    .control-group
      %label(for="fcsm_select") Multiple Select
      .controls
        %select#fcsm_select.input-small(multiple)
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
0-many options.

### Usage Examples

<!--~ markup/form-controls-radio-check.html.haml -->
```haml
%form
  %fieldset
    %legend Radio Controls
    .control-group
      %label
        %h5 Radio
      .controls
        %label.radio-label(for="fc_radio1-1")
          %input#fc_radio1-1(type="radio" name="fc[radios1]" value="true" checked) Yes, to radio buttons
        %label.radio-label(for="fc_radio1-2")
          %input#fc_radio1-2(type="radio" name="fc[radios1]" value="false") No, to radio buttons

    .control-group
      %label
        %h5 Inline Radio
      .controls
        %label.radio-label.inline(for="fc_radio2-1")
          %input#fc_radio2-1(type="radio" name="fc[radios2]" value="true" checked) Yes, to inline radios
        %label.radio-label.inline(for="fc_radio2-2")
          %input#fc_radio2-2(type="radio" name="fc[radios2]" value="false") No, to inline radios

    %legend Checkbox Controls
    .control-group
      %label
        %h5 Checkbox
      .controls
        %label.checkbox-label(for="fc_check1-1")
          %input#fc_check1-1(type="checkbox" value="0") Check your premises
        %label.checkbox-label(for="fc_check1-2")
          %input#fc_check1-2(type="checkbox" value="1" checked) Premises, checked.

    .control-group
      %label
        %h5 Inline Checkbox
      .controls
        %label.checkbox-label.inline(for="fc_check2-1")
          %input#fc_check2-1(type="checkbox" value="0") Check your inline premises
        %label.checkbox-label.inline(for="fc_check2-2")
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
    %legend Description Elements

    .control-group
      %label(for="fcd_text1") Label Name<abbr title="Required">*</abbr>
      .controls
        %input#fcd_text1(type="text" placeholder="text")
        %p.hint The hint for the control element

    .control-group
      %label(for="fcd_text2") Label Name<abbr title="Required">*</abbr>
      .controls
        %input#fcd_text2(type="text" placeholder="text")
        %p.hint.inline The inline hint for the control element
```
<!-- end -->

### Usage

Element        | Description
-------------- | ----------------------------------------------------
`%legend`      | Represents a caption for the content of its parent `fieldset`
`%label`       | Associated with a control by the `for` attribute or by placing the control element inside the `%label`
`%abbr`        | Typically used within a `%label` element to denote a required control for the user
`.hint`        | The block level element which appears below the control. It can describe actions needed for the user
`.hint.inline` | Allows the hint to appear directly to the right of the control element


## Uneditable controls
Represents `span` elements disguised as `inputs`.

### Usage Examples

<!--~ markup/form-controls-uneditable.html.haml -->
```haml
%form
  %fieldset
    %legend Uneditable Controls
    .control-group
      %label(for="fcu_text") Uneditable field<abbr title="Fill entire form first">!</abbr>
      .controls
        %span.uneditable-input.input-small Can't touch this!
        %p.hint.inline Hurry up!
```
<!-- end -->

## Sizing helpers
By default, form controls typically do not have a `width` value
out of the box. There are some convenience helper classes for settings
this directly on a control. However, it's best practice to set `width`
sizing within a form layout template.

Class          | Size
-------------- | ---------------------------------------
`input-xsmall` | <input class="input-xsmall" type="text" placeholder="12.5%" />
`input-small ` | <input class="input-small" type="text" placeholder="25%" />
`input-medium` | <input class="input-medium" type="text" placeholder="50%" />
`input-large ` | <input class="input-large" type="text" placeholder="75%" />
`input-xlarge` | <input class="input-xlarge" type="text" placeholder="100%" />

