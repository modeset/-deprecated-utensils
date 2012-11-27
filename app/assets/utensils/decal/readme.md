
# Decal
Decals are used to <span class="decal important">POP</span> information in a block of text.
They are typically used with inline elements. The default color is
equivalent to the `$inverse` status color.

It's recommended to pass a `$decal-status-list` of needed
modifiers to limit the output of generated classes.

```sass
@import utensils/decal/decal
```

## Usage Example
[<~Example](markup/decal.html.haml)


## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `decal.sass` is loaded.

Variable             | Default             | Description
-------------------- | ------------------- | -------------------------------------------
`$decal-bgc`         | `$inverse`          | default
`$decal-color`       | `white`             | default
`$decal-status-list` | `$base-status-list` | The `list` of modifier classes to include
`$decal-radii`       | `$radii`            | The `border-radius` of a decal

