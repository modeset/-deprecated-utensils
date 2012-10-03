
# Drop
Drops are used for displaying a menu within a navigation or button group
system.

Drop's utilize a `visuallyhidden` and `visuallyshown` technique rather
than a `display: none|block` to allow screen readers to still discover
the inner content.

Drop requires the `menu` component for styles.

```sass
@import utensils/components/drop/drop
```

```html
data-bindable="drop"
```

## Usage Example

<!--~ markup/drop.html.haml -->
```haml
%h5(style="margin-bottom:1em;") Drops in Navigation

%nav
  %ul.nav.inline
    %li.drop(data-bindable="drop")<
      %a(href="#") Drop Normal <span class="caret"></span>
      %ul.nav.menu(data-bindable="togglable-group")
        %li<
          %a(href="#") Subnav 1-1
        %li<
          %a(href="#") Subnav 1-2
        %li<
          %a(href="#") Subnav 1-3
    %li.drop(data-bindable="drop" data-placement="north")<
      %a(href="#") Drop North <span class="caret"></span>
      %ul.nav.menu(data-bindable="togglable-group")
        %li<
          %a(href="#") Subnav 2-1
        %li<
          %a(href="#") Subnav 2-2
        %li<
          %a(href="#") Subnav 2-3


%h5(style="margin-bottom:1em; margin-top:2em;") Drops in Button Toolbar

%section.button-toolbar
  %nav.button-group
    %ul.nav
      %li.drop(data-bindable="drop" data-trigger="hover")<
        %a(href="#") Drop Hover <span class="caret"></span>
        %ul.nav.menu(data-bindable="togglable-group")
          %li<
            %a(href="#") Subnav 1
          %li<
            %a(href="#") Subnav 2
          %li<
            %a(href="#") Subnav 3

  %nav.button-group
    %a.btn.drop(href="#" data-bindable="drop") Drop Button <span class="caret"></span>
    %ul.nav.menu(data-bindable="togglable-group")
      %li<
        %a(href="#") Drop 2 Subnav 1
      %li<
        %a(href="#") Drop 2 Subnav 2
      %li<
        %a(href="#") Drop 2 Subnav 3

  %nav.button-group
    %a.btn Action
    %a.btn.drop(data-bindable="drop" data-placement="east" data-related="#menu_split" data-related-toggle="in" data-delay="500") <span class="caret"></span>
    %ul.nav.menu#menu_split.fade(data-bindable="togglable-group")
      %li<
        %a(href="#") Drop 2 Subnav 1
      %li<
        %a(href="#") Drop 2 Subnav 2
      %li<
        %a(href="#") Drop 2 Subnav 3

%h5(style="margin-bottom:1em; margin-top:2em;") Drops in Group

%nav#drop_group_demo
  %ul.nav.inline(data-bindable="togglable-group")
    %li<
      %a(href="#") Group One
    %li<
      %a(href="#") Group Two
    %li.drop(data-bindable="drop" data-group=".inline")
      %a(href="#") Drop <span class="caret"></span>
      %ul.nav.menu
        %li<
          %a(href="#") Group Four
        %li<
          %a(href="#") Group Five
        %li<
          %a(href="#") Group Six
```
<!-- end -->

## Options

Attribute   | Default         | Description
----------- | --------------- | -------------------------------------------
`toggle`    | `active active` | Overrides `Togglable's` default of `active`
`placement` | `south`         | Where to position the drop menu in relation to the element: `north`, `south`, `east`, `west`
`keyboard`  | `true`          | Utilize some basic key commands for controlling the menu

See `Togglable` for other options 

###### Notes  
- **Heads Up!** `Drop` will override it's placement automatically
  through `Directional` if it determines the requested position will
  render the `menu` outside the viewport.

## API

### #new
Create a new instance of `Drop` programmatically. Normally this is
handled through `Bindable`. 

```coffee
#= require drop

@el = $('#drop')
@drop = new utensil.Drop(@el, {placement: 'west'})
```

### #toggle
Typically called through user input, but can be triggered by the
elements toggle event.

```coffee
@el.trigger('click')
```

### #activate
Show the drop

```coffee
@drop.activate()
```

### #deactivate
Removes the drop

```coffee
@drop.deactivate()
```

### #dispose
Remove the drop behavior

```coffee
@drop.dispose()
```

### Requires
- `utensil`
- `bindable`
- `togglable`
- `directional`

`Drop` utilizes `Togglable` via composition.

## Style Settings
To override the default settings, set the variable and it's value within
your `config.sass` file or before `drop.sass` is loaded.

Variable               | Default  | Description
---------------------- | -------- | -------------------------------------------
`$drop-menu-min-width` | `160px`  | The `min-width` of the `menu`

Other default styles are set up through either `caret.sass` or
`menu.sass`

###### Warning
- **Heads Up!** The configuration file needs to define the `$zindex-drop`
value before this file is imported, this is done to keep managing
`z-index` mappings in one place.

## Todo
- Clicking on another item, html or drop should deactivate existing menu items
- Clicking on the drop within a group needs to stopPropagation (see tab)
- Exit animations do not occur since the `.visuallyhidden` class is
  applied at the same time a transition occurs. Not sure if this should
  be added in here or through an extension of `Drop`?

###### Alert
- **Heads Up!** Drop is not yet feature complete, it's missing some core
  functionality at the moment.

