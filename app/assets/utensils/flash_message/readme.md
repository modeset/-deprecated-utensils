
# Flash Message
Describe this.


## Usage Example

<!--~ markup/flash_message.html.haml -->
```haml
%section#demo_flash_message.button-toolbar
  %nav.button-group(data-bindable="toggle-button-group" data-remove="top bottom middle top-left top-center top-right")
    %button.btn.active(href="#" data-add="top") Default (Top)
    %button.btn(href="#" data-add="top-left") Top Left
    %button.btn(href="#" data-add="top-center") Top Center
    %button.btn(href="#" data-add="top-right") Top Right
    %button.btn(href="#" data-add="middle") Middle
    %button.btn(href="#" data-add="bottom") Bottom

  %nav.button-group
    %button.btn(href="#" data-type="") Add Default (Info)
    %button.btn(href="#" data-type="important") Add Important
    %button.btn(href="#" data-type="success") Add Success
    %button.btn(href="#" data-type="warning") Add Warning
    %button.btn(href="#" data-type="danger") Add Danger
```
<!-- end -->

## Todo
- Document this
