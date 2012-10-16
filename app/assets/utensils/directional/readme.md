
# Directional
Utility class for finding cardinal positions (`north|south|east|west`) for
an element measured against it's container.

For working examples, see `Tip` or `Pop`


## API

### #new
Create a new instance of `Directional`, typically used compositionally. 

```coffee
#= require directional

@directional = new utensils.Directional(@element, @container, 'north')
```

### #setElement
Sets the `element` being used for positioning. 

```coffee
@directional.setElement(@target)
```

### #setContainer
Sets the `container` being used for positioning. 

```coffee
@directional.setContainer(@el)
```

### #setCardinal
Sets the cardinal position `north|south|east|west` to use. 

```coffee
@directional.setCardinal('west')
```

### #getCardinals
Returns the cardinal position list tested against. 

```coffee
@cardinals = @directional.getCardinals()
```

### #getDimensions
Returns the sizing of a given element.

```coffee
@directional.getDimensions(@el)
# returns: {top:10 left:20, width:200, height:100}
```

### #getPlacementFromCardinal
Returns the suggested position where the element should be within the
container, based on the cardinal

```coffee
@directional.getPlacementFromCardinal()
# returns: {top:50 left:220, cardinal:'west'}
```

### #constrainToViewport
Takes a given position and returns an altered cardinal position and
coordinates if the passed position would render the element outside the
viewport.

```coffee
position = @directional.getPlacementFromCardinal()
on_screen = @directional.constrainToViewport(position)
# returns: {top:50 left:-220, cardinal:'east'}
```

### #getPlacementAndConstrain
Wrapper method around returning the calls from `#getPlacementFromCardinal` and `#constrainToViewport`

```coffee
position = @directional.getPlacementAndConstrain()
```

### Requires
- `utensils/utensils`

