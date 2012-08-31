
# Detect
Utility class of static variables describing various browser support for
properties, normalizing event names, and other useful detection.

## API

### #transition
Get the transition event name for the current browser for use in css transitions

```coffee
@tranny_event = roos.Detect.transition.end
```
### #hasTransition
Boolean value based on the browsers support for transitions

```coffee
$(el).on(roos.Detect.transition.end, @onDone) if roos.Detect.hasTransition
```

### Requires
- `roos`

