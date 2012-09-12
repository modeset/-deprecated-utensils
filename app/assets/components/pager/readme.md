
# Pager
Pagers are commonly used in simple paging navigations, where a full
blown pagination system isn't required.

To allow pager to float on the sides of the container, apply the
`.prev` and `.next` classes to the containing pager `li` element.

```sass
@import utensils/components/pager/pager
```

## Usage Example

<!--~ markup/pager.html.haml -->
```haml
%nav
  %ul.pager
    %li.disabled<
      %a(href="#") &larr; Prev
    %li<
      %a(href="#") Next &rarr;

%hr

%nav
  %ul.pager.pager-center
    %li<
      %a(href="#") &larr; Prev
    %li<
      %a(href="#") Next &rarr;

%hr

%nav
  %ul.pager.pager-right
    %li<
      %a(href="#") &larr; Prev
    %li.disabled<
      %a(href="#") Next &rarr;

%hr

%nav
  %ul.pager
    %li.prev<
      %a(href="#") &larr; Prev
    %li.next<
      %a(href="#") Next &rarr;
```
<!-- end -->

## Usage

Class                 | Description
--------------------- | -------------------------------------------
`.pager`              | Aligns pagers grouped together on the left edge of the container
`.pager.pager-center` | Aligns pagers grouped together in the center of the container
`.pager.pager-right`  | Aligns pagers grouped together on the right edge of the container

By adding the classes `.next` and `.prev` on the `li` will split the
pager buttons with `.prev` on the left and `.next` on the right. There
is no need to add the center or right modifier classes for this to work.

To disable a pager, add the `disabled` class to the `a` element's parent
`li`.


## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `pager.sass` is loaded.

Variable                | Default                        | Description
--------------------    | ------------------------------ | -------------------------------------------
`$pager-bgc`            | `$body-bgc`                    | The `background-color` of the pager
`$pager-bgc-hover`      | `darken($pager-bgc,5%)`        | The `background-color` of the pager when hovered
`$pager-bgc-active`     | `darken($pager-bgc-hover,5%)`  | The `background-color` of the pager when active
`$pager-border`         | `$border-color`                | The `border-color` of the pager
`$pager-disabled-bgc`   | `$disabled-bgc`                | The disabled `background-color` of the pager
`$pager-disabled-color` | `$disabled-color`              | The disabled text `color` of the pager

