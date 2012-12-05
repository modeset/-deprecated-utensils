# Navbar
Contains the basic structure for creating application or page level
navigation systems. A combination of styles and layout for supporting
various components with navigation, search forms and drop downs.

[<~Example](markup/navbar.html.haml)


## Navbar Types
By adding modifier classes on the `.navbar` element can change how a
navbar displays.

Class                   | Description
----------------------- | ----------------------------------------------
`.navbar`               | The basic navbar constrained to the width of the site container
`.navbar.navbar-static` | A primary navbar who's background extends the width of the browser
`.navbar.navbar-fixed`  | A primary navbar who's background extends the width of the browser and remains fixed to the top of the viewport


## Responsive Navbar
Need to implement this


## Style Settings
```sass
@import utensils/navbar/navbar
```

To override the default settings, set the variable and it's value within
your `config.sass` file or before `navbar.sass` is loaded.

Variable                  | Default                   | Description
------------------------- | ------------------------- | -------------------------------------------
`$navbar-bgc`             | `$base-bgc-active`        | The `background-color` of the navbar component
`$navbar-link-bgc-active` | `darken($navbar-bgc,` 5%) | The `background-color` a navbar link when active


## Todo
- Add media queries
- Add collapsible button and behavior with media queries

