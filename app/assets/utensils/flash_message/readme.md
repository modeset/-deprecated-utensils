
# Flash Message
A top level container to house notifications and messages targeted to
the user.

## Usage Example
[<~Example](markup/flash_message.html.haml)

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

