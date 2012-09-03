
# Scaffold
Sets up main scaffolding elements for `html`, `body`, selections, links and navigation.

```sass
@import roos/components/scaffold/scaffold
```

## Usage Example

The base `.nav` is the building block for navigation structures and components
(tabs, pills, breadcrumbs, pagination and navigation lists). The `.nav` class
can be used for simple navigation as well.

<!--~ markup/scaffold-nav.html.haml -->
```haml
%nav
  %ul.nav(data-bindable="toggler-group")
    %li
      %a(href="#") Block Link 1
    %li.active
      %a(href="#") Block Link 2
    %li
      %a(href="#") Block Link 3
%br
%nav
  %ul.nav.inline(data-bindable="toggler-group")
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

Attribute            | Default             | Description
-------------------- | ------------------- | -------------------------------------------
`$nav-padding-left`  | `1%`                | Set the `padding-left` on the `.nav.inline` element
`$nav-padding-right` | `$nav-padding-left` | Set the `padding-right` on the `.nav.inline` element

