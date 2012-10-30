
# Accordion
Base styles for rendering accordion elements. Accordions can be used
with either the `Toggle`, `ToggleGroup` or `Collapse` behaviors.

```sass
@import utensils/collapse/collapse
@import utensils/accordion/accordion
```

## Usage Example

<!--~ markup/accordion.html.haml -->
```haml
:ruby
  @lorem = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

%section.accordion-group(role="tablist")
  %a.accordion-toggle(data-bindable="toggle" href="#accordion_single" role="tab") Single Accordion Element
  %section.collapse#accordion_single(role="tabpanel")
    %article.accordion-inner
      %p=@lorem

%hr
%ul.accordion#accordion_radio(data-bindable="toggle-group" role="tablist" style="margin-top:1em;")
  -(1..3).each do |i|
    %li.accordion-group
      %a.accordion-toggle(href="#accordion_radio_#{i}" role="tab")
        %span Accordion Radio #{i}
        %span &darr;
      %section.collapse(id="accordion_radio_#{i}" role="tabpanel")
        %article.accordion-inner
          %p=@lorem

%hr
%ul.accordion#accordion_checkbox(data-bindable="collapse" data-type="group" data-behavior="checkbox" role="tablist" style="margin-top:1em;")
  -(1..3).each do |i|
    %li.accordion-group
      %a.accordion-toggle(href="#accordion_check_#{i}" role="tab") Accordion Check #{i} with Collapse
      %section.collapse(id="accordion_check_#{i}" role="tabpanel")
        %article.accordion-inner
          %p=@lorem


%hr
%ul.accordion#accordion_complex(data-bindable="collapse" data-type="group" data-behavior="checkbox" role="tablist" style="margin-top:1em;")
  -(1..3).each do |i|
    %li.accordion-group
      %a.accordion-toggle(href="#accordion_complex_#{i}" role="tab") Accordion Complicated #{i} with Collapse
      %section.collapse(id="accordion_complex_#{i}" role="tabpanel")
        %article.accordion-inner
          %ul
            %li
              %p=@lorem
            %li
              %p=@lorem
```
<!-- end -->

## Style Settings
To override the default settings, set the variable and it's value
within your `config.sass` file or before `accordion.sass` is loaded.

Variable            | Default        | Description
------------------- | -------------- | -------------------------------------------
`$accordion-border` | `$base-border` | The `border-color` of the accordion component
`$accordion-radii`  | `$radii`       | The `border-radius` of the accordion component

