
# Tab
Tabs follow the same markup structure as other navigation elements. Tabs
like other navigation elements require the `.nav` class for layout. Add
`.nav .tab` to a `ul` or `ol` element.

To utilize a drop dead simple version of hiding and showing content, add
the `data-bindable="togglable-group"` along with a `data-related` target
and `href` attributes pointing to the related targets panel.

```sass
@import utensils/components/tab/tab
```

## Usage Example

<!--~ markup/tab.html.haml -->
```haml
%nav#tab_demo
  %ul.nav.tab(data-bindable="tab" data-related="#tab_content")
    %li.active<
      %a(href="#tab_one") Tab One
    %li<
      %a(href="#" data-target="#tab_two") Tab Two
    %li<
      %a(href="#tab_three") Tab Three

    %li.drop(data-bindable="drop")
      %a.drop-toggle(href="#") Tab Drop <span class="caret"></span>
      %ul.nav.menu
        %li<
          %a(href="#tab_four") Tab Four
        %li<
          %a(href="#tab_five") Tab Five
        %li<
          %a(href="#tab_six") Tab Six

%section#tab_content.tab-content(style="margin-top:1.25em;")
  %article.tab-pane.active#tab_one
    %p Tab content <span class="decal important">one</span>
  %article.tab-pane#tab_two
    %p Tab content <span class="decal success">two</span>
  %article.tab-pane#tab_three
    %p Tab content <span class="decal danger">three</span>

  %article.tab-pane#tab_four
    %p Tab sub content <span class="decal warning">four</span>
  %article.tab-pane#tab_five
    %p Tab sub content <span class="decal inverse">five</span>
  %article.tab-pane#tab_six
    %p Tab sub content <span class="decal important">six</span>
```
<!-- end -->

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `tab.sass` is loaded.

Variable          | Default            | Description
----------------- | ------------------ | -------------------------------------------
`$tab-bgc`        | `$base-bgc`        | The `background-color` of the tab component
`$tab-bgc-hover`  | `$base-bgc-hover`  | The `background-color` of a tab element when hovered
`$tab-bgc-active` | `$base-bgc-active` | The `background-color` of a tab element when active
`$tab-border`     | `$base-border`     | The `border-color` of the tab component
`$tab-radii`      | `$radii`           | The `border-radius` of the tab component

