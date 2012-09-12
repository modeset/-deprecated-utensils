
# Breadcrumb
Apply the `.breadcrumb` class to the `ol` or `ul` element to provide linkable
references to nested sections within the application. Utilize a `span.divider`
for separation of links. The list should contain the `.nav` class.


```sass
@import utensils/components/breadcrumb/breadcrumb
```

## Usage Example

<!--~ markup/breadcrumb.html.haml -->
```haml
%nav
  %ol.nav.breadcrumb
    %li<
      %a(href="#") Level 1
    %li<
      %a(href="#") Level 2
    %li<
      %a(href="#") Level 3
    %li.active<
      %a(href="#") Active
```
<!-- end -->

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `caret.sass` is loaded.

Variable       | Default       | Description
-------------- | ------------- | -------------------------------------------
`$caret-width` | `4px`         | The `border-width` (size) of the caret
`$caret-color` | `$link-color` | The base `border-color` of the caret

`$breadcrumb-color`           | `$body-color-medium` | The text `color` for breadcrumbs (includes the active breadcrumb and divider)
`$breadcrumb-link-color`      | `$link-color`        | The text `color` of an active breadcrumb link
`$breadcrumb-link-hover`      | `$link-hover`        | The text `color` when a breadcrumb link is hovered
`$breadcrumb-bgc`             | `$off-white`         | The `background-color` of the breadcrumb component
`$breadcrumb-font-weight`     | `bold`               | The default `font-weight` for breadcrumbs
`$breadcrumb-radii`           | `$radii`             | The `border-radius` of the breadcrumb container
`$breadcrumb-divider-content` | `" /"`               | The content to appear after a breadcrumb link
`$breadcrumb-divider-color`   | `$breadcrumb-color`  | The text `color` of the breadcrumb divider

