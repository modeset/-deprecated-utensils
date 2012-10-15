
# Bindable
Light weight dependency injection for client side components. Looks for
all DOM elements with a `data-bindable` attribute, stores references
within a registry and instantiates their respective classes.

Classes registering with `Bindable` are passed the existing element
converted to a `$` object.


## Usage
As a class making use of the `Bindable` registry:

```coffee
#= require bindable
class utensils.MockClass
  constructor: (@el) ->
  # make some magic

# register with Bindable
utensils.Bindable.register('mocker', utensil.MockClass)
```

As markup instantiating a class that is registered with `Bindable`:

```haml
%a.mock(data-bindable="mocker" href="#") Binded to MockClass
```

`Bindable` is created after the page has loaded (typically in a
bootstrap file)

```coffee
#= require bindable
$ ->
  new utensils.Bindable().bindAll()
```


## API

### Requires
- `utensils`

## Todo
- Need to describe the public API
- Is there a case for multiple bindables on a single element?

