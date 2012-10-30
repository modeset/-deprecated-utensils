
# Tab Stacked
Stack tabs by adding the class `.stacked` to the `.tab` element.

Stacked tabs require the `tab` component.

```sass
@import utensils/tab/tab
@import utensils/tab_stacked/tab_stacked
```

## Usage Example

<!--~ markup/tab-stacked.html.haml -->
```haml
%nav#tab_stacked_demo(role="navigation")
  %ul.nav.tab.stacked(data-bindable="tab" data-related="#tab_stacked_content" role="tablist")
    %li.active<
      %a(href="#tab_stacked_one" role="tab") Tab One
    %li<
      %a(href="#" data-target="#tab_stacked_two" role="tab") Tab Two
    %li<
      %a(href="#tab_stacked_three" role="tab") Tab Three

    %li.drop(data-bindable="drop")
      %a.drop-toggle#tab_stacked_drop(href="#") Tab Drop <span class="caret"></span>
      %ul.nav.menu(role="menu" aria-labelledby="tab_stacked_drop")
        %li<
          %a(href="#tab_stacked_four" role="tab") Tab Four
        %li<
          %a(href="#tab_stacked_five" role="tab") Tab Five
        %li<
          %a(href="#tab_stacked_six" role="tab") Tab Six

%section#tab_stacked_content.tab-content(style="margin-top:1.25em;")
  %article.tab-pane.active#tab_stacked_one(role="tabpanel")
    %p Tab content <span class="decal important">one</span>
  %article.tab-pane#tab_stacked_two(role="tabpanel")
    %p Tab content <span class="decal success">two</span>
  %article.tab-pane#tab_stacked_three(role="tabpanel")
    %p Tab content <span class="decal danger">three</span>
  %article.tab-pane#tab_stacked_four(role="tabpanel")
    %p Tab sub content <span class="decal warning">four</span>
  %article.tab-pane#tab_stacked_five(role="tabpanel")
    %p Tab sub content <span class="decal inverse">five</span>
  %article.tab-pane#tab_stacked_six(role="tabpanel")
    %p Tab sub content <span class="decal important">six</span>
```
<!-- end -->

## Style Settings
All style settings are inherited from `tab.sass`.

