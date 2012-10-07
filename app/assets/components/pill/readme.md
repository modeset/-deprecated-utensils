
# Pill
Pills are similar to tabs, and follow the same markup structure as other
navigation elements. Pills like other navigation elements require the
`.nav` class for layout. Add `.nav .pill` to a `ul` or `ol` element.

To utilize a drop dead simple version of hiding and showing content, add
the `data-bindable="togglable-group"` along with a `data-related` target
and `href` attributes pointing to the related targets panel.

```sass
@import utensils/components/pill/pill
```

## Usage Example

<!--~ markup/pill.html.haml -->
```haml
%nav#pill_demo
  %ul.nav.pill(data-bindable="togglable-group" data-related="#pill_content .togglable-pane")
    %li.active<
      %a(href="#pill_one") Pill One
    %li<
      %a(href="#" data-target="#pill_two") Pill Two
    %li<
      %a(href="#pill_three") Pill Three

    %li.drop(data-bindable="drop" data-group=".pill")
      %a(href="#") Pill Drop <span class="caret"></span>
      %ul.nav.menu
        %li<
          %a(href="#pill_four") Pill Four
        %li<
          %a(href="#pill_five") Pill Five
        %li<
          %a(href="#pill_six") Pill Six

%section#pill_content.togglable-content(style="margin-top:1.25em;")
  %article.togglable-pane.active#pill_one
    %p Pill content <span class="decal important">one</span>
  %article.togglable-pane#pill_two
    %p Pill content <span class="decal success">two</span>
  %article.togglable-pane#pill_three
    %p Pill content <span class="decal danger">three</span>

  %article.togglable-pane#pill_four
    %p Pill sub content <span class="decal warning">four</span>
  %article.togglable-pane#pill_five
    %p Pill sub content <span class="decal inverse">five</span>
  %article.togglable-pane#pill_six
    %p Pill sub content <span class="decal important">six</span>
```
<!-- end -->

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `pill.sass` is loaded.

Variable           | Default            | Description
------------------ | ------------------ | -------------------------------------------
`$pill-bgc-hover`  | `$base-bgc-hover`  | The `background-color` of the pill component when hovered
`$pill-bgc-active` | `$base-bgc-active` | The `background-color` of the pill component when active
`$pill-radii`      | `$radii`           | The `border-radius` of the pill link
