
# Todo

## WIP
- document all reworked utensils
- namespace all events with utensil to avoid collisions
- bindable should be a utensil
- lazy load lookups to speed up initialization
  - ToggleGroup: @targets
  - Drop: menu
  - Tab: Storing selectors (can this be done in ToggleGroup too?), regex
  - Pop data lookup, container, cache render
  - Tip: container, cache render
  - Dimensionizer ?
- collapse *
- accordions.sass *
- focus and selected states around all utensils
- notifications.sass *
- progress-bars.sass *
- modals.sass *
- navbars.sass *
- document mixins
- finish all utensil Todo lists
- view layout templates
- ARIA roles for templates/fixtures
- media queries
- universal style sheet
- upgrades
- carousels.sass *
- listing of needed utensils
- fishnet

## Reminders, Tasks and Future Considerations
- Style lists should be able to pass a single element
- Look at making the sass files use abstract elements (placeholders)
- Really test out the order of sass files and where there are issues
- Should it be visually.shown/visually.hide? (how is this working on
  focus states?)
- Check for disabled states on components and disable interactions if
  true
- There should be some sort of Toggle class that acts similar to the
  demo (removes a bunch of classes then add more) pass a data-remove?

## Repository
- Standardize file naming structure
- Rename components subdirectory to utensils?
- Move the debug tools outside of this project
- Turn into engine with generators
- Better tools for documentation (generation, behavior, and styles)
- Add a script for curling vendor libraries (non-gems)

