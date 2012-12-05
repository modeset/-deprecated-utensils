# Normalize
Normalize base element styles to allow browsers to render all controls
more consistently and in line with modern standards.

Normalization and resets based on:

- [normalize.css](http://necolas.github.com/normalize.css/)
- [HTML5 Boilerplate](http://html5boilerplate.com/)

This should appear right after compass, bourbon or the polyfills load, but before any
specific styles are imported. This module operates on top level elements
and inserts them directly into your style sheet.

```sass
@import utensils/normalize/normalize
```

