
# Button Group
Use button groups to join multiple buttons together as one composite component.
Build them with a series of `<a>` or `<button>` elements.

Building off of the button group concept, combine multiple `.button-group`
elements under a `.button-toolbar` container to form a navigation system.

```sass
@import utensils/button_group/button_group
```

## Usage Example
[<~Example](markup/button_group.html.haml)

###### Notes
- **Pro Tip!** Button groups and tool bars play great with the `ToggleButtonGroup` behavior


## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `button_group.sass` is loaded.

Variable               | Default    | Description
---------------------- | ---------- | -------------------------------------------
`$button-group-offset` | `0.5em`    | The `margin-left` for a `.button-group + .button-group`

