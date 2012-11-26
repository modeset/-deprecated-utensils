
# Media Grid

Media container provides a simple way for showcasing images, video
and other media items as static media or clickable links. Include
a `.media-caption` element when an area is needed to describe the figure.

The media grid contains basic settings for styling and structure,
but it will need some sort of grid setting or `width` defined on the `li`
tags. There are currently no `margin` settings included in the media
grid for this reason.

```sass
@import utensils/media_grid/media_grid
```

## Usage Examples
<!--~ markup/media_grid.html.haml -->

###### Notes
- **Pro Tip!** Add `media-caption-right` on the `media-caption-footer`
  to align buttons to the right


## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `media_grid.sass` is loaded.

Variable              | Default              | Description
--------------------- | -------------------- | -------------------------------------------
`$media-border`       | `$base-border`       | The `border-color` of the `.media-item`
`$media-border-hover` | `$base-border-hover` | The `border-color` of the `.media-item` when a link is hovered
`$media-radii`        | `$radii`             | The `border-radius` of the `.media-item`

