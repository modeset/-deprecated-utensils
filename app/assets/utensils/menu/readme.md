
# Menu
The menu component is a simple list of navigation elements, which are
typically used within the `Drop` component.

```sass
@import utensils/menu/menu
```

## Usage Example
<!--~ markup/menu.html.haml -->


## Style Settings
To override the default settings, set the variable and it's value within
your `config.sass` file or before `menu.sass` is loaded.

Variable           | Default            | Description
------------------ | ------------------ | -------------------------------------------
`$menu-bgc`        | `$base-bgc`        | The `background-color` of the menu component
`$menu-bgc-hover`  | `$base-bgc-hover`  | The `background-color` of the menu link when hovered
`$menu-bgc-active` | `$base-bgc-active` | The `background-color` of the menu link when active
`$menu-border`     | `$base-border`     | The `border-color` of the menu component and dividers for link elements
`$menu-radii`      | `$radii`           | The `border-radius` of the menu component

