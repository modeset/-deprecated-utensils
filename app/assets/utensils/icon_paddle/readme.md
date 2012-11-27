
# Icon Paddle
Paddles are commonly used in carousel or simple paging navigations.
The paddle icons are setup as absolutely positioned and should reside in
an element that is positioned relatively.

Paddles should be extended by a component class for exact positioning
and styles.

```sass
@import utensils/icon_paddle/paddle
```

## Usage Example
[<~Example](markup/paddle.html.haml)


## Usage

Class                 | Description
--------------------- | -------------------------------------------
`.paddle-icon.north`  | Positions the icon at `top:0` and `left:50%`
`.paddle-icon.south`  | Positions the icon at `bottom:0` and `left:50%`
`.paddle-icon.east`   | Positions the icon at `top:50%` and `right:0`
`.paddle-icon.west`   | Positions the icon at `top:50%` and `left:0`

