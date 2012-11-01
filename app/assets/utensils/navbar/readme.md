
# Navbar
Contains the basic structure for creating application or page level
navigation systems. A combination of styles and layout for supporting
various components with navigation, search forms and drop downs.

```sass
@import utensils/navbar/navbar
```

## Usage Example

<!--~ markup/navbar.html.haml -->
```haml
.navbar
  .navbar-inner
    .container
      -# %button.btn.info.btn-navbar(data-bindable="collapse" data-target="#navbar_collapse")
        -# %span.icon-bar
        -# %span.icon-bar
        -# %span.icon-bar
      %a.brand(href="#") Brand
      %nav.nav-collapse#navbar_collapse(role="navigation")
        %ul.nav(data-bindable="toggle-group")
          %li<
            %a(href="#") Link 1
          %li.active<
            %a(href="#") Link 2
          %li<
            %a(href="#") Link 3
          %li<
            %a(href="#") Link 4
          %li.drop(data-bindable="drop")<
            %a#nb_drop_1.drop-toggle(href="#") Drop <span class="caret"></span>
            %ul.nav.menu(role="menu" aria-labelledby="nb_drop_1")
              %li<
                %a(href="#" tabindex="-1") Subnav 1
              %li<
                %a(href="#" tabindex="-1") Subnav 2
              %li<
                %a(href="#" tabindex="-1") Subnav 3

        %section.pull-right
          %form.form-search(role="search")
            .control-group
              .controls
                %input.search-query(type="search" placeholder="search")
          %ul.nav
            %li<
              %a(href="#") Another Link
            %li.drop(data-bindable="drop")<
              %a.drop-toggle#nb_drop_2(href="#") Settings <span class="caret"></span>
              %ul.nav.menu(role="menu" aria-labelledby="nb_drop_2")
                %li<
                  %a(href="#" tabindex="-1") Subnav 1
                %li<
                  %a(href="#" tabindex="-1") Subnav 2
```
<!-- end -->

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
To override the default settings, set the variable and it's value within
your `config.sass` file or before `navbar.sass` is loaded.

Variable                  | Default                   | Description
------------------------- | ------------------------- | -------------------------------------------
`$navbar-bgc`             | `$base-bgc-active`        | The `background-color` of the navbar component
`$navbar-link-bgc-active` | `darken($navbar-bgc,` 5%) | The `background-color` a navbar link when active

## Todo
- Add media queries
- Add collapsible button and behavior

