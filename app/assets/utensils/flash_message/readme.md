
# Flash Message
A top level container to house notifications and messages targeted to
the user.

## Usage Example

<!--~ markup/flash_message.html.haml -->
```haml
%section#demo_flash_message
  %nav.button-group(data-bindable="toggle-button-group" data-remove="top bottom middle top-left top-center top-right")
    %button.btn.active(data-add="top") Default (Top)
    %button.btn(data-add="top-left") Top Left
    %button.btn(data-add="top-center") Top Center
    %button.btn(data-add="top-right") Top Right
    %button.btn(data-add="middle") Middle
    %button.btn(data-add="bottom") Bottom

  %nav.button-group(style="margin:2em 0 0;")
    %button.btn(data-type="") Add Default (Info)
    %button.btn(data-type="important") Add Important
    %button.btn(data-type="success") Add Success
    %button.btn(data-type="warning") Add Warning
    %button.btn(data-type="danger") Add Danger
```
<!-- end -->

Flash notifications enhance the `.notification` component by allowing
them to appear fixed above all other elements on the page. Wrap the
notifications within a `#flash_messages.flash-messages` container at the
root of the body.

Adding different positional classes to the `.flash-messages` container
will allow them to appear in different quadrants of the viewport.

## Style Settings
There are no style settings to override for flash messaging.

###### Warning
- **Heads Up!** The configuration file needs to define the
  `$zindex-flash-message` value before this file is imported, this is
  done to keep managing `z-index` mappings in one place.

