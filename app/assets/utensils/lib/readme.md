# Lib
The `lib` component contains Sass `functions`, `mixins`, and
`placeholders` to automate common re-usable chunks of CSS. They are
built and designed to work with [bourbon](http://www.bourben.io/).

```sass
@import utensils/lib
```

This will import all of utensil's `functions`, `mixins`, and
`placeholders`. This is the recommended `import` as it does not add any
selectors to the actual CSS output.

## Functions

```sass
@import utensils/lib/functions
```

### Conversions
Functions for calculations and conversion between pixels, ems, rems and
percentages.

Function           | Params                                    | Usage
------------------ | ----------------------------------------- | ----------------------------------------------
`to_em`            |  `$target-px`, `$context:$base-font_size` |  Converts target `px` value to `em` in context constraints of the `$base-font-size`
`to_rem`           |  `$target-px`, `$context:$context-px`     |  Converts target `px` value to `rem` in context constraints of the user's `$base-font-size`
`to_percent`       |  `$target-px`, `$context:$base-width`     |  Converts target `px` value to `percentage` in context constraints of the container's width
`vertical_pixel`   |  `$target-px`                             |  Returns the vertical rhythm in pixels calculated from the `$base-vertical` setting
`vertical_em`      |  `$target-px`                             |  Returns the vertical rhythm in em calculated from the `$base-vertical` setting
`vertical_percent` |  `$target-px`                             |  Returns the vertical rhythm in percent calculated from the `$base-vertical` setting

**Important!** When calculating vertical rhythm, always pass in what the
expected pixel value is for the element.

_Warning!_ Define `$context_px`, `$base_font_size`, `$base_width` and
`$base_vertical` prior to the functions being called.


## Mixins

```sass
@import utensils/lib/mixins
```

### Arrows
Draws a directional arrow, typically used for the pseudo elements of
`:before` or `:after`. These are similar to carets, except they don't
require an extra element inside the DOM.

Mixin           | Params                                    | Usage
--------------- | ----------------------------------------- | -------------------
`+arrow`        | `none`                                    | The base setup for arrows
`+arrow_north`  | `$color:#000, $size:5px, $add_base:false` | An arrow pointing up
`+arrow_south`  | `$color:#000, $size:5px, $add_base:false` | An arrow pointing down
`+arrow_east`   | `$color:#000, $size:5px, $add_base:false` | An arrow pointing right
`+arrow_west`   | `$color:#000, $size:5px, $add_base:false` | An arrow pointing left

**Heads Up!** Arrows are typically positioned `absolute` by default so
the host should be `relative` and don't forget to add `content: ""`


### Containers
Allows elements to take the shape of either a column or row within a
grid environment.

Mixin                | Usage
---------------------|--------------------------------------------------------------------------------
`+base-column`       | The base `column` settings, should be extended by all columns
`+base-column-right` | An alternate base `column` which floats elements to the right
`+base-row`          | The base `row` settings, should be extended by all rows

_Warning!_ The column mixins all utilize `box-sizing: border-box` which
is not fully supported in ie7

**Heads Up!** It is recommended to use the `placeholder` versions of
these instead within your project to cut down on the final CSS output.


### Disable Tab Default
Disables the highlight color for tapping on touch `webkit` devices

```sass
.element
  +disable-tap-default
```

### Fills Height
_JG... describe this!_


### Float Fill
_JG... describe this!_


### Font size
Sets a `font-size` using `rems` with a pixel fall back.

Arguments       | Default       | Usage
--------------- | ------------- | ----------------------------------
`$target-px`    | _none_        | The target font size in pixels
`$context`      | `$context-px` | The context constraints of the user's base font size

**Heads Up!** Make sure _not_ to include the `px` postfix when passing a size

```sass
h1
  +font-size(48)
  color: blue
```


### Opacity
Provides cross browser opacity, values are between `0-1`.

```sass
.element
  +opacity(0.5)
```

### Selection
Inject vendor prefixes for coloring of text foreground and background when selected.

Mixin             | Params                  | Usage
----------------- | ------------------------| -------------------
`+selection` | `$bg:#0091ce, $fg:#fff` | Set the color styles

```sass
+text-selection(blue, white)
```


### Sticky footer
Mixins for sticking and unsticking a footer to the bottom of a page.

Mixin              | Parameters       | Usage
------------------ | ---------------- | ---------------------
`+sticky_footer`   | `$footer-height` | Creates a sticky footer based off a fixed height on the footer element
`+unsticky_footer` | _none_           | Reverses the effect of the `sticky_footer` mixin, useful in media queries

Requires the markup to contain a `.main`, `.content` and `.footer` elements.

```haml
%body(role="document")
  %section.main
    %section.content
      %section.container(role="main")
        <!-- page content -->
  %footer.footer
    <!-- footer content -->
```

```sass
+sticky-footer(100px)
```


### Tab focus
Resets the normal browser behavior for tab focusable content.

```sass
input[type="radio"]:focus,
input[type="checkbox"]:focus
  +tab-focus
```


### Visibility
Controls various visibility settings applied to elements.

Mixin            | Params  | Usage
---------------- | ------- | ----------------------------------------------
`+hidden`        | _none_  | Totally hidden from screen readers and browsers
`+shown`         | _none_  | Reverse the effects of `hidden`
`+visuallyhidden`| _none_  | Only visually hidden, still available to screen readers
`+visuallyshown` | _none_  | Reverse the settings applied by `.visuallyhidden`
`+invisible`     | _none_  | Hide visually and from screenreaders, but maintain layout

_Warning!_ When using `visuallyhidden` and `visuallyshown` with
`box-shadow`, you'll need to add `clip:initial` to get the shadows to
reappear


## Placeholders
Wrappers around common mixins from utensils and bourbon, these should be
used in favor of the mixins within most situations of a project.

```sass
@import utensils/lib/mixins
@import utensils/lib/placeholders
```

### Containers

Placeholder          | Usage
---------------------|--------------------------------------------------------------------------------
`%base-column`       | The base `column` settings, should be extended by all columns
`%base-column-right` | An alternate base `column` which floats elements to the right
`%base-row`          | The base `row` settings, should be extended by all rows
`%clearfix`          | The [micro clearfix](http://nicolasgallagher.com/micro-clearfix-hack/) utilizing pseudo elements to clear floats

**Heads Up!** `scaffold.sass` automatically sets up a `.cf` class that
extends the `%clearfix` placeholder


### Visibility

Placeholder           | Usage
--------------------- | --------------------------------------------------------------------------------
`%hidden`             | Totally hidden from screen readers and browsers
`%shown`              | Reverse the effects of `hidden`
`%visuallyhidden`     | Only visually hidden, still available to screen readers
`%visuallyshown`      | Reverse the settings applied by `.visuallyhidden`
`%invisible`          | Hide visually and from screenreaders, but maintain layout
`%ir`                 | Wrapper around Bourbon's `+hide-text` mixin


**Heads Up!** `scaffold.sass` automatically sets up a `.hidden`,
`.shown` and `.ir` class that extends the `%hidden`, `%shown`, and `%ir`
placeholders.

