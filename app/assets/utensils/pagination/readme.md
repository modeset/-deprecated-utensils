
# Pagination
Apply the `.pagination` class to the `ol` or `ul` element to
represent pagination navigation. The list should contain the `.nav` class.

```sass
@import utensils/pagination/pagination
```

## Usage Example
<!--~ markup/pagination.html.haml -->


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

