
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
%nav#tab_stacked_demo
  %ul.nav.tab.stacked(data-bindable="tab" data-related="#tab_stacked_content")
    %li.active<
      %a(href="#tab_stacked_one") Tab One
    %li<
      %a(href="#" data-target="#tab_stacked_two") Tab Two
    %li<
      %a(href="#tab_stacked_three") Tab Three

    %li.drop(data-bindable="drop")
      %a.drop-toggle(href="#") Tab Drop <span class="caret"></span>
      %ul.nav.menu
        %li<
          %a(href="#tab_stacked_four") Tab Four
        %li<
          %a(href="#tab_stacked_five") Tab Five
        %li<
          %a(href="#tab_stacked_six") Tab Six

%section#tab_stacked_content.tab-content(style="margin-top:1.25em;")
  %article.tab-pane.active#tab_stacked_one
    %p Tab content <span class="decal important">one</span>
  %article.tab-pane#tab_stacked_two
    %p Tab content <span class="decal success">two</span>
  %article.tab-pane#tab_stacked_three
    %p Tab content <span class="decal danger">three</span>

  %article.tab-pane#tab_stacked_four
    %p Tab sub content <span class="decal warning">four</span>
  %article.tab-pane#tab_stacked_five
    %p Tab sub content <span class="decal inverse">five</span>
  %article.tab-pane#tab_stacked_six
    %p Tab sub content <span class="decal important">six</span>
```
<!-- end -->

## Style Settings
All style settings are inherited from `tab.sass`.

