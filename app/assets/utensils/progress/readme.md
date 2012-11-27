
# Progress
Styles and simple behavior for progress indicator bars.

```sass
@import utensils/progress/progress
```


## Usage Example
[<~Example](markup/progress.html.haml)

###### Note
- **Pro Tip!** Click on one of the progress bars and it will animate to
  a random number between `0-100`


## Options

Attribute        | Default     | Description
---------------- | ----------- | -------------------------------------------
`initial`        | `undefined` | A numerical value to set the bar at


## API

### #new
`Progress` is typically used by a class instance

```coffee
#= require progress

@progress_el = $('#progress')

@progress = new utensils.Progress(@progress_el)
```

### #set
Set the width of the progress bar from a percentage value

```coffee
@progress.set(50)
```

### #get
Get the width of the progress bar from a percentage value

```coffee
current = @progress.get()
```

### #reset
Reset the width of the progress bar back to `0`

```coffee
@progress.reset()
```

### #complete
Set the width of the progress bar to `100`

```coffee
@progress.complete()
```

### Requires
- `utensils/utensils`


## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `progress.sass` is loaded.

Variable            | Default                 | Description
------------------- | ----------------------- | -------------------------------------------
`$progress-bgc`     | `darken($base-bgc,` 5%) | The `background-color` of the progress container
`$progress-border`  | `$base-border`          | The `border-color` of the progress container
`$progress-radii`   | `$radii`                | The `border-radius` of the progress component
`$progress-height`  | `1.25em`                | The `height` of the progress container and bar
`$progress-speed`   | `$speed`                | The `duration` when animating a bars progress
`$progress-bar-bgc` | `$info`                 | The `background-color` of the default bar

Progress bars rely on a `$progress-list` for generating various status
colors related to bars. This list is typically defined in the
`config.sass` file.

