
# Carousel Touch Infinite
Touch me.

## Usage Example

<!--~ markup/carousel_touch_infinite.html.haml -->
```haml
%section.carousel(data-bindable="carousel-touch-infinite" role="presentation")
  %nav.carousel-controls
    %a.paddle-icon.west(href="#prev") &larr;
    %a.paddle-icon.east(href="#next") &rarr;
  %section.carousel-inner
    - (1..4).each do |i|
      %article.carousel-panel
        %figure.carousel-figure
          %img(src="/assets/fpo/fpo-600x400-#{i}.jpg" alt="image")
```
<!-- end -->

## Todo
- Chat with JG on this port
- Hide the scrollbar?
- Test
- Document

