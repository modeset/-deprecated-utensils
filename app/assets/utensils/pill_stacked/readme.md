
# Pill Stacked
Stack pills by adding the class `.stacked` to the `.pill` element.

Stacked pills require the `pill` component.

```sass
@import utensils/pill/pill
@import utensils/pill_stacked/pill_stacked
```

## Usage Example

<!--~ markup/pill-stacked.html.haml -->
```haml
%nav#pill_stacked_demo(role="navigation")
  %ul.nav.pill.stacked(data-bindable="tab" data-related="#pill_stacked_content" role="tablist")
    %li.active<
      %a(href="#pill_stacked_one" role="tab") Pill One
    %li<
      %a(href="#" data-target="#pill_stacked_two" role="tab") Pill Two
    %li<
      %a(href="#pill_stacked_three" role="tab") Pill Three

    %li.drop(data-bindable="drop")
      %a.drop-toggle#pill_stacked_drop(href="#") Pill Drop <span class="caret"></span>
      %ul.nav.menu(role="menu" aria-labelledby="pill_stacked_drop")
        %li<
          %a(href="#pill_stacked_four" role="tab" tabindex="-1") Pill Four
        %li<
          %a(href="#pill_stacked_five" role="tab" tabindex="-1") Pill Five
        %li<
          %a(href="#pill_stacked_six" role="tab" tabindex="-1") Pill Six

%section#pill_stacked_content.tab-content(style="margin-top:1.25em;")
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

