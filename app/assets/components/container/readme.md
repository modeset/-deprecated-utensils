
# Container
The container class is used to contain elements of content within a page
or section. The container class injects the [micro clearfix](http://nicolasgallagher.com/micro-clearfix-hack/)
to clear any floats from interior elements.

There are a few modifiers which can be applied to the default container
to affect how it displays contained elements.

```sass
@import roos/components/container/container
```

## Usage

Class              | Usage
------------------ | -----------------------------------
`.container`       | The default container is a fluid width container with a `max-width` set to the `$base-width` variable.
`.container.outer` | Adding the `.outer` class to a `container` adds left and right padding, which creates breathing room in fluid layouts from the browser's edges.
`.container.fluid` | Adding the `.fluid` class to a `container` will remove the `max-width` setting and allow the container to fill the browser window.
`.container.fixed` | Adding the `.fixed` class to a `container` will render it using fixed width pixels with no responsive behavior.

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `container.sass` is loaded.

Attribute                  | Default                   | Description
-------------------------- | ------------------------- | -------------------------------------------
`$container-padding-left`  | `1%`                      | Set the `padding-left` on the `container.outer` element
`$container-padding-right` | `$container-padding-left` | Set the `padding-right` on the `container.outer` element

