# Carousel
The base carousel.

[<~Example](markup/carousel.html.haml)

## Options

Attribute           | Default         | Description
------------------- | --------------- | -------------------------------------------
`namespace`         | `carousel`      | The namespace to use for dispatching events
`toggle`            | `active in`     | The classes to add to an active a carousel panel
`keyboard`          | `true`          | Whether to allow the keyboard directional arrows to control next and previous slides
`activate`          | `0`             | A number or string to find the starting index panel for display
`paddles`           | `.paddle-icon`  | The element container to search for paddle buttons
`autoplay`          | `false`         | Whether to allow the carousel to auto play and cycle through slides
`cycles`            | `1`             | The number of cycles to perform before stopping in `auto play` mode
`duration`          | `5`             | The delay between slides in `auto play` mode

**Heads Up!** When utilizing paddle buttons, the `href` attribute is used to determine
which method to call when clicked (i.e. `#next` or `#prev`).

When set to `auto play`, `Carousel` will instantiate a `Beacon` object
for time management.


## API
```coffee
#= require utensils/carousel
```

```haml
data-bindable="carousel"
```

### #new
Create a new instance of `Carousel`, typically used via `Bindable`. 

```coffee
#= require utensils/carousel
@carousel = new utensils.Carousel @el.find '.carousel'
```

### #next
Advance to the next slide panel, dispatches a `carousel:next` event.

```coffee
@carousel.next()
```

### #prev
Advance to the previous slide panel, dispatches a `carousel:prev` event.

```coffee
@carousel.prev()
```

### #activate
Jump to a given slide based on an index, dispatches a
`carousel:activated` event.

```coffee
@carousel.activate 2
```

### #pause
Pause a carousel, only available while in `auto play` mode, dispatches a
`carousel:paused` event.

```coffee
@carousel.pause()
```

### #restart
Restart a carousel after a pause in the action, only available while in
`auto play` mode, dispatches a `carousel:restarted` event.

```coffee
@carousel.restart()
```

### #dispose
Kill it with fire.

```coffee
@carousel.dispose()
```

## Style Settings
```sass
@import utensils/carousel/carousel
```

To override the default settings, set the variable and it's value
within your `config.sass` file or before `carousel.sass` is loaded.

Variable            | Default        | Description
------------------- | -------------- | -------------------------------------------
`$carousel-height`  | `400px`        | The default `height` of the carousel

The styles associated with a `Carousel` are mainly associated with
structure. See `Paddles` for `paddle-icon` styles.

