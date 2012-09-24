
# Togglable
Base class for adding, removing and toggling classes on a given element
and/or related elements.

```html
data-bindable="togglable"
```

## Usage Examples

<!--~ markup/togglable.html.haml -->
```haml
%h5.fade.in#togglable_heading Heading
%nav
  %ul.nav.inline
    %li#one<
      %a(data-bindable="togglable" href="#") One
    %li#two<
      %a(data-bindable="togglable" data-target="this" href="#" data-trigger="hover" data-toggle="fade") Two
    %li#three<
      %a(data-bindable="togglable" href="#" data-related="#span" data-related-toggle="in") Three <span id="span" class="fade in">Span</span>
    %li#four<
      %a(data-bindable="togglable" href=".nav" data-lookup="closest" data-toggle="inline") Four
    %li#five<
      %a(data-bindable="togglable" href="#five" data-target="#find_bang" data-bubble="true") Five <span id="find_bang">!</span>
    %li#six<
      %a(data-bindable="togglable" href="#" data-activate="true") Six
    %li#seven<
      %a(data-bindable="togglable" href="#togglable_heading" data-context="body" data-toggle="in") Seven
    %li#eight<
      %a(data-bindable="togglable" href="#" data-delay="activate: 1000, deactivate: 500") Eight
```
<!-- end -->

1. Toggles the class `active` on `click`
- Toggles the classes `fade` on `hover`, the `data-attribute="this"` is merely referencing the element as it's target
- Toggles the class `in` on `click` for the child `<span>` and `active` on the `<link>` element
- Toggles the class `inline` on `click` for only the `ul.nav` and not the `<link>`, using the `$.closest` method to find the target
- Toggles `active` state on `click` for the `<span>` element only and, changes the url hash to `#five`
- Toggles the class `active` on `click`, but is initialized with the `active` class on the element
- Toggles the `in` class on the "Heading" element on `click` by using the `body` element as the `context` to find the target
- Toggles the `active` class on the link with a 1 second delay on activation and 1/2 second delay on deactivation


## Options

Attribute  | Default      | Description
---------- | ------------ | -------------------------------------------
`toggle`   | `active`     | The class(es) to toggle when triggered
`trigger`  | `click`      | The event to trigger toggle behavior [`click`, `hover`, `focus`, `manual`]
`context`  | `bindable`   | The DOM node to use for lookups
`lookup`   | `find`       | The `$` method to find a target or href target [`closest`, `siblings`, `parents`...]
`target`   | `bindable`   | The target element to toggle classes on (the `href` attribute can also be used)
`activate` | `false`      | If present, this will auto activate the element
`bubble`   | `false`      | Controls whether an action `preventsDefault`, setting to `true` will allow normal events to bubble
`delay`    | `undefined`  | The amount of time in milliseconds to delay on `activate` and `deactivate`, see the `Timeslot` class for more information


### Related Options
The following options can be applied if the toggling behavior needs to
affect a secondary related element. The base requirement is the
`related` attribute

Attribute         | Default   | Description
----------------- | --------- | -------------------------------------------
`related`         | `null`    | The selector to perform `Togglable` actions on
`related-classes` | `toggle`  | The class(es) to toggle when triggered on the related element
`related-context` | `body`    | The DOM node to use for `related` selector lookup
`related-lookup`  | `find`    | The `$` method to find the `related` selector [`closest`, `siblings`, `parents`...]

###### Notes
- **Heads Up!** when setting these in markup use `data-related-classes`,
  when creating through an instance use `data.relatedClasses`


### Trigger Types
The `trigger` attribute is mapped to an object with `on/off` properties
based on the following:

Attribute  | trigger.on => handler     | trigger.off => handler
---------- | ------------------------- | --------------------------------------
"click"    | `click => #toggle`        | `click => #toggle`
"hover"    | `mouseenter => #activate` | `mouseleave => #deactivate`
"focus"    | `focus => #activate`      | `blur => #deactivate`
"manual"   | _none_                    | _none_

The `manual` trigger does not add any listeners, as it's meant to be
called programmatically from another object.

Any other trigger types, not included in this list, map their `on/off`
properties to the given trigger name. They will automatically call the
`#toggle` handler.


### Finding Targets
`Togglable` finds the target based on the following rules:

1. If there is a `target` attribute and it is the string `"this"`,
   return the `bindable` element
- If there is a `target` attribute and it can be found in the DOM, use it
- Otherwise if there is NOT an `href` attribute use the `bindable` element
- Or if the `href` is `#` use the `bindable` element
- Or if the `href` is a normal link (i.e. `/some-page`) use the `bindable` element
- Otherwise lookup the element within the `href`, if found, use it, otherwise use the `bindable` element
- If the `context` attribute is set, it will perform searches from this element, otherwise it will use the element associated with `bindable`


### Delays
When `delay` is set, the `#activate` and `#deactivate` methods are
scoped to `#activateWithDelay` and `#deactivateWithDelay`. Classes
utilizing `Togglable` through composition and a `delay` do not need to
be concerned with this in their own API. Compositional classes should
only rely on the dispatched events from their instance of `Togglable`.

If one of the delay properties (`activate` or `deactivate`) is `0`, then
the method for that property will not be scoped through the delay method.


## API

### #new
Create a new instance of `Togglable` programatically. 

```coffee
#= require togglable

@el = $('#togglable')
@togglable = new utensil.Togglable(@el, {toggle: 'fade active', trigger: 'hover'})
```

### #toggle
Typically called through user input, but can be triggered by the
elements toggle event.

```coffee
@el.trigger('click')
```

### #activate
Add the toggle classes to the targets

dispatches the `togglable:activate` event

```coffee
@togglable.activate()
```

### #deactivate
Removes the toggle classes from the targets

dispatches the `togglable:deactivate` event

```coffee
@togglable.deactivate()
```

### #dispose
Cleans up any internal references 

```coffee
@togglable.dispose()
```

### Requires
- `utensil`
- `bindable`
- `timeslot`

An instance of `Togglable` creates a `@dispatcher` property for
dispatching events. Typically this is just the `@el` but is created for
clarity in access from a compositional class.

```coffee
@togglable = new utensil.Togglable(@el, @data)

@toggler.dispatcher.on('togglable:activate', => @activated.apply(@, arguments))
@toggler.dispatcher.on('togglable:deactivate', => @deactivated.apply(@, arguments))
```

