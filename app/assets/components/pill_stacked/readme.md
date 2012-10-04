
# Pill Stacked
Stack pills by adding the class `.stacked` to the `.pill` element.

Stacked pills require the `pill` component.

```sass
@import utensils/components/pill/pill
@import utensils/components/pill_stacked/pill_stacked
```

## Usage Example

<!--~ markup/pill-stacked.html.haml -->
```haml
%nav#pill_stacked_demo
  %ul.nav.pill.stacked(data-bindable="togglable-group" data-related="#pill_stacked_content .tab-pane")
    %li.active<
      %a(href="#pill_stacked_one") Pill One
    %li<
      %a(href="#" data-target="#pill_stacked_two") Pill Two
    %li<
      %a(href="#pill_stacked_three") Pill Three

    %li.drop(data-bindable="drop" data-group=".pill")
      %a(href="#") Pill Drop <span class="caret"></span>
      %ul.nav.menu
        %li<
          %a(href="#pill_stacked_four") Pill Four
        %li<
          %a(href="#pill_stacked_five") Pill Five
        %li<
          %a(href="#pill_stacked_six") Pill Six

%section#pill_stacked_content.tabable-content(style="margin-top:1.25em;")
  %article.tab-pane.active#pill_stacked_one
    %p Pill content <span class="decal important">one</span>
  %article.tab-pane#pill_stacked_two
    %p Pill content <span class="decal success">two</span>
  %article.tab-pane#pill_stacked_three
    %p Pill content <span class="decal danger">three</span>

  %article.tab-pane#pill_stacked_four
    %p Pill sub content <span class="decal warning">four</span>
  %article.tab-pane#pill_stacked_five
    %p Pill sub content <span class="decal inverse">five</span>
  %article.tab-pane#pill_stacked_six
    %p Pill sub content <span class="decal important">six</span>
```
<!-- end -->

## Style Settings
All style settings are inherited from `pill.sass`.

