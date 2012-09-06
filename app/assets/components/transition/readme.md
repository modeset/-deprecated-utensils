
# Transition
Contains helper classes added and removed via JavaScript for css
transitions.

```sass
@import utensils/components/transition/transition
```

## Usage

Class                  | Usage
---------------------- | -----------------------------------------------------------
`.fade`                | Transitions an element to an `opacity` of `0`
`.fade.in`             | Transitions an element to an `opacity` of `1`
`.collapse`            | Transitions an element to a `height` of `0`
`.collapse.in`         | Transitions an element to a `height` of `auto`

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `transition.sass` is loaded.

Attribute                  | Default             | Description
-------------------------- | ------------------- | -------------------------------------------
`$fade-duration`            | `$speed`             | Duration to fade the element
`$fade-timing-function`     | `linear`             | Timing equation to fade the element
`$collapse-duration`        | `$speed`             | Duration to collapse or expand the element
`$collapse-timing-function` | `$ease-in-out-quart` | Timing equation to fade the element

