# Polyfill
Most projects benefit greatly from using a library like
[Compass](http://compass-style.org/) or
[Bourbon](http://thoughtbot.com/bourbon/). Utensils is not designed to
replace these libraries, but rather sit on top of them. There may be
times when using one of these libraries isn't an option, so Utensils
provides a few simple polyfill mixins in it's place.

If a project uses Compass or Bourbon, make sure not to import these
polyfills.

```sass
@import utensils/polyfill/polyfills
```

## Functions
Internal functions used by polyfills.

### Combine
A function to combine and normalize multiple parameters (supports up to
9), used by `transition`, `box-shadow` and `background-image`.

##### Arguments
- `$value-1` The first property to combine
- `$value-2(-9)` Remaining properties to combine (defaults to `false`)
- `@return` The combined values for translation into the mixin

_Warning!_ The combine function for mixin values only accepts 9 values,
this is inline with the Bourbon library (Compass supports 10!)

```sass
$full: combine($transition-1, $transition-2, $transition-3)
```


## Background Image
Draws a background image to an element, mainly used for gradients
(supports up to 9 background image parameters) This does not support the
old webkit linear gradient.

##### Arguments
- `$bgi-n` The background image properties to apply

```sass
.element
  +background-image(linear-gradient(#ff00ff, #000), url("/images/asset.png"))
```


## Box Shadow
Draws an outer or inset shadow around an element (supports up to 9
shadow parameters)

##### Arguments
- `$shadow-n` The normal or inset shadow properties to apply

```sass
.element
  +box-shadow(inset 0 1px 1px rgba(0, 0, 0, 0.1), -1px -1px 5px 1px black)
```


## Box Sizing
Changes the box model used for calculating an elements width and height

##### Arguments
- `$type:border-box` Options: `content-box | border-box | inherit`

```sass
.column
  +box-sizing(border-box)
```


## Opacity
Provides cross browser opacity, values are between `0-1`.

##### Arguments
- `$alpha:1`

```sass
.element
  +opacity(0.5)
```


## Transition
Adds vendor prefixes for transitions (supports up to 9 transition
parameters)

##### Arguments
- `$transition-n` The transition values to apply.

```sass
.element
  +transition(height $speed $ease-in-out-quart, color $speed)
```


## User Select
Define whether an element is selectable (only controls the appearance).

##### Arguments
- `$type:none` Options: `none | auto | text`

```sass
.cant-touch-this
  +user-select(none)
```

