# Cursor Hand
The CursorHand `.js/css` combination provides a nice cross-browser way
to have a hand-grab cursor, a-la Google Maps' interface.

By default, CursorHand will add or remove a class on the `<body>`
element when the cursor state needs to change. An optional html element
can be passed in to the CursorHand constructor, which would toggle the
class instead, in case of css scoping needs.

[<~Example](markup/cursor_hand.html.haml)


## API
```coffee
#= require utensils/cursor_hand
```

### #new
Typically cursor hand is required via a class that needs it, i.e.
Carousel, Slider, TouchScroller, etc..


```coffee
#= require cursor_hand

cursor = new utensils.CursorHand()
```

### Requires
```coffee
utensils/utensils
```


## Style Settings
```sass
@import utensils/cursor_hand/cursor_hand
```

To override the default settings, set the variable and it's value
within your `config.sass` file or before `cursor_hand.sass` is loaded.

Variable                   | Default                                | Description
-------------------------- | -------------------------------------- | -------------------------------------------
`$cursor-open-hand-path`   | `"cursor_hand/cursors/openhand.cur"`   | The default path to find the open hand cursor
`$cursor-closed-hand-path` | `"cursor_hand/cursors/closedhand.cur"` | The default path to find the closed hand cursor

**Heads Up!** These images are automatically included into the asset
pipeline through Utensils.


## Todo
- Test

