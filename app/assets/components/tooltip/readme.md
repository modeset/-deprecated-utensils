
## Tooltip

Tool tip component inspired by [tipsy](https://github.com/jaz303/tipsy). 

Color styling is automatically generated based on the inverted colors of the body's
`background-color` and font `color`.

Tooltip is a subclass of Toggler.

### Options

Attribute   | Default    | Description
----------- | ---------- | -------------------------------------------
`toggle`    | `in`       | Overrides Toggler's default of `active`
`trigger`   | `hover`    | Overrides Toggler's default of `click`
`selector`  | `body`     | The element in which to append the tool tip markup
`title`     | `""`       | The content (html or text) to insert for the tooltip, use the actual `title` attribute
`placement` | `north`    | Where to position the tooltip in relation to the element: `north`, `south`, `east`, `west`
`effect`    | `fade`     | The base animation class to add to the tooltip markup
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
- **Heads Up!** Tooltip will override it's placement automatically if it
  determines the requested placement will render the tip outside the
  viewable area.


### Usage

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

### API

#### #new

### Requires
- namespace
- bindable
- support
- toggler

