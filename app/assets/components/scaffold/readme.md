
# Scaffold
Setup main scaffolding elements for `html`, `body`, selections, generic links and navigation.
Scaffolding includes font sizes, families, colors, backgrounds and line heights.

## Base navs
The base nav is the building block for navigation structures and components
(tabs, pills, breadcrumbs, pagination and navigation lists). The `.nav` class
can be used for simple navigation as well. The buttons below will change the
class on the `ul` element to showcase the different navigation systems
based off the same markup structure.

## Usage Example

<!--~ markup/scaffold-nav.html.haml -->
```haml
%nav
  %ul.nav.inline#underoos_nav_demo
    %li
      %a(data-classes="nav" href="#") Base Nav
    %li.active
      %a(data-classes="nav inline" href="#") Base Nav Inline
    %li
      %a(data-classes="nav tabs" href="#") Tabs
    %li
      %a(data-classes="nav pills" href="#") Pills
    %li
      %a(data-classes="nav breadcrumb" href="#") Breadcrumbs
    %li
      %a(data-classes="nav pagination" href="#") Pagination
    %li
      %a(data-classes="nav tabs stacked" href="#") Stacked Tabs
    %li
      %a(data-classes="nav pills stacked" href="#") Stacked Pills
```
<!-- end -->





###### Warnings
- **Heads Up!** All navigation components depend on the `.nav` class being attached to the container element

###### Notes
- **Pro Tip!** For convenience, add the `inline` class to the `.nav` element to display the base nav inline

