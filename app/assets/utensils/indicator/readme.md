# Indicator
Indicators are used primarily in carousels for navigation elements for
cycling through slides. 

Indicators are instantiated through a carousel wrapper and inject the
instance of the carousel to respond to. All public activity should
still be handled via the carousel. Markup for a carousel is
automatically generated via JavaScript.

[<~Example](markup/indicator.html.haml)


## Usage
As a class instantiated by a Carousel:

```coffee
#= require utensils/bindable
#= require utensils/carousel
#= require utensils/indicator

class utensils.CarouselThing
  constructor: (@el, @data) ->
    @indicator = new utensils.Indicator(@el, @data, @)

  dispose: ->
    @indicator.dispose()
```


## Style Settings
```sass
@import utensils/indicator
```

To override the default settings, set the variable and it's value
within your `config.sass` file or before `indicator.sass` is loaded.

Variable                     | Default               | Description
---------------------------- | --------------------- | -------------------------------------------
`$indication-bgc`            | `$base-bgc`           | The `background-color` of a indication button
`$indication-bgc-hover`      | `$base-bgc-hover`     | The `background-color` of a indication button on `hover`
`$indication-bgc-active`     | `$base-bgc-active`    | The `background-color` of a indication button when `active`
`$indication-border`         | `$base-border`        | The `border-color` of a indication button
`$indication-color-active`   | `$base-color-active`  | The text `color` when a indication button is `active`
`$indication-disabled-color` | `$disabled-color`     | The text `color` when a indication button is `disabled`
`$indication-disabled-bgc`   | `transparent`         | The `background-color` of a indication button when `disabled`
`$indication-radii`          | `$radii`              | The `border-radius` of the indicator buttons

## Todo
- Test

