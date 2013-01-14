# <%= file_name.humanize %>
_Todo!_ Document <%= file_name.humanize %>


[<~Example](markup/<%= file_name %>.html.haml)


## Options

Attribute           | Default            | Description
------------------- | ------------------ | ------------------------------------
`namespace`         | `<%= file_name %>` | The name space to use for dispatching events


## API

### #dispose
Remove the `<%= file_name.camelize %>` behavior.

```coffee
@<%= file_name %>.dispose()
```

### Requires
```coffee
utensils/utensils
```


## Style Settings

```sass
@import utensils/<%= file_name %>
```
To override the default settings, set the variable and it's value
within your `config.sass` file or before `<%= file_name %>.sass` is loaded.

Variable            | Default            | Description
------------------- | ------------------ | ------------------------------------

