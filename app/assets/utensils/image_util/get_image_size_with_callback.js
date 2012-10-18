//= require utensils/image_util/_image_util

utensils.ImageUtil.getImageSizeWithCallback = function( src, callback ) {
  var image = new Image();
  image.onload = function () {
    // TODO: look at naturalWidth & naturalHeight
    if( callback ) callback( image.width, image.height );
    image.onload = image.onerror = null;
  };
  image.onerror = function () {
    if( callback ) callback( -1, -1 );
    image.onload = image.onerror = null;
  };
  // load it
  image.src = src;
};
