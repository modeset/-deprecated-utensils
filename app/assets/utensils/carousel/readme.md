
# Carousel
The base carousel.

## Usage Example

<!--~ markup/carousel.html.haml -->
```haml
%section.carousel(data-bindable="carousel" data-autoplay="false" data-cycles="1" data-duration="2" data-active-class="in" data-keyboard="true")
  %nav.carousel-controls.fade.in
    %a.paddle-icon.west(href="#prev") &larr;
    %a.paddle-icon.east(href="#next") &rarr;
    %ul.nav.indication
  %section.carousel-inner
    - (1..3).each do |i|
      %article.carousel-panel(class="fade")
        %figure.carousel-figure
          %img(src="/assets/fpo/carousel-#{i}.gif" alt="image")
          %figcaption.carousel-caption
```
<!-- end -->