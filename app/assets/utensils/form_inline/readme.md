
# Form Inline
Utilize the `.form-inline` class on the `form` element to create a simple
inline form. Supports control labels as well.

```sass
@import utensils/form_inline/form-inline
```

## Usage Example

<!--~ markup/form-inline.html.haml -->
```haml
%form.form-inline.well.fill
  %input#fi_email(type="email" placeholder="email")
  %input#fi_passw(type="password" placeholder="password")
  %select
    %option(selected="selected" value="denver") Denver
    %option(value="boulder") Boulder
    %option(value="los angeles") Los Angeles
    %option(value="san francisco") San Francisco
  %label.checkbox-label
    %input(type="checkbox") Remember me
  %input.btn.standard(type="submit" value="Go")
```
<!-- end -->

###### Notes
- **Heads Up!** Requires the `form-controls` utensil.

