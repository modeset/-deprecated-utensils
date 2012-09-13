
# Scaffold
Sets up main scaffolding elements for `html`, `body`, selections, links and navigation.

```sass
@import utensils/components/scaffold/scaffold
```

## Usage Example

The base `.nav` is the building block for navigation structures and components
(tabs, pills, breadcrumbs, pagination and navigation lists). The `.nav` class
can be used for simple navigation as well.

<!--~ markup/scaffold-nav.html.haml -->
```haml
%nav
  %ul.nav(data-bindable="togglable-group")
    %li
      %a(href="#") Block Link 1
    %li.active
      %a(href="#") Block Link 2
    %li
      %a(href="#") Block Link 3
%br
%nav
  %ul.nav.inline(data-bindable="togglable-group")
    %li
      %a(href="#") Inline Link 1
    %li.active
      %a(href="#") Inline Link 2
    %li
      %a(href="#") Inline Link 3
```
<!-- end -->

###### Warnings
- **Heads Up!** All navigation components depend on the `.nav` class being attached to the container element

###### Notes
- **Pro Tip!** For convenience, add the `inline` class to the `.nav` element to display the base nav inline

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `scaffold.sass` is loaded.

Variable                    | Default                    | Description
--------------------------- | -------------------------- | -------------------------------------------
`$body-family`              | `$sans-family`             | The body's `font-family`
`$body-color`               | `$base-color`              | The body's text `color`
`$body-background`          | `$base-bgc`                | The body's `background`
`$select-color`             | `white`                    | The selected text's `color`
`$select-bgc`               | `$primary`                 | The selected text's `background`
`$tap-highlight`            | `$link-color`              | The `tap-highlight-color` for touch devices
`$nav-inline-padding-left`  | `0.5em`                    | The `padding-left` on the `.nav.inline` element
`$nav-inline-padding-right` | `$nav-inline-padding-left` | The `padding-right` on the `.nav.inline` element

