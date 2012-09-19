
# Tab
Describe this

## Usage Example

<!--~ markup/tab.html.haml -->
```haml
%nav
  %ul.nav.tab(data-bindable="togglable-group" data-related="#tab_content .tab-pane")
    %li.active<
      %a(href="#tab_one") Tab One
    %li<
      %a(href="#" data-target="#tab_two") Tab Two
    %li<
      %a(href="#tab_three") Tab Three

%section#tab_content.tabable-content(style="margin-top:1.25em;")
  %article.tab-pane.active#tab_one
    %p Tab content <span class="decal important">one</span>
  %article.tab-pane#tab_two
    %p Tab content <span class="decal success">two</span>
  %article.tab-pane#tab_three
    %p Tab content <span class="decal danger">three</span>
```
<!-- end -->

