
# Notification
UI pattern for displaying messaging information in a notification.

Add the `Dismiss` behavior for allowing the notification to be closed.

```sass
@import utensils/notification/notification
```

## Usage Example
<!--~ markup/notification.html.haml -->

### Block Notifications
Block notifications are similar to the base notification, in fact
nothing needs to change on the outer container. Just add a
`.notify-header`, `.notify-content` and/or `.notify-footer` to the
internal markup to provide more information around the notification. To
align one of these containers to the right, simply add the modifier
class `.notify-right`.


## Style Settings
To override the default settings, set the variable and it's value within
your `config.sass` file or before `notification.sass` is loaded.

Variable               | Default            | Description
---------------------- | ------------------ | -------------------------------------------
`$notification-color`  | `$info`            | The base `color` for generic notifications
`$notification-radii`  | `$radii`           | The `border-radius` to use on notifications
`$notification-shadow` | `$small-drop-lite` | The `drop-shadow` for use on text items
`$notification-list`   | `nil`              | The `list` of modifier notifcations (success, important, danger)

