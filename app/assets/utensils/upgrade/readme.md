
# Upgrade
The upgrade component is a lightweight messaging systems used to notify
users to upgrade their browser or enable JavaScript.

The markup is served as a partial, typically from
`layouts/shared/_upgrade.html.haml`. A template is included in
`templates/layouts/shared`.


## Usage Example

```~haml
%section.button-toolbar
  %nav.button-group#upgrade_demo(data-bindable="toggle-button-group" data-behavior="checkbox")
    %button.btn(data-toggle="no-js-msg") Toggle JS Message
    %button.btn(data-toggle="dinosaur-msg") Toggle Dinosaur Message
```

The demo positions the upgrade message with `position:fixed` while the
default behavior is actually `position:absolute`. This is for
convenience only so there is no need to scroll to the top of the page.


## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `upgrade.sass` is loaded.

Variable         | Default     | Description
---------------- | ----------- | -------------------------------------------
`$upgrade-color` | `white`     | The text `color` of the message
`$upgrade-bgc`   | `$danger`   | The `background-color` of the notification

