
# Pop
Pops are a more robust `Tip`. They are built for holding small bits of
information, media or other secondary content, which is predominantly
triggered through a `click` event. They can be assembled via
`data` attributes or reference a hidden element within the DOM to
inject into a `Pop` container. Positioning is defined by cardinal
points.


```sass
@import utensils/components/pop/pop
```

```html
data-bindable="pop"
```

## Usage Examples

<!--~ markup/pop.html.haml -->
```haml
%nav
  %ul.nav.inline
    %li<
      %a#pop_north(data-bindable="pop" data-delay="100" title="The Northern Pop" data-content="North is way up there, just hanging out with the Canadians." href="#") Northern Pop
    %li<
      %a#pop_south(data-bindable="pop" data-placement="south" data-delay="1000,2000" title="The Southern Pop" data-content="South is where the snow goes in the summer. You should go there."  href="#") Southern Pop
    %li<
      %a#pop_east(data-bindable="pop" data-trigger="hover" data-placement="east" title="The Eastern Pop" data-content="East Coast hip-hop in the 90s is about as good as it gets."  href="#") Eastern Pop
    %li<
      %a#pop_west(data-bindable="pop" data-placement="west" title="<h2>The Western Pop</h2>" data-content="At some point the West Coast is just going to drop into the Pacific." href="#") Western Pop
    %li<
      %a#pop_no_title(data-bindable="pop" data-placement="north" data-content="Check me out, rolling with no title and all. Total chaos."  href="#") No Title
    %li<
      %a#pop_selector(data-bindable="pop" href="#pop_exterior_content") Exterior Content

.hidden#pop_exterior_content(data-placement="west" data-toggle="in" data-delay="activate: 1000, deactivate:0" data-bubble="true")
  .pop.fade
    .pop-arrow
    .pop-inner
      .pop-header
        %h3 Exterior content
      .pop-content(style="width: 260px; height:180px;")
        %img(src="/assets/snow-260x180.png")
```
<!-- end -->

## Options

Attribute   | Default     | Description
----------- | ----------- | -------------------------------------------
`toggle`    | `active in` | Overrides `Togglable's` default of `active`
`trigger`   | `click`     | The event to trigger toggle behavior [`click`, `hover`, `focus`, `manual`]
`title`     | `""`        | The title (html or text) to insert for the header when "_is tip like_"
`content`   | `""`        | The content (html or text) to insert for the body when "_is tip like_"
`placement` | `north`     | Where to position the pop in relation to the element: `north`, `south`, `east`, `west`
`effect`    | `fade`      | The base animation class to add to the tip markup
`href`      | _none_      | Optional DOM element `id` for the contents and `data-attributes` to use for the contents of the `Pop` 

Referencing "_is tip like_" means the contents of the `Pop` reside within
the `data` attributes of the link. When a `Pop` "_is not tip like_", it
references a `hidden` DOM element.

See `Togglable` for other options 

###### Notes  
- **Heads Up!** `Pop` will override it's placement automatically through
  `Directional` if it determines the requested position will render the
  pop outside the viewport.


### Referencing DOM elements
If the binded `pop` element has no `data-content` attribute, then `Pop`
searches for the element in the DOM by the `id` given in the `href` or
the `data-target` attribute. This element should have an outer container
containing the markup and `data-attribute` options to be used with the
`Pop`. This markup is blown away from the DOM and stored internally the
first time the `Pop` is activated. It's a good idea to include the
`.hidden` or `.visuallyhidden` class on the container to keep it from
appearing on screen initially.

###### Notes
- **Pro Tip!** This is the preferred behavior for creating more complex
  `Pop` components


## API

### #new
Create a new instance of `Pop` programmatically. Normally this is
handled through `Bindable`. 

```coffee
#= require pop

@el = $('#pop')
@pop = new utensil.Pop(@el, {target:'#pop_exterior_content'})
```

### #toggle
Typically called through user input, but can be triggered by the
elements toggle event.

```coffee
@el.trigger('click')
```

### #activate
Show the pop

```coffee
@pop.activate()
```

### #deactivate
Removes the pop

```coffee
@pop.deactivate()
```

### #dispose
Remove the pop behavior

```coffee
@pop.dispose()
```

### Requires
- `utensil`
- `bindable`
- `detect`
- `togglable`
- `directional`

`Pop` utilizes `Togglable` via composition.


## Style Settings
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


###### Warning
- **Heads Up!** The configuration file needs to define the `$zindex-pop`
value before this file is imported, this is done to keep managing
`z-index` mappings in one place.


## Injected Markup
The markup injected when a pop is shown:

```html
<div class="pop north fade">
 <div class="pop-arrow"></div>
 <div class="pop-inner">
   <div class="pop-header">The Western Pop</div>
   <div class="pop-content">
     <p>A bunch of killer content</p>
   </div>
 </div>
</div>
```


## Todo:
- Multiple pops?
- Depth swapping?
- disable on body click?

