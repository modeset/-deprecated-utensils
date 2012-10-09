
# Todo

## WIP
- ToggleGroup handle selected for children?
- rework tab/pill
- button group
- remove Togglable/TogglableGroup
- document Triggerable
- document Toggle
- document ToggleGroup
- document all reworked utensils
- lazy load lookups to speed up initialization
- collapse *
- accordions.sass *
- focus and selected states around all utensils
- modals.sass *
- notifications.sass *
- progress-bars.sass *
- navbars.sass *
- carousels.sass *
- document mixins
- finish all utensil Todo lists
- view layout templates
- ARIA roles for templates/fixtures
- media queries
- universal style sheet
- upgrades
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

## Repository
- Standardize file naming structure
- Rename components subdirectory to utensils?
- Move the debug tools outside of this project
- Turn into engine with generators
- Better tools for documentation (generation, behavior, and styles)
- Add a script for curling vendor libraries (non-gems)

## Triggerables
- Make Toggle lighter weight
- Create wrappers around tab, pill, accordions etc. to minimize the
  required data-attributes 
- There should be some sort of Toggle class that acts similar to the
  demo (removes a bunch of classes then add more) pass a data-remove?

