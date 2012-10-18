//= require utensils/canvas_util/_canvas_util

/**
 *  Returns the percent difference between 2 colors.
 *  @return A difference percentage.
 *  @use    {@code CanvasUtil.rgbDifference(0, 0, 0, 255, 255, 255);}
 */
utensils.CanvasUtil.rgbDifference = function( r1, g1, b1, r2, g2, b2 ) {
  return Math.abs((r1 + g1 + b1) - (r2 + g2 + b2)) / 765;
};
