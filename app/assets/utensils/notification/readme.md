
# Notification
Describe this.

## Usage Example

<!--~ markup/notification.html.haml -->
```haml
.notification.fade.in
  %p <strong>Default!</strong> This is the default notification
  %a.close(href="#" data-bindable="dismiss") &times;

.notification.important.fade.in#notification_important
  %p <strong>Important!</strong> This is the important notification
  %a.close(href="#" data-bindable="dismiss" data-target="#notification_important") &times;

.notification.success.fade.in#notification_success
  %p <strong>Success!</strong> This is the success notification
  %a.close(href="#notification_success" data-bindable="dismiss") &times;

.notification.warning.fade.in
  %p <strong>Warning!</strong> This is the warning notification
  %a.close(href="#" data-bindable="dismiss") &times;

.notification.danger.fade.in
  %p <strong>Danger!</strong> This is the danger notification
  %a.close(href="#" data-bindable="dismiss") &times;
```
<!-- end -->

## Todo
- Write behavior for closing the alert
- Finish working the style modifiers with lists
- Figure out what to do with the mixin
- Styles for block notifications
- How to handle flash messages?

