
# TODO

## WIP
- rebuild scoping in all files
- make sure events are namespaced (`.` for native and `:` for custom)
- change detect to support
- move classify to utility method (might be able to kill it entirely)

- tabs.sass *
- stacked tabs
- pills.sass *
- stacked pills
- nav-lists.sass
- add correct focus states around components
- accordions.sass *
- modals.sass *
- notifications.sass *
- progress-bars.sass *
- navbars.sass *
- carousels.sass *
- view layout templates
- document mixins
- document polyfills
- upgrades
- finish drop
- fishnet

## Reminders, Tasks and Future Considerations
- Lists should be able to pass a single element
- Look at making the sass files use abstract elements (placeholders)
- Should we abstract focus/disabled states to a mixin?
- Align all focus states
- Rename components subdirectory to utensils?
- Convert media queries
- Move the debug tools outside of this project
- Turn into engine with generators
- Really test out the order of sass files and where there are issues
- Look at all Todo items within each component
- Better tools for documentation (generation, behavior, and styles)
- Would it be better to use underscore for most things or stick with `$`?
- Check for disabled states on some components and disable interactions
  if true
- Should it be visually.shown/visually.hide? (how is this working on
  focus states?)

## Togglables
- Make Togglable lighter weight
- Is this overly complex for what we need it to be?
- Do tip and popover, drop extend Togglable instead of using composition?
- There should be some sort of Togglable class that acts similar to the
  demo (removes a bunch of classes then add more) pass a data-remove?

## Bugs
- Weird bug on some of the button group clicking around deactivation

## Vendor stuff
- Add a script for installing jQuery, underscore, respond.js and
  modernizr

