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
@import utensils/polyfill
```

## Functions
Internal functions used by polyfills.

### Combine
A function to combine and normalize multiple parameters used by
`transition` and `background-image`.

Accepts a list of arguments to combine separated by a comma.
Returns the combined values for translation into the mixin.

```sass
$full: combine($transition-1, $transition-2, $transition-3)
```


## Background Image
Draws a background image to an element, mainly used for gradients, by
passing a list of comma separated values. This does not support the old
webkit linear gradient.

```sass
.element
  +background-image(linear-gradient(#ff00ff, #000), url("/images/asset.png"))
```


## Box Sizing
Changes the box model used for calculating an elements width and height

Arguments       | Default       | Usage
--------------- | ------------- | ----------------------------------
`$type`        | `border-box`   | Options: `content-box`, `border-box`, `inherit`


```sass
.column
  +box-sizing(border-box)
```


## Transition
Adds vendor prefixes for transitions utilizing a list of comma separated
transition values.

```sass
.element
  +transition(height $speed $ease-in-out-quart, color $speed)
```

