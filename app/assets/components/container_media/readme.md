
# Container Media

Media container provides a simple way for showcasing images, video
and other media items as static media or clickable links. Include
a `.media-caption` element when an area is needed to describe the figure.

The media container contains basic settings for styling and structure,
but it will need some sort of grid setting or `width` defined on the `li`
tags. There are currently no `margin` settings included in the media
container for this reason.

## Usage Examples

<!--~ markup/container-media.html.haml -->
```haml
%ul.media-container
  %li(style="width:25%")
    %figure.media-item
      %img(src="/assets/snow-260x180.png")
      %figcaption.media-caption
        %h3 Media Item
        %p This is some caption copy with the footer aligned to the left.
        %footer.media-caption-footer
          %button.btn Action
  %li(style="width:25%")
    %a.media-item(href="#")
      %img(src="/assets/snow-260x180.png")
  %li(style="width:25%")
    %figure.media-item
      %a.media-item(href="#")
        %img(src="/assets/snow-260x180.png")
      %figcaption.media-caption
        %h3 Media Item
        %p This is some caption copy with the footer aligned to the right.
        %footer.media-caption-footer.media-caption-right
          %button.btn Action
  %li(style="width:25%")
    %figure.media-item
      %img(src="/assets/snow-260x180.png")
```
<!-- end -->

###### Notes
- **Pro Tip!** Add `media-caption-right` on the `media-caption-footer`
  to align buttons to the right

