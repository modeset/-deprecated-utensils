
# TODO

## WIP
- add key binding to drop's menu
- Clean up the sub nav states in TogglableGroup
- Should it be visually.shown/visually.hide?
- rebuild scoping in all files
- make sure events are namespaced (`.` for native and `:` for custom)
- tabs.sass *
- stacked tabs
- pills.sass *
- stacked pills
- accordions.sass *
- nav-lists.sass
- modals.sass *
- notifications.sass *
- progress-bars.sass *
- navbars.sass *
- carousels.sass *
- view layout templates
- document mixins
- document polyfills
- upgrades
- fishnet

## Reminders, Tasks and Future Considerations
- Lists should be able to pass a single element
- Look at making the sass files use abstract elements (placeholders)
- There should be some sort of Togglable class that acts similar to the
  demo (removes a bunch of classes then add more) pass a data-remove?
- Should we abstract focus/disabled states to a mixin?
- Rename components subdirectory to utensils?
- Convert media queries
- Move the debug tools outside of this project
- Turn into engine with generators
- Really test out the order of sass files and where there are issues
- Look at all Todo items within each component
- Better tools for documentation (generation, behavior, and styles)
- Do tip and popover extend Togglable instead of using composition?
- Would it be better to use underscore for most things or stick with `$`?
- Check for disabled states on some components and disable interactions
  if true

## Bugs
- Weird bug on some of the button group clicking around deactivation

## Vendor stuff
- move jQuery out of the main files
- add underscore (maybe as a component)
- modernizer (as a component)
- add respond.js (as a component)

