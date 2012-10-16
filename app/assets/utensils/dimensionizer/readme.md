
# Dimensionizer
Debugging tool for printing the `width` of the browser.
Useful when creating styles associated with media queries.

To use this class, simply require it from `application.js` and
instantiate it.

## Usage Examples

```haml
%a#dimensionizer_demo.btn(href="#") Activate the dimensionizer
```

###### Warnings
- **Warning!** Make sure this is turned off for production!

###### Notes
- **Pro Tip!** Clicking on the `Dimensionizer` will remove it from the DOM


## Options
The following options can be passed to override the default settings
when creating a `Dimensionizer` as the constructor's `data` object.

Property    | Default    | Description
----------- | ---------- | -------------------------------------------
`pos_x`     | `right`    | The `x` position to display the tool (`left` or `right`)
`pos_y`     | `top`      | The `y` position to display the tool (`top` or `bottom`)
`offset`    | `5`        | The offset for `pos_x` and `pos_y` as a number
`color`     | `dark`     | Passing any string value as the color will reverse the dark behavior and display it black on white


## API

### #new
Create a new `Dimensionizer` instance programmatically. 

```coffee
#= require dimensionizer

@dimensionizer = new utensils.Dimensionizer()

# Or with options
@dimensionizer = new utensils.Dimensionizer({pos_x:'left', 'pos_y:'bottom', offset:'10', color:'light'})
```

### #dispose
Remove the `Dimensionizer` from the `DOM`

```coffee
@dimensionizer.dispose()
```

### Requires
- `utensils/utensils`
- `utensils/detect`

## Todo
- turn the dimensionizer demo button to a toggle button
- should this live in a debug package outside the components?

