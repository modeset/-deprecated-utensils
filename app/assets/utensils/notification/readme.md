
# Notification
UI pattern for displaying messaging information in a notification.

Add the `Dismiss` behavior for allowing the notification to be closed.

```sass
@import utensils/notification/notification
```

## Usage Example

<!--~ markup/notification.html.haml -->
```haml
:ruby
  @lorem = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
  eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
  veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
  commodo consequat."

.notification.fade.in(role="alert")
  %p <strong>Default!</strong> This is the default notification
  %a.close(href="#" data-bindable="dismiss") &times;

.notification.important.fade.in#notification_important(role="alert")
  %p <strong>Important!</strong> This is the important notification
  %a.close(href="#" data-bindable="dismiss" data-target="#notification_important") &times;

.notification.success.fade.in#notification_success(role="alert")
  %p <strong>Success!</strong> This is the success notification
  %a.close(href="#notification_success" data-bindable="dismiss") &times;

.notification.warning.fade.in(role="alert")
  %p <strong>Warning!</strong> This is the warning notification
  %a.close(href="#" data-bindable="dismiss") &times;

.notification.danger.fade.in(role="alert")
  %p <strong>Danger!</strong> This is the danger notification
  %a.close(href="#" data-bindable="dismiss") &times;

.notification.success.fade.in(role="alert")
  %header.notify-header
    %h4.notify-heading Block Notification
  %section.notify-content
    %p= @lorem
  %footer.notify-footer
    %button.btn.success Action
    %button.btn.danger Cancel
  %a.close(href="#" data-bindable="dismiss") &times;

.notification.danger.fade.in(role="alert")
  %section.notify-content
    %p <strong>Yikes! This doesn't have a header and the footer is on the right!</strong> #{@lorem}
  %footer.notify-footer.notify-right
    %button.btn.success Action
    %button.btn.danger Cancel
  %a.close(href="#" data-bindable="dismiss") &times;
```
<!-- end -->

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

