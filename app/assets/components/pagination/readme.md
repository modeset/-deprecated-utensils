
# Pagination
Apply the `.pagination` class to the `ol` or `ul` element to
represent pagination navigation. The list should contain the `.nav` class.

```sass
@import utensils/components/pagination/pagination
```

## Usage Example

<!--~ markup/pagination.html.haml -->
```haml
%nav(data-bindable="togglable-group")
  %ol.nav.pagination
    %li.disabled<
      %a(href="#") &laquo;
    %li<
      %a(href="#") 1
    %li.active<
      %a(href="#") 2
    %li<
      %a(href="#" rel="next") 3
    %li<
      %a(href="#") &hellip;
    %li<
      %a(href="#") 11
    %li<
      %a(href="#") 12
    %li<
      %a(href="#") &raquo;
%hr
%nav.pagination-center(data-bindable="togglable-group")
  %ol.nav.pagination
    %li.disabled<
      %a(href="#") &laquo;
    %li<
      %a(href="#") 1
    %li.active<
      %a(href="#") 2
    %li<
      %a(href="#" rel="next") 3
    %li<
      %a(href="#") &hellip;
    %li<
      %a(href="#") 11
    %li<
      %a(href="#") 12
    %li<
      %a(href="#") &raquo;
%hr
%nav.pagination-right(data-bindable="togglable-group")
  %ol.nav.pagination
    %li.disabled<
      %a(href="#") &laquo;
    %li<
      %a(href="#") 1
    %li.active<
      %a(href="#") 2
    %li<
      %a(href="#" rel="next") 3
    %li<
      %a(href="#") &hellip;
    %li<
      %a(href="#") 11
    %li<
      %a(href="#") 12
    %li<
      %a(href="#") &raquo;
```
<!-- end -->

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `pagination.sass` is loaded.

Variable                     | Default               | Description
---------------------------- | --------------------- | -------------------------------------------
`$pagination-bgc`            | `$base-bgc`           | The `background-color` of a pagination button
`$pagination-bgc-hover`      | `$base-bgc-hover`     | The `background-color` of a pagination button on `hover`
`$pagination-bgc-active`     | `$base-bgc-active`    | The `background-color` of a pagination button when `active`
`$pagination-border`         | `$base-border`        | The `border-color` of a pagination button
`$pagination-color-active`   | `$base-color-active`  | The text `color` when a pagination button is `active`
`$pagination-disabled-color` | `$disabled-color`     | The text `color` when a pagination button is `disabled`
`$pagination-disabled-bgc`   | `transparent`         | The `background-color` of a pagination button when `disabled`
`$pagination-radii`          | `$radii`              | The `border-radius` of the `:first-child` and `:last-child` pagination button edges


###### Note
- **Pro Tip!** Add `.pagination-center` or `.pagination-right` on the `.pagination` container's `parent` (`nav`) element to change the alignment

## Todo
- Look at https://github.com/amatsuda/kaminari for pagination

