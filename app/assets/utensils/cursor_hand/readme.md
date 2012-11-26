
# Cursor Hand
The CursorHand .js/css combination provides a nice cross-browser way to have a hand-grab cursor, a-la Google Maps' interface.

By default, CursorHand will add or remove a class on the `<body>` element when the cursor state needs to change. An optional
html element can be passed in to the CursorHand constructor, which would toggle the class instead, in case of css scoping needs.

```sass
@import utensils/cursor_hand/cursor_hand
```

## Usage Examples
<!--~ markup/cursor_hand.html.haml -->


## API
Typically cursor hand is required via a class that needs it, i.e. Carousel, Slider, TouchScroller, etc..


### #new
```coffee
#= require cursor_hand

cursor = new utensils.CursorHand()
```

### Requires
- `utensils/utensils`


## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `cursor_hand.sass` is loaded.

Variable                   | Default                            | Description
-------------------------- | ---------------------------------- | -------------------------------------------
`$cursor-open-hand-path`   | `"/assets/cursors/openhand.cur"`   | The default path to find the open hand cursor
`$cursor-closed-hand-path` | `"/assets/cursors/closedhand.cur"` | The default path to find the closed hand cursor

