# Scaffold
Sets up core scaffolding elements for `html`, `body`, selections, links
and navigation.


## Navs
The base `.nav` is the building block for navigation structures and
components (tabs, pills, breadcrumbs, pagination and navigation lists).
The `.nav` class can be used for simple navigation as well.

[<~Example](markup/scaffold_nav.html.haml)

_Warning!_ All navigation components depend on the `.nav` class being
attached to the container element

For convenience, add the `.inline` class to the `.nav` element to
display the base nav inline.

Utilize the `.nav-header` and `.nav-divider` for building simple
navigation lists.


## Tab Panels
Tab panels are typically used by `Tab` and `Pill` for showing and hiding
related content. See `Tab` for usage.


## Utility Classes
For convenience and common patterns, a few utility classes are setup in
the scaffold.

Class         | Usage
------------- | --------------------------
`.pull-left`  | Adds a `float:left` to an element
`.pull-right` | Adds a `float:right` to an element
`.cf`         | Extends the placeholder for the `clearfixer` mixin
`.ir`         | Extends the placeholder for the `ir` image replacement mixin
`.hidden`     | Extends the placeholder for the `hidden` mixin
`.shown`      | Extends the placeholder for the `shown` mixin


## Style Settings
```sass
@import utensils/scaffold/scaffold
```

To override the default settings, set the variable and it's value
within your `config.sass` file or before `scaffold.sass` is loaded.

Variable                    | Default                    | Description
--------------------------- | -------------------------- | -------------------------------------------
`$body-family`              | `$sans-family`             | The body's `font-family`
`$body-background`          | `$base-bgc`                | The body's `background`
`$body-color`               | `$base-color`              | The body's text `color`
`$select-color`             | `white`                    | The selected text's `color`
`$select-bgc`               | `$primary`                 | The selected text's `background`
`$tap-highlight`            | `$link-color`              | The `tap-highlight-color` for touch devices
`$nav-inline-padding-left`  | `0.5em`                    | The `padding-left` on the `.nav.inline` element
`$nav-inline-padding-right` | `$nav-inline-padding-left` | The `padding-right` on the `.nav.inline` element
`$nav-header-color`         | `$body-color`              | The `color` of the navigation header
`$nav-header-font-weight`   | `bold`                     | The `font-weigh` of the navigation header
`$nav-divider`              | `$base-border`             | The `border-color` of the navigation divider

