
# Modal
Describe this

## Usage Example

<!--~ markup/modal.html.haml -->
```haml
:ruby
  @lorem = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."

%button.btn(data-bindable="modal" href="#modal_href" data-keyboard="true") Launch Modal

.modal.fade#modal_href
  .notification.success.fade.in
    %header.notify-header
      %h4.notify-heading Modal Notification
    %section.notify-content
      %p= @lorem
    %footer.notify-footer
      %button.btn.success Action
      %button.btn.danger(data-dismiss="modal") Cancel
    %a.close(href="#" data-dismiss="modal") &times;
```
<!-- end -->

## Todo
- Build this

