
# Mixin
Automate common re-usable chunks of CSS, properties, selectors, and/or settings.

```sass
@import utensils/mixin/mixins
```


## Arrows
Draws a directional arrow, typically used for the pseudo elements of
`:before` or `:after`. These are similar to carets, except they don't
require an extra element inside the DOM.

Mixin           | Params                                   | Usage
--------------- | ---------------------------------------- | -------------------
`+arrow`        | `none`                                   | The base setup for arrows
`+arrow_north`  | `$color:#000, $size:5px, $addBase:false` | An arrow pointing up
`+arrow_south`  | `$color:#000, $size:5px, $addBase:false` | An arrow pointing down
`+arrow_east`   | `$color:#000, $size:5px, $addBase:false` | An arrow pointing right
`+arrow_west`   | `$color:#000, $size:5px, $addBase:false` | An arrow pointing left

###### Notes
- **Heads Up!** Arrows are typically positioned `absolute` by default so
  the host should be `relative` and don't forget to add `content: ""`


## Clearfixins
Clearfixins force a containers height to adjust when it contains floated
children elements.

There are two mixins available for fixing floats

- `+clearfixer` The [micro clearfix](http://nicolasgallagher.com/micro-clearfix-hack/) utilizing
  pseudo elements to clear floats
- `+clearfix` Uses `overflow: hidden` to clear floats

Generally, the micro clearfix (`+clearfixer`) is prefered and mixed into
the parent container of floated items.


## Columns
Allows elements to take the shape of either a column or row within a
grid environment.

Mixin                | Usage
---------------------|--------------------------------------------------------------------------------
`+base-column`       | The base `column` settings, should be extended by all columns
`+base-column-right` | An alternate base `column` which floats elements to the right
`+base-row`          | The base `row` settings, should be extended by all rows

###### Warnings
- **Warning!** The column mixins all utilize `box-sizing: border-box`
  which is not supported in ie7

### Todo
- Move the `.pull-left/right` helpers out to a placeholder and document


## Conversions
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

###### Notes
- **Important!** When calculating vertical rhythm, always pass in what
  the expected pixel value is for the element.

###### Warnings
- **Warning!** Define `$context_px`, `$base_font_size`, `$base_width`
  and `$base_vertical` prior to the functions being loaded.


## Float fill
JG... describe this!  


## Font size
Sets a `font-size` using `rems` with a pixel fall back.

##### Arguments
- `$target-px` The target font size in pixels
- `$context:$context-px` [_optional_] The context constraints of the user's base font size

###### Notes
- **Heads Up!** Make sure not to include the `px` postfix when passing a
  size

```sass
h1
  +font-size(48)
  color: blue
```

## Form placeholder
Adds vendor prefixes for altering colors of form placeholder elements.

##### Arguments
- `$color` The color to use (defaults to `#ccc`)

```sass
input,
textarea
  +form-placeholder(blue)
```


## Hardware accelerate
Add `webkit` vendor prefixes for hardware acceleration.

```sass
.carousel
  +hardware-accelerate
```


## Image tools
Image interpolation settings based on [stich css](http://stitchcss.com/).

Mixin                 | Usage
--------------------- | --------------------------------------------------------------------------------
`+sharpen-image`      |  Sharpen an image if it has become blurry due to upscaling or downscaling
`+high-quality-image` |  Improves rendering quality for images which may be upscaled or downscaled
`+low-quality-image`  |  Optimizes the rendering on images so they appear faster, but at a lower quality

###### Warnings
- **Warning!** These settings can have adverse effects in some browsers, test thoroughly.


## Inline block
Mirrors the functionality found in [Compass](http://compass-style.org/reference/compass/css3/inline_block/)
and normalizes `inline-block` for [Bourbon](http://thoughtbot.com/bourbon/) by setting `vertical-align: middle`.

The mixin also fixes support for ie7 if `$legacy-support-for-ie` is set
to true.

```sass
.breadcrumb > li
  +inline-block
  color: blue
```


## Image replacement
Hides text on an element when utilizing a `background-image` such as a logo or icon.

```sass
.footer .social-icon
  +ir
  background-image: $sprite-icons-img
  width: 24px
  height: 24px
```


## Responsive
Mixins for creating responsive behavior around structures and layouts.

Mixin                 | Parameters    | Usage
--------------------- | ------------- | ---------------------
`+resize_containers`  | `$base_value` | Resize any `.container` based on the media query


## Sticky footer
Mixins for sticking and unsticking a footer to the bottom of a page.

Mixin              | Parameters       | Usage
------------------ | ---------------- | ---------------------
`+sticky_footer`   | `$footer-height` | Creates a sticky footer based off a fixed height on the footer element
`+unsticky_footer` | _none_           | Reverses the effect of the sticky_footer mixin, useful in media queries

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


## Tab focus
Resets the normal browser behavior for tab focusable content.

```sass
input[type="radio"]:focus,
input[type="checkbox"]:focus
  +tab-focus
```


## Text selection
Inject vendor prefixes for coloring of text foreground and background when selected.

Mixin             | Params                  | Usage
----------------- | ------------------------| -------------------
`+text-selection` | `$bg:#0091ce, $fg:#fff` | Set the color styles

```sass
+text-selection(blue, white)
```

## Timing equations
Cubic-bezier timing properties for use with
`transition-timing-function`. The timing functions are based on the
properties included with [Bourbon](http://thoughtbot.com/bourbon/).

Property             | Example
-------------------- | -------------------------------------------------------
`default (linear)`   | <div class="sherpa-swatch"></div>
`$ease-in-quad`      | <div class="sherpa-swatch ease-in-quad"></div>
`$ease-in-cubic`     | <div class="sherpa-swatch ease-in-cubic"></div>
`$ease-in-quart`     | <div class="sherpa-swatch ease-in-quart"></div>
`$ease-in-quint`     | <div class="sherpa-swatch ease-in-quint"></div>
`$ease-in-sine`      | <div class="sherpa-swatch ease-in-sine"></div>
`$ease-in-expo`      | <div class="sherpa-swatch ease-in-expo"></div>
`$ease-in-circ`      | <div class="sherpa-swatch ease-in-circ"></div>
`$ease-in-back`      | <div class="sherpa-swatch ease-in-back"></div>
`$ease-out-quad`     | <div class="sherpa-swatch ease-out-quad"></div>
`$ease-out-cubic`    | <div class="sherpa-swatch ease-out-cubic"></div>
`$ease-out-quart`    | <div class="sherpa-swatch ease-out-quart"></div>
`$ease-out-quint`    | <div class="sherpa-swatch ease-out-quint"></div>
`$ease-out-sine`     | <div class="sherpa-swatch ease-out-sine"></div>
`$ease-out-expo`     | <div class="sherpa-swatch ease-out-expo"></div>
`$ease-out-circ`     | <div class="sherpa-swatch ease-out-circ"></div>
`$ease-out-back`     | <div class="sherpa-swatch ease-out-back"></div>
`$ease-in-out-quad`  | <div class="sherpa-swatch ease-in-out-quad"></div>
`$ease-in-out-cubic` | <div class="sherpa-swatch ease-in-out-cubic"></div>
`$ease-in-out-quart` | <div class="sherpa-swatch ease-in-out-quart"></div>
`$ease-in-out-quint` | <div class="sherpa-swatch ease-in-out-quint"></div>
`$ease-in-out-sine`  | <div class="sherpa-swatch ease-in-out-sine"></div>
`$ease-in-out-expo`  | <div class="sherpa-swatch ease-in-out-expo"></div>
`$ease-in-out-circ`  | <div class="sherpa-swatch ease-in-out-circ"></div>
`$ease-in-out-back`  | <div class="sherpa-swatch ease-in-out-back"></div>

### Todo
- Setup the demo for this


## Visibility
Controls various visibility settings applied to elements.

Mixin            | Params  | Usage
---------------- | ------- | ----------------------------------------------
`+hidden`        | _none_  | Totally hidden from screen readers and browsers
`+shown`         | _none_  | Reverse the effects of `hidden`
`+visuallyhidden`| _none_  | Only visually hidden, still available to screen readers
`+visuallyshown` | _none_  | Reverse the settings applied by `.visuallyhidden`
`+invisible`     | _none_  | Hide visually and from screenreaders, but maintain layout

###### Warnings
- **Warning!** When using `visuallyhidden` and `visuallyshown` with
  `box-shadow`, you'll need to add `clip:initial` to get the shadows to
  reappear


## Todo
- Normalize how this documentation is (either go with tables or
  argument listing)

