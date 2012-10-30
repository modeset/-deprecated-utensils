
# Tab
Tabs follow the same markup structure as other navigation elements. Tabs
like other navigation elements require the `.nav` class for layout. Add
`.nav .tab` to a `ul` or `ol` element.

To utilize a drop dead simple version of hiding and showing content, add
the `data-bindable="tab"` along with an `href` attributes pointing to
the related targets panel.

```sass
@import utensils/tab/tab
```

```html
data-bindable="tab"
```

## Usage Example

<!--~ markup/tab.html.haml -->
```haml
%nav#tab_demo(role="navigation")
  %ul.nav.tab(data-bindable="tab" data-related="#tab_content" role="tablist")
    %li.active<
      %a(href="#tab_one" role="tab") Tab One
    %li<
      %a(href="#" data-target="#tab_two" role="tab") Tab Two
    %li<
      %a(href="#tab_three" role="tab") Tab Three

    %li.drop(data-bindable="drop")
      %a.drop-toggle#tab_drop(href="#") Tab Drop <span class="caret"></span>
      %ul.nav.menu(role="menu" aria-labelledby="tab_drop")
        %li<
          %a(href="#tab_four" role="tab") Tab Four
        %li<
          %a(href="#tab_five" role="tab") Tab Five
        %li<
          %a(href="#tab_six" role="tab") Tab Six

%section#tab_content.tab-content(style="margin-top:1.25em;")
  %article.tab-pane.active#tab_one(role="tabpanel")
    %p Tab content <span class="decal important">one</span>
  %article.tab-pane#tab_two(role="tabpanel")
    %p Tab content <span class="decal success">two</span>
  %article.tab-pane#tab_three(role="tabpanel")
    %p Tab content <span class="decal danger">three</span>
  %article.tab-pane#tab_four(role="tabpanel")
    %p Tab sub content <span class="decal warning">four</span>
  %article.tab-pane#tab_five(role="tabpanel")
    %p Tab sub content <span class="decal inverse">five</span>
  %article.tab-pane#tab_six(role="tabpanel")
    %p Tab sub content <span class="decal important">six</span>
```
<!-- end -->

## Options

Attribute        | Default     | Description
---------------- | ----------- | -------------------------------------------
`namespace`      | `tab`       | The namespace to use for dispatching events
`related`        | `null`      | The selector container with tabable content
`related-toggle` | `toggle`    | The class(es) to toggle when triggered on the related element

See `ToggleGroup` for more options.

## API

### #new
Create a new instance of `Tab` programatically, typically this
is instantiated through `Bindable`

```coffee
#= require tab

@tab_el = $('#tab')

@tab = new utensils.Tab(@tab_el)
```

### #activate
Activate can take either an index or element as it's target parameter.
Activating will add the toggle classes to the element. Activate will
remove the toggle classes from other elements within the group.

##### dispatches:
- `tab:activated`

```coffee
# activate by index
@tab.activate(1)

# activate by element
@tab.activate(@tab_el.find('li:nth-child(2)'))
```

### #deactivate
Deactivate can take either an index or element as it's target parameter.
Deactivating will remove the toggle classes from the element.

##### dispatches:
- `tab:deactivated`

```coffee
# deactivate by index
@tab.deactivate(1)

# deactivate by element
@tab.deactivate(@tab_el.find('li:nth-child(2)'))
```

### #dispose
Cleans up any internal references 

```coffee
@tab.dispose()
```

### Requires
- `utensils/utensils`
- `utensils/bindable`
- `utensils/toggle_group`

`Tab` utilizes `ToggleGroup` via composition.

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `tab.sass` is loaded.

Variable          | Default            | Description
----------------- | ------------------ | -------------------------------------------
`$tab-bgc`        | `$base-bgc`        | The `background-color` of the tab component
`$tab-bgc-hover`  | `$base-bgc-hover`  | The `background-color` of a tab element when hovered
`$tab-bgc-active` | `$base-bgc-active` | The `background-color` of a tab element when active
`$tab-border`     | `$base-border`     | The `border-color` of the tab component
`$tab-radii`      | `$radii`           | The `border-radius` of the tab component

