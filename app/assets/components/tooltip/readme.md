
## Tooltip

You can control various options of how a tool tip is shown based on attributes set in the link.

Styles are automatically generated based on the inverted colors of the body's
`background-color` and font `color`.

Tooltips handle positions for
<a href="#" rel="tooltip" data-placement="top" title="Top">top</a>,
<a href="#" rel="tooltip" data-placement="bottom" title="Bottom">bottom</a>,
<a href="#" rel="tooltip" data-placement="left" title="Left">left</a>, or
<a href="#" rel="tooltip" data-placement="right" title="Right">right</a>.

They require information set on a links data attributes.

Attribute          | Values                        | Usage
------------------ | ---------------------------   | ---------------------------
`rel`              | `popover`                     | The js identifier for the type of component
`data-placement`   | `top`,`bottom`,`left`,`right` | The direction to show based on the target
`title`            | _text_                        | The copy for the tooltip

Examples:
```
<a rel="tooltip" data-placement="top" title="Top">Top</a>
```

Notes:
- **Heads Up!** Tooltips are opt in and will only be instantiated if called directly from JavaScript `$("a[rel=tooltip]").tooltip()`

