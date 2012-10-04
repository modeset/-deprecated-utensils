
# Tab Stacked
Stack tabs by adding the class `.stacked` to the `.tab` element.

Stacked tabs require the `tab` component.

```sass
@import utensils/components/tab/tab
@import utensils/components/tab_stacked/tab_stacked
```

## Usage Example

<!--~ markup/tab-stacked.html.haml -->
```haml
%nav#tab_stacked_demo
  %ul.nav.tab.stacked(data-bindable="togglable-group" data-related="#tab_stacked_content .togglable-pane")
    %li.active<
      %a(href="#tab_stacked_one") Tab One
    %li<
      %a(href="#" data-target="#tab_stacked_two") Tab Two
    %li<
      %a(href="#tab_stacked_three") Tab Three

    %li.drop(data-bindable="drop" data-group=".tab")
      %a(href="#") Tab Drop <span class="caret"></span>
      %ul.nav.menu
        %li<
          %a(href="#tab_stacked_four") Tab Four
        %li<
          %a(href="#tab_stacked_five") Tab Five
        %li<
          %a(href="#tab_stacked_six") Tab Six

%section#tab_stacked_content.togglable-content(style="margin-top:1.25em;")
  %article.togglable-pane.active#tab_stacked_one
    %p Tab content <span class="decal important">one</span>
  %article.togglable-pane#tab_stacked_two
    %p Tab content <span class="decal success">two</span>
  %article.togglable-pane#tab_stacked_three
    %p Tab content <span class="decal danger">three</span>

  %article.togglable-pane#tab_stacked_four
    %p Tab sub content <span class="decal warning">four</span>
  %article.togglable-pane#tab_stacked_five
    %p Tab sub content <span class="decal inverse">five</span>
  %article.togglable-pane#tab_stacked_six
    %p Tab sub content <span class="decal important">six</span>
```
<!-- end -->

## Style Settings
All style settings are inherited from `tab.sass`.

