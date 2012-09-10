
# Toggler
Base class for adding, removing and toggling classes on a given element.

```html
data-bindable="toggler"
```

## Usage Examples

<!--~ markup/toggler.html.haml -->
```haml
%nav
  %ul.nav.inline
    %li#one
      %a(data-bindable="toggler" href="#") One
    %li#two
      %a(data-bindable="toggler" href="#this" data-trigger="hover" data-toggle="fade") Two
    %li#three
      %a(data-bindable="toggler" href="#span" data-solo="true" data-toggle="fade") Three <span id="span">Span</span>
    %li#four
      %a.inline(data-bindable="toggler" href=".nav" data-lookup="closest" data-toggle="inline") Four
    %li#five
      %a(data-bindable="toggler" href="#toggler" data-target=".nav" data-lookup="closest" data-toggle="inline" data-bubble="true") Five
    %li#six
      %a(data-bindable="toggler" href="#" data-activate="true") Six
```
<!-- end -->

1. Toggles the class `active` on `click`
- Toggles the classes `fade` on `hover`, the `href` is merely referencing the element as it's target
- Toggles the class `fade` on `click` for only the child `<span>` and not the `<link>` element
- Toggles the class `inline` on `click` for both the `link` and `ul.nav`, using the `$.closest` method to find the target
- Same as number four except on `click` the url will change to the `href` hash to `#toggler`
- Toggles the class `active` on `click`, but is initialized with the `active` class on the element


## Options

Attribute  | Default            | Description
---------- | ------------------ | -------------------------------------------
`toggle`   | `active`           | The class(es) to toggle when triggered
`trigger`  | `click`            | The event to trigger toggle behavior
`target`   | `bindable`         | The target element to toggle classes on (the `href` attribute can also be used)
`lookup`   | `find`             | The `$` method to find a target or href target ~ [`closest`, `siblings`, `parents`...]
`solo`     | `true`             | When the target is not the bindable element, classes are toggled to both the target and bindable element. Setting to false will result in classes only being applied to the target
`activate` | `false`            | If present, this will auto activate the element
`bubble`   | `false`            | Controls whether an action `preventsDefault`, setting to `true` will allow normal events to fire

Toggler finds the target based on the following rules:

1. If there is a `target` attribute and it can be found in the DOM, use it
- Otherwise if there is NOT an `href` attribute use the bindable element
- Or if the `href` is `#this` or `#` use the bindable element
- Or if the `href` is a normal link (i.e. `/some-page`) use the bindable element
- Otherwise lookup the element within the `href`, if found, use it, otherwise use the bindable element

## API

### #new
Create a new instance of Toggler programatically. Normally this is
handled through Bindable. 

```coffee
#= require toggler

@el = $('#toggler')
@toggler = new utensil.Toggler(@el, {toggle: 'show', trigger: 'hover'})
```

### #toggle
This is normally handled through events, but you can always trigger the
element's toggle event

```coffee
@el.trigger('hover')
```

### #activate
Add the toggle classes to the element

```coffee
@toggler.activate()
```

### #deactivate
Remove the toggle classes from the element

```coffee
@toggler.deactivate()
```

### #dispose
Remove the toggler behavior

```coffee
@toggler.dispose()
```

### Requires
- `utensil`

## Todo
- Look at passing a context object for easier searching via `@lookup`

