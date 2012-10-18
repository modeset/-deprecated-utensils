//= require utensils/canvas_util/_canvas_util

/**
 *  Converts r, g, b, to a brightness between 0-1.
 *  @return A brightness percentage.
 *  @use    {@code CanvasUtil.rgbToBrightness(0, 255, 0);}
 */
utensils.CanvasUtil.rgbToBrightness = function( r, g, b ) {
  return (r + g + b) / 768; // 768 is r,g,b: 256*3
};
