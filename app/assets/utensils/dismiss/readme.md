
# Dismiss
Remove an element from the DOM.

```html
data-bindable="dismiss"
```

## Usage Example

<!--~ markup/dismiss.html.haml -->
```haml
.notification.fade.in
  %p <strong>Notification!</strong> This is the default notification
  %a.close(href="#" data-bindable="dismiss") &times;

.notification.fade.in#dismiss_href
  %p <strong>Notifcation Href!</strong> This is the default notification
  %a.close(href="#dismiss_href" data-bindable="dismiss") &times;

.notification.fade.in#dismiss_target
  %p <strong>Notifcation Target!</strong> With a delay
  %a.close(href="#" data-target="#dismiss_target" data-bindable="dismiss" data-delay="2000") &times;

.notification.fade.in#dismiss_nested
  %p <strong>Notifcation Nested!</strong> This is the default notification
  %p
    %a.close(href="#" data-bindable="dismiss") &times;

%a#dismiss_alone(href="#" data-bindable="dismiss") Close Me

%section#dismiss_cya.fade.in
  %p<
    This whole thing should fade out,
    %a(href="#" data-bindable="dismiss" data-parents="#dismiss_cya") when you click this link
```
<!-- end -->


## Options

Attribute   | Default                  | Description
----------- | ------------------------ | -------------------------------------------
`namespace` | `dismiss`                | The namespace to use for dispatching events
`parents`   | `.notification,.dismiss` | The default classes to search for if an `href` or `target` is not defined

See `Triggerable` for other options 

###### Notes  
- **Pro Tip!** If the target element has the class `in` it will remove
  this class first and wait for the transition to finish

## API

### #new
Create a new instance of `Dismiss` programmatically. Normally this is
handled through `Bindable`. 

```coffee
#= require dismiss

@el = $('#dismiss')
@dismiss = new utensils.Dismiss(@el, {target: @el.find('.notification')})
```

### #remove
Removes the element from the DOM, if the `in` class is on the target, it
will animate out and call `#removeTarget`.

##### dispatches:
- `dismiss:dismiss`

### #removeTarget
Removes the element from the DOM immediately.

##### dispatches:
- `dismiss:dismissed`

### #dispose
Cleans up all listeners, but does not remove the element from the DOM.

### Requires
- `utesnils/utensils`
- `utesnils/bindable`
- `utesnils/triggerable`
- `utesnils/detect`

`Dismiss` utilizes `Triggerable` via composition.

