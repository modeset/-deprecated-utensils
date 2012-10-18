//= require utensils/image_util/_image_util

utensils.ImageUtil.preloadImageWithCallback = function( src, callback ) {
  var image = new Image();
  image.onload = image.onerror = function () {
    image.onload = image.onerror = null;
    callback(image);
  };
  // image.crossOrigin = '';  also: crossorigin="anonymous" in the <img> 
  image.src = src;
};
