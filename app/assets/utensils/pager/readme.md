# Pager
Pagers are commonly used in simple paging navigations, where a full
blown pagination system isn't required.

To allow pager to float on the sides of the container, apply the
`.prev` and `.next` classes to the containing pager `li` element.

[<~Example](markup/pager.html.haml)


## Usage

Class                   | Description
----------------------- | -------------------------------------------
`.pager`                | Aligns pagers grouped together on the left edge of the container
`.pager.pager-center`   | Aligns pagers grouped together in the center of the container
`.pager.pager-right`    | Aligns pagers grouped together on the right edge of the container
`.pager > .pager-next`  | Apply `pager.next` on the `li` to align the "next pager" to the right edge of the container
`.pager > .pager-prev`  | Apply `pager.prev` on the `li` to align the "prev pager" to the left edge of the container

To disable a pager, add the `disabled` class to the `a` element's parent `li`.


## Style Settings
```sass
@import utensils/pager/pager
```

To override the default settings, set the variable and it's value
within your `config.sass` file or before `pager.sass` is loaded.

Variable                | Default            | Description
----------------------- | ------------------ | -------------------------------------------
`$pager-bgc`            | `$base-bgc`        | The `background-color` of the pager
`$pager-bgc-hover`      | `$base-bgc-hover`  | The `background-color` of the pager when hovered
`$pager-bgc-active`     | `$base-bgc-active` | The `background-color` of the pager when active
`$pager-border`         | `$base-border`     | The `border-color` of the pager
`$pager-disabled-color` | `$disabled-color`  | The disabled text `color` of the pager
`$pager-disabled-bgc`   | `$disabled-bgc`    | The disabled `background-color` of the pager

