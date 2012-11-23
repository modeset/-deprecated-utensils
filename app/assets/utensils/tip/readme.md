
# Tip
Tool tip component for showing quick bits of information to a user. Tips
are generally used on `hover` states, but can be tied to any event
trigger. Positioning is defined by cardinal points.

`Tip` is structured for very simple use cases, mainly dealing with tool
tip type behavior. Generally the `Pop` component is more robust and
should be considered in most cases.

```sass
@import utensils/tip/tip
```

```html
data-bindable="tip"
```

## Usage Examples
<!--~ markup/tip.html.haml -->


## Options

Attribute   | Default     | Description
----------- | ----------- | -------------------------------------------
`namespace` | `tip`       | The namespace to use for dispatching events
`toggle`    | `active in` | Overrides `Triggerable's` default of `active`
`trigger`   | `hover`     | Overrides `Triggerable's` default of `click`, unless it's a touch enabled device
`title`     | `""`        | The content (html or text) to insert for the tip, use the actual `title` attribute though
`placement` | `north`     | Where to position the tip in relation to the element: `north`, `south`, `east`, `west`
`effect`    | `fade`      | The base animation class to add to the tip markup

See `Triggerable` for other options


###### Notes
- **Heads Up!** `Tip` will override it's placement automatically through
  `Directional` if it determines the requested position will render the
  tip outside the viewport.
- **Touch it!** On touch devices when using
  [modernizr](http://www.modernizr.com/), tips will change their trigger
  behavior to `click` events. If the item is a link that resolves, make
  sure to add `data-bubble="true"` to the element


## API

### #new
Create a new instance of `Tip` programmatically. Normally this is
handled through `Bindable`.

```coffee
#= require tip

@el = $('#tip')
@tip = new utensils.Tip(@el, {delay:'show:1000, hide:2000'})
```

### #toggle
Typically called through user input, but can be triggered by the
elements toggle event.

```coffee
@el.trigger('mouseenter')
```

### #activate
Show the tip

```coffee
@tip.activate()
```

### #deactivate
Removes the tip

```coffee
@tip.deactivate()
```

### #dispose
Remove the tip behavior

```coffee
@tip.dispose()
```

### Requires
- `utensils/utensils`
- `utensils/bindable`
- `utensils/triggerable`
- `utensils/detect`
- `utensils/directional`

`Tip` utilizes `Triggerable` via composition.


## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `tip.sass` is loaded.

Variable            | Default               | Description
-----------------   | ----------            | -------------------------------------------
`$tip-bgc`          | `black`               | The `background-color` of the tip and arrow
`$tip-color`        | `white`               | The text `color` of the tip
`$tip-font-size`    | `$base-font-size - 2` | The `font-size` for tips
`$tip-radii`        | `$radii`              | The `border-radius` value of the tip
`$tip-offset`       | `2px`                 | The amount to offset each tip from their target
`$tip-opacity-in`   | `0.9`                 | The opacity value to apply when the tip is shown
`$tip-arrow-bgc`    | `$tip-bgc`            | The `background-color` for the arrow
`$tip-arrow-size`   | `5px`                 | The size of the arrow
`$tip-arrow-offset` | `-$tip-arrow-size`    | The offset for positioning the arrow

###### Warning
- **Heads Up!** The configuration file needs to define the `$zindex-tip`
value before this file is imported, this is done to keep managing
`z-index` mappings in one place.


## Injected Markup
The markup injected when a tip is shown:

```html
<div class="tip north fade">
 <div class="tip-arrow"></div>
 <div class="tip-inner">The Northern Tip</div>
</div>
```

