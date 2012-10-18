//= require utensils/image_util/_image_util

utensils.ImageUtil.getOffsetAndSizeToCrop = function( containerW, containerH, imageW, imageH, cropFill ) {
  var ratioW = containerW / imageW;
  var ratioH = containerH / imageH;
  var shorterRatio = ratioW > ratioH ? ratioH : ratioW;
  var longerRatio = ratioW > ratioH ? ratioW : ratioH;
  var resizedW = cropFill ? Math.ceil(imageW * longerRatio) : Math.ceil(imageW * shorterRatio);
  var resizedH = cropFill ? Math.ceil(imageH * longerRatio) : Math.ceil(imageH * shorterRatio);
  var offsetX = Math.ceil((containerW - resizedW) * 0.5);
  var offsetY = Math.ceil((containerH - resizedH) * 0.5);
  return [offsetX, offsetY, resizedW, resizedH];
};
