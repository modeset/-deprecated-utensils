# Form Search
Utilize the `.form-search` class on the `form` element to create a simple
search form. Supports hints and control labels as well.

Any input fields of type `"text"` or `"search"` automatically receive the
properties of the `.search-query` class. Any input buttons used will
inherit the top and bottom `padding` of the input element.

[<~Example](markup/form_search.html.haml)


## Style Settings
```sass
@import utensils/form_controls/form_controls
@import utensils/form_search/form_search
```
_Alert!_ Requires the `form_controls` utensil.

