# Bindable
Light weight dependency injection for client side components. Looks for
all DOM elements with a `data-bindable` attribute, stores references
within a registry and instantiates their respective classes.

Classes registering with `Bindable` are passed the existing element
converted to a `$` object.


## Usage
As a class making use of the `Bindable` registry:

```coffee
#= require utensils/bindable

class utensils.MockClass
  constructor: (@el) ->
  # make some magic

# register with Bindable
utensils.Bindable.register 'mocker', utensils.MockClass
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

### #bindAll
Binds all elements on the page with a `data-bindable` attribute with
it's respective class.

```coffee
@bindable = new utensils.Bindable()
@bindable.bindAll()
```

### #getRefs
Returns a listing of all bindable objects on the page.

```coffee
@bindable = new utensils.Bindable()
@bindable.bindAll()
binded = @bindable.getRefs()
```

### #dispose
Calls the `dispose` method on all bindable objects and cleans out the
instance of `Bindable`.

```coffee
@bindable = new utensils.Bindable()
@bindable.bindAll()
@bindable.dispose()
```

**Heads Up!** When disposing, `Bindable` will also call the `release`
method on all objects. This will eventually be deprecated in future
versions.

### @getClass
Static method for returning a class instance out of the registry from a
key.

```coffee
object = utensils.Bindable.getClass('key')
```

### @register
Manually add a bindable object to the registry by passing a key and a
class instance.

```coffee
utensils.Bindable.register('my_class', new MyClass())
```

### Requires
```coffee
utensils/utensils
```

