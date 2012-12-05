# Accordion
Base styles for rendering accordion elements. Accordions can be used
with either the `Toggle`, `ToggleGroup` or `Collapse` behaviors.

[<~Example](markup/accordion.html.haml)


## Style Settings

```sass
@import utensils/collapse/collapse
@import utensils/accordion/accordion
```
To override the default settings, set the variable and it's value
within your `config.sass` file or before `accordion.sass` is loaded.

Variable            | Default        | Description
------------------- | -------------- | -------------------------------------------
`$accordion-border` | `$base-border` | The `border-color` of the accordion component
`$accordion-radii`  | `$radii`       | The `border-radius` of the accordion component

