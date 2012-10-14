
# Pill
Pills are similar to tabs, and follow the same markup structure as other
navigation elements. Pills like other navigation elements require the
`.nav` class for layout. Add `.nav .pill` to a `ul` or `ol` element.

To utilize a drop dead simple version of hiding and showing content, add
the `data-bindable="tab"` along with an `href` attributes pointing to
the related targets panel.

See `Tab` for more information.

```sass
@import utensils/components/pill/pill
```

## Usage Example

<!--~ markup/pill.html.haml -->
```haml
%nav#pill_demo
  %ul.nav.pill(data-bindable="tab" data-related="#pill_content")
    %li.active<
      %a(href="#pill_one") Pill One
    %li<
      %a(href="#" data-target="#pill_two") Pill Two
    %li<
      %a(href="#pill_three") Pill Three

    %li.drop(data-bindable="drop")
      %a.drop-toggle(href="#") Pill Drop <span class="caret"></span>
      %ul.nav.menu
        %li<
          %a(href="#pill_four") Pill Four
        %li<
          %a(href="#pill_five") Pill Five
        %li<
          %a(href="#pill_six") Pill Six

%section#pill_content.tab-content(style="margin-top:1.25em;")
  %article.tab-pane.active#pill_one
    %p Pill content <span class="decal important">one</span>
  %article.tab-pane#pill_two
    %p Pill content <span class="decal success">two</span>
  %article.tab-pane#pill_three
    %p Pill content <span class="decal danger">three</span>

  %article.tab-pane#pill_four
    %p Pill sub content <span class="decal warning">four</span>
  %article.tab-pane#pill_five
    %p Pill sub content <span class="decal inverse">five</span>
  %article.tab-pane#pill_six
    %p Pill sub content <span class="decal important">six</span>
```
<!-- end -->

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `pill.sass` is loaded.

Variable             | Default            | Description
-------------------- | ------------------ | -------------------------------------------
`$pill-bgc-hover`    | `$base-bgc-hover`  | The `background-color` of the pill component when hovered
`$pill-bgc-active`   | `$base-bgc-active` | The `background-color` of the pill component when active
`$pill-bgc-selected` | `$base-bgc-active` | The `background-color` of the pill component when selected
`$pill-radii`        | `$radii`           | The `border-radius` of the pill link

