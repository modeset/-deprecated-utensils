
# Bindable
Light weight dependency injection for client side components. Looks for
all DOM elements with a `data-bindable` attribute, stores references
within a registry and instantiates their respective classes.

Classes registering with `Bindable` are passed the existing element
converted to a `$` object.

`Bindable` is stored as a global object on `window`.


## Usage
As a class making use of the `Bindable` registry:

```coffee
#= require bindable
class roos.MockClass
  constructor: (@el) ->
  # make some magic

# register with Bindable
Bindable.register('mocker', roos.MockClass)
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
  new Bindable().bindAll()
```


## API

###### Alert
- **TODO**! Need to describe the public API

