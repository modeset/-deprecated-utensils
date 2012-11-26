
# Table
Building tables is additive around the classes applied to the top level `<table>` element.
By combining any of the following classes, the table can be given a different look and feel.

```sass
@import utensils/table/table
```

## Usage Example
<!--~ markup/table.html.haml -->

###### Note
- **Heads up!** To get the status colors, see the "Table Status Modifiers" section below.


## Options
Adding a class directly to the `table` element produces the following.

Class              | Usage
------------------ | ---------------------------
_none_             | The base table creates division in data with horizontal dividers
`.table-box`       | Renders the table with exterior boundaries for all table rows
`.table-vborder`   | Renders the table with vertical divisions for table data
`.table-condensed` | Condenses the table cell heights by 1/2
`.table-banded`    | Renders alternating `<tbody>` rows with a different color
 `.table-hover`    | Shows a hover state on the table cell
`.table-thead`     | Fills the `thead` with a background fill
`.table-tfoot`     | Fills the `tfoot` with a background fill


## Table Status Modifiers
The status styles around `tbody tr` elements are not supported out of
the box. To include these, setup a `$table-status-list` variable with
the associated classes and color values.


## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `table.sass` is loaded.

Variable               | Default                           | Description
---------------------- | --------------------------------- | -------------------------------------------
`$table-bgc`           | `$base-bgc`                       | The `background-color` of the table
`$table-border`        | `$base-border`                    | The `border-color` of the table
`$table-band-odd-bgc`  | `$table-bgc`                      | The `background-color` of odd rows in `.table-banded`
`$table-band-even-bgc` | `darken($table-band-odd-bgc, 5%)` | The `background-color` of even rows in `.table-banded`
`$table-hover-bgc`     | `darken($table-bgc, 10%)`         | The `background-color` of the `td` element in `.table-hover`
`$table-thead-bgc`     | `darken($table-bgc, 12%)`         | The `background-color` of the `thead` element in `.table-thead`
`$table-tfoot-bgc`     | `darken($table-bgc, 5%) `         | The `background-color` of the `tfoot` element in `.table-tfoot`
`$table-padding-lr`    | `0.5em`                           | The `padding-left`, `padding-right` value for `th` and `td`
`$table-padding-tb`    | `0.8em`                           | The `padding-top`, `padding-bottom` value for `th` and `td` (divided by 2 for `table-condensed`)
`$table-status-list`   | `nil`                             | The `list` of modifier classes to include for `tr` cell statuses

###### Warnings
- **Heads Up!** Tables throughout the style guide may not contain the exact styles of the application

