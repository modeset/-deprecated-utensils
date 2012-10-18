//= require utensils/canvas_util/_canvas_util

utensils.CanvasUtil.getPixelColorFromContext = function( context, x, y ) {
  var pixelData = context.getImageData( x, y, 1, 1 ).data;
  return [pixelData[0], pixelData[1], pixelData[2]];
};
