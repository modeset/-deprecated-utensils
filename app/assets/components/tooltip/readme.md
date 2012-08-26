
# Tooltip

Tool tip component for showing quick bits of information to a user. Tips
are generally used on `hover` states, but can be tied to any event
trigger. `Tooltip` is inspired by
[tipsy](https://github.com/jaz303/tipsy) and [component/tip](https://github.com/component/tip)


## Usage

```haml
%a(data-bindable="tooltip" data-placement="north" title="The Northern Tooltip" href="#" data-delay="500") North
|
%a(data-bindable="tooltip" data-placement="south" title="The Southern Tooltip" href="#" data-delay="1000,2000") South
|
%a(data-bindable="tooltip" data-placement="east" title="The Eastern Tooltip" href="#") East
|
%a(data-bindable="tooltip" data-placement="west" title="The Western Tooltip" href="#") West
|
%a(data-bindable="tooltip" data-placement="south" title="<img src='http://placehold.it/350x150'/>" href="#") Image
```


## Options

Attribute   | Default    | Description
----------- | ---------- | -------------------------------------------
`toggle`    | `in`       | Overrides `Toggler's` default of `active`
`trigger`   | `hover`    | Overrides `Toggler's` default of `click`, unless it's a touch enabled device
`target`    | `body`     | The element in which to append the tool tip markup (note this does not get the toggle classes)
`lookup`    | `closest`  | Overrides `Toggler's` default behavior of `find`
`title`     | `""`       | The content (html or text) to insert for the tip, use the actual `title` attribute
`placement` | `north`    | Where to position the tip in relation to the element: `north`, `south`, `east`, `west`
`effect`    | `fade`     | The base animation class to add to the tip markup
`delay`     | `0`        | The amount of time in milliseconds to delay on show and hide, see notes below

_See Toggler for other options_  

When using the delay attribute, you can optionally pass a basic object
with two `number` values. The values must be separated by a `,`. The
first number is the delay for showing the tip, the second is the delay
time for hiding the tip. The following all end up computing a delay
object of `{show:1000, hide:2000}`

```html
data-delay="1000, 2000"
data-delay="show:1000, hide:2000"
data-delay="{show:1000, hide:2000}"
data-delay="hide:1000, show:2000"
```

Notes:  

- **Heads Up!** `Tooltip` will override it's placement automatically if it
  determines the requested position will render the tip outside the
  viewable area.
- **Touch it!** On touch devices when using [modernizr](http://www.modernizr.com/), tips will change
  their trigger behavior to `click` events. If the item is a link that
  resolves, make sure to add `data-bubble="true"` to the element


## API

### #new
Create a new `Tooltip` instance programmatically. Normally this is
handled through `Bindable`. 

```coffee
#= require tooltip

@el = $('#tip')
@tip = new roos.Tooltip(@el, {delay:'show:1000, hide:2000'})
```
### #toggle
This is normally handled through events, but you can always `trigger` the
element's toggle event

```coffee
@el.trigger('hover')
```

### #activate
Show the tool tip immediately

```coffee
@tip.activate()
```

### #deactivate
Removes the tool tip

```coffee
@tip.deactivate()
```
### #remove
Removes the tool tip immediately

```coffee
@tip.remove()
```

### #dispose
Remove the tool tip behavior

```coffee
@tip.dispose()
```

### Requires
- namespace
- bindable
- support
- toggler

`Tooltip` is a subclass of `Toggler`.

## Style Settings

Attribute         | Default    | Description
----------------- | ---------- | -------------------------------------------
`$tip-bgc`        | `$black`   | Sets the `background-color` of the tip and arrow
`$tip-color`      | `$white`   | Sets the `color` of the font within the tip
`$tip-radii`      | `$radii`   | Sets the `border-radius` value of the tool tip
`$tip-offset`     | `2px`      | The amount to offset each tip from their target
`$tip-opacity-in` | `0.9`      | The opacity value to apply when the tip is shown
`$zindex-tips`    | `1010`     | The `z-index` value tips sit on

_To override the default settings, set the variable and it's value
within your `config.sass` file or before `tooltip.sass` is loaded._


## Injected Markup

The markup injected when a tip is shown:

```html
<div class="tooltip north fade">
 <div class="tooltip-arrow"></div>
 <div class="tooltip-inner">The Northern Tooltip</div>
</div>
```

