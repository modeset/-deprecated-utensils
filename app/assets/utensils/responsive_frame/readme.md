# Responsive frame
Scales an `iframe` proportionally based on the initial `width` and
`height` attributes. Responsive frame is typically used with embedded
videos.


[<~Example](markup/responsive_frame.html.haml)


## Options

Attribute           | Default            | Description
------------------- | ------------------ | ------------------------------------
`namespace`         | `responsive_frame` | The name space to use for dispatching events

If a `width` and `height` attribute is not found, the ratio defaults to
`16:9`.


## API
```coffee
#= require responsive_frame
```

```haml
data-bindable="responsive-frame"
```


### #resize
Calls the resize event to scale the `iframe`.

```coffee
@responsive_frame.resize()
```

### #dispose
Remove the `ResponsiveFrame` behavior and stops listening to `window`
`resize` events.

```coffee
@responsive_frame.dispose()
```

### Requires
```coffee
utensils/utensils
utensils/bindable
```

