//= require utensils/canvas_util/_canvas_util

/**
 *  Converts r, g, b, a values to canvas-friendly rgba string.
 *  @return An rgba color string.
 *  @use    {@code CanvasUtil.rgbToCanvasColor(0, 0, 0, 0.5);}
 */
utensils.CanvasUtil.rgbToCanvasColor = function( r, g, b, opacity ) {
  return "rgba("+r+","+g+","+b+","+opacity+")";
};

