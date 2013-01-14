# Mirror
Applies a reflection on the element. The element, is typically images or
video, but can be applied to any element.

_Warning!_ This is currently only supported by some choice `webkit`
browsers.


[<~Example](markup/mirror.html.haml)


## Style Settings

```sass
@import utensils/mirror
```
To override the default settings, set the variable and it's value
within your `config.sass` file or before `mirror.sass` is loaded.

Variable             | Default             | Description
-------------------- | ------------------- | ------------------------------------
`$mirror-direction`  | `below`             | The direction for the mirror (`above`, `below`, `left`, `right`)
`$mirror-distance`   | `2px`               | The distance to pull the mirror from the object
`$mirror-from-color` | `transparent`       | The starting `color` in the gradient
`$mirror-color-stop` | `0.75, transparent` | The position and `color` for the stop
`$mirror-to-color`   | `rgba(black, 0.2)`  | The final `color` in the gradient


## Todo
- Make this a cross browser supported style
- This might be better as a mixin/placeholder

