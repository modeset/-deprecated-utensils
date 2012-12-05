# Pop
Pops are a more robust `Tip`. They are built for holding small bits of
information, media or other secondary content, which is predominantly
triggered through a `click` event. They can be assembled via
`data` attributes or reference a hidden element within the DOM to
inject into a `Pop` container. Positioning is defined by cardinal
points.

[<~Example](markup/pop.html.haml)


## Options

Attribute   | Default     | Description
----------- | ----------- | -------------------------------------------
`namespace` | `pop`       | The namespace to use for dispatching events
`toggle`    | `active in` | Overrides `Triggerable's` default of `active`
`trigger`   | `click`     | The event to trigger toggle behavior [`click`, `hover`, `focus`, `manual`]
`title`     | `""`        | The title (html or text) to insert for the header when "is tip like"
`content`   | `""`        | The content (html or text) to insert for the body when "is tip like"
`placement` | `north`     | Where to position the pop in relation to the element: `north`, `south`, `east`, `west`
`effect`    | `fade`      | The base animation class to add to the tip markup
`href`      | _none_      | Optional DOM element `id` for the contents and `data-attributes` to use for the contents of the `Pop`

**Heads Up!** `Pop` will override it's placement automatically through
`Directional` if it determines the requested position will render the
pop outside the viewport.

Referencing "is tip like" means the contents of the `Pop` reside within
the `data` attributes of the link. When a `Pop` "is not tip like", it
references a `hidden` DOM element.

See `Triggerable` for other options.


### Referencing DOM elements
If the binded `pop` element has no `data-content` attribute, then `Pop`
searches for the element in the DOM by the `id` given in the `href` or
the `data-target` attribute. This element should have an outer container
containing the markup and `data-attribute` options to be used with the
`Pop`. This markup is blown away from the DOM and stored internally the
first time the `Pop` is activated. It's a good idea to include the
`.hidden` or `.visuallyhidden` class on the container to keep it from
appearing on screen initially.

**Pro Tip!** This is the preferred behavior for creating more complex
`Pop` components.


## API
```coffee
#= require utensils/pop
```

```haml
data-bindable="pop"
```

### #new
Create a new instance of `Pop` programmatically. Normally this is
handled through `Bindable`.

```coffee
#= require pop

@el = $('#pop')
@pop = new utensils.Pop @el, target: '#pop_exterior_content'
```

### #toggle
Typically called through user input, but can be triggered by the
elements toggle event.

```coffee
@el.trigger 'click'
```

### #activate
Show the pop.

```coffee
@pop.activate()
```

### #deactivate
Removes the pop.

```coffee
@pop.deactivate()
```

### #dispose
Remove the pop behavior.

```coffee
@pop.dispose()
```

### Requires
```coffee
utensils/utensils
utensils/bindable
utensils/triggerable
utensils/detect
utensils/directional
```

`Pop` utilizes `Triggerable` via composition.


## Style Settings
```sass
@import utensils/pop/pop
```

To override the default settings, set the variable and it's value
within your `config.sass` file or before `pop.sass` is loaded.

Variable                  | Default                | Description
------------------------- | ---------------------- | -------------------------------------------
`$pop-bgc`                | `$base-bgc`            | The `background-color` of the pop
`$pop-border`             | `$base-border`         | The `border-color` of the pop
`$pop-radii`              | `$radii`               | The `border-radius` value of the pop
`$pop-offset`             | `10px`                 | The amount to offset each pop from their target
`$pop-header-bgc`         | `$base-bgc-active`     | The `background-color` of the `.pop-header`
`$pop-header-font-weight` | `bold`                 | The `font-weight` of the header (has very low specificity)
`$pop-header-font-size`   | `$base-font-size + 2`  | The `font-size` of the header (has very low specificity)
`$pop-arrow-bgc`          | `$pop-bgc`             | The `background-color` of the foreground arrow
`$pop-arrow-border`       | `$pop-border`          | The `background-color` of the background arrow
`$pop-arrow-size`         | `10px`                 | The size of the arrow (this has a pretty distinct relation to `$pop-offset`)
`$pop-arrow-border-size`  | `$pop-arrow-size + 2`  | The `width` of the background arrow creating the border effect
`$pop-arrow-offset`       | `-$pop-arrow-size + 1` | The offset against the background arrow


_Warning!_ The configuration file needs to define the `$zindex-pop`
value before this file is imported, this is done to keep managing
`z-index` mappings in one place.

