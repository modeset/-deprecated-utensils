
# Form Search
Utilize the `.form-search` class on the `form` element to create a simple
search form. Supports hints and control labels as well.

Any input fields of type `"text"` or `"search"` automatically receive the
properties of the `.search-query` class. Any input buttons used will
inherit the top and bottom `padding` of the input element.

```sass
@import utensils/form_search/form-search
```

## Usage Example

<!--~ markup/form_search.html.haml -->
```haml
%form.form-search.well.fill(role="search")
  %input#fs_search(type="search" placeholder="search")
  %input.btn.standard(type="submit" value="Submit")
```
<!-- end -->

###### Notes
- **Heads Up!** Requires the `form_controls` utensil.

