
# Menu
The menu component is a simple list of navigation elements, which are
typically used within the `Drop` component.

`Menu` is an extension of `TogglableGroup`.

```sass
@import utensils/components/menu/menu
```

```html
data-bindable="menu"
```

## Usage Example

<!--~ markup/menu.html.haml -->
```haml
%nav
  %ul.nav.menu(data-bindable="menu")
    %li<
      %a(href="#") Menu item 1
    %li.active<
      %a(href="#") Menu item 2
    %li<
      %a(href="#") Menu item 3
```
<!-- end -->

## Options

Attribute   | Default    | Description
----------- | ---------- | -------------------------------------------
`keyboard`  | `false`    | Whether the menu is navigable via the `up` and `down` arrow keys

See `TogglableGroup` for other options 

###### Notes  
- **Heads Up!** Setting the keyboard value hijacks the `up` and `down`
  arrows, this is primarily used by `Drop` when there is only a single
  menu in the viewport at a time.


## API

### #new
Create a new instance of `Menu` programmatically. Normally this is
handled through `Bindable` or via `Drop`.

```coffee
#= require menu

@el = $('#menu')
@menu = new utensil.Menu(@el, {keyboard: true})
```

### #toggle
Typically called through user input, but can be triggered by the
elements toggle event.

```coffee
@el.trigger('click')
```

### #activate
Activate can take either an index or element as it's target parameter.
Activating will add the toggle classes to the element. Activate will
remove the toggle classes from other elements within the group.

```coffee
# activate by index
@menu.activate(target:1)

# activate by element
@menu.activate(target:@el.find('li:last-child'))
```

### #deactivate
Deactivate can take either an index or element as it's target parameter.
Deactivating will remove the toggle classes from the element.

```coffee
# deactivate by index
@menu.deactivate(target:1)

# deactivate by element
@menu.deactivate(target:@el.find('li:last-child'))
```

### #next
Select the next menu item in the list (stops at the bottom)

```coffee
@menu.next()
```

### #prev
Select the previous menu item in the list (stops at the top)

```coffee
@menu.prev()
```

### #activateKeys
Enables navigation through key listeners for `up` and `down` arrows

```coffee
@menu.activateKeys()
```

### #deactivateKeys
Disables navigation through key listeners for `up` and `down` arrows

```coffee
@menu.deactivateKeys()
```

### #dispose
Cleans up any internal references and key listeners

```coffee
@menu.dispose()
```

### Requires
- `utensil`
- `bindable`
- `togglable_group`

`Menu` utilizes `TogglableGroup` via extension.

## Style Settings
To override the default settings, set the variable and it's value within
your `config.sass` file or before `drop.sass` is loaded.

Variable           | Default            | Description
------------------ | ------------------ | -------------------------------------------
`$menu-bgc`        | `$base-bgc`        | The `background-color` of the menu component
`$menu-bgc-hover`  | `$base-bgc-hover`  | The `background-color` of the menu link when hovered
`$menu-bgc-active` | `$base-bgc-active` | The `background-color` of the menu link when active
`$menu-border`     | `$base-border`     | The `border-color` of the menu component and dividers for link elements
`$menu-radii`      | `$radii`           | The `border-radius` of the menu component

