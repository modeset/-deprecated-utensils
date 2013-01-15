# Full Bleed
Scales an image proportionally to the `width` of the browser window.
Passing `data-fills-window="false"` will constrain the height of the
image to the height of `.full-bleed` container.

## Usage


```haml
%section.full-bleed#fill_window(data-bindable="full-bleed")
  %img(src="http://placehold.it/800x450" alt="fpo" width="800" height="450")

%section.full-bleed#no_fill_window(data-bindable="full-bleed" data-fills-window="false")
  %img(src="http://placehold.it/800x450" alt="fpo" width="800" height="450")
```

[&raquo; View Full Bleed Demo](/full-bleed)  
[&raquo; View Constrained Bleed Demo](/full-bleed-constrained)



## Options

Attribute           | Default            | Description
------------------- | ------------------ | ------------------------------------
`namespace`         | `full_bleed`       | The name space to use for dispatching events
`cropType`          | `CROP`             | The type of crop to use (`CROP`, `CROP_TOP`, `CROP_BOTTOM`, `LETTERBOX`)
`fillsWindow`       | `true`             | Whether to fill the browser window or constrain to the height of the `container`

_Heads Up!_ When setting the `fillsWindow` property to `false`, the height
of the container needs to be set within the Sass file.


## API
```coffee
#= require full_bleed
```

```haml
data-bindable="full-bleed"
```

### #resize
Calls the resize event to scale the inner contents.

```coffee
@full_bleed.resize()
```

### #dispose
Remove the `FullBleed` behavior.

```coffee
@full_bleed.dispose()
```

### Requires
```coffee
utensils/utensils
utensils/bindable
utensils/image_crop
```


## Style Settings

```sass
@import utensils/full_bleed
```
To override the default settings, set the variable and it's value
within your `config.sass` file or before `full_bleed.sass` is loaded.

Variable             | Default            | Description
-------------------- | ------------------ | -----------------------------------
`$full-bleed-height` | `auto`             | The `height` of the container
`$full-bleed-zindex` | `-1`               | The `z-index` depth for the `.full-bleed` container

