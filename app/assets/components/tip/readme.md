
# Tip
Tool tip component for showing quick bits of information to a user. Tips
are generally used on `hover` states, but can be tied to any event
trigger. `Tip` is inspired by
[tipsy](https://github.com/jaz303/tipsy) and [component/tip](https://github.com/component/tip)

```sass
@import utensils/components/tip/tip
```

```html
data-bindable="tip"
```

## Usage Examples

<!--~ markup/tip.html.haml -->
```haml
%nav
  %ul.nav.inline
    %li
      %a#north(data-bindable="tip" data-delay="100" data-target=".sherpa-wrapper" title="The Northern Tip" href="#") Northern Tip
    %li
      %a#south(data-bindable="tip" data-placement="south" data-delay="1000,2000" title="The Southern Tip" href="#") Southern Tip
    %li
      %a#east(data-bindable="tip" data-placement="east" title="The Eastern Tip" href="#") Eastern Tip
    %li
      %a#west(data-bindable="tip" data-placement="west" title="The Western Tip" href="#") Western Tip
    %li
      %a#image(data-bindable="tip" data-placement="south" data-trigger="click" title="<img src='/assets/snow-260x180.png'/>" href="#") Image Tip (click)
```
<!-- end -->


## Options

Attribute   | Default    | Description
----------- | ---------- | -------------------------------------------
`toggle`    | `in`       | Overrides `Toggler's` default of `active`
`trigger`   | `hover`    | Overrides `Toggler's` default of `click`, unless it's a touch enabled device
`target`    | `body`     | The element in which to append the tip markup (note this does not get the toggle classes)
`lookup`    | `closest`  | Overrides `Toggler's` default behavior of `find`
`title`     | `""`       | The content (html or text) to insert for the tip, use the actual `title` attribute
`placement` | `north`    | Where to position the tip in relation to the element: `north`, `south`, `east`, `west`
`effect`    | `fade`     | The base animation class to add to the tip markup
`delay`     | `0`        | The amount of time in milliseconds to delay on show and hide, see notes below

_See `Toggler` for other options_  

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

###### Notes  

- **Heads Up!** `Tip` will override it's placement automatically if it
  determines the requested position will render the tip outside the
  viewable area.
- **Touch it!** On touch devices when using [modernizr](http://www.modernizr.com/), tips will change
  their trigger behavior to `click` events. If the item is a link that
  resolves, make sure to add `data-bubble="true"` to the element


## API

### #new
Create a new `Tip` instance programmatically. Normally this is
handled through `Bindable`. 

```coffee
#= require tip

@el = $('#tip')
@tip = new utensil.Tip(@el, {delay:'show:1000, hide:2000'})
```

### #toggle
This is normally handled through events, but you can always `trigger` the
element's toggle event

```coffee
@el.trigger('hover')
```

### #activate
Show the tip immediately

```coffee
@tip.activate()
```

### #deactivate
Removes the tip

```coffee
@tip.deactivate()
```

### #remove
Removes the tip immediately

```coffee
@tip.remove()
```

### #dispose
Remove the tip behavior

```coffee
@tip.dispose()
```

### Requires
- `utensil`
- `bindable`
- `detect`
- `toggler`

`Tip` is a subclass of `Toggler`.

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `tip.sass` is loaded.

Variable          | Default    | Description
----------------- | ---------- | -------------------------------------------
`$tip-color`      | `white`    | The text `color` of the tip
`$tip-bgc`        | `black`    | The `background-color` of the tip and arrow
`$tip-radii`      | `$radii`   | The `border-radius` value of the tip
`$tip-offset`     | `2px`      | The amount to offset each tip from their target
`$tip-opacity-in` | `0.9`      | The opacity value to apply when the tip is shown
`$zindex-tips`    | `1010`     | The `z-index` value tips sit on

## Injected Markup
This markup is injected when a tip is shown:

```html
<div class="tip north fade">
 <div class="tip-arrow"></div>
 <div class="tip-inner">The Northern Tip</div>
</div>
```

