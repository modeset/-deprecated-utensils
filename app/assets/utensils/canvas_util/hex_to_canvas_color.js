//= require utensils/canvas_util/_canvas_util

/**
 *  Converts a hex color value to canvas-friendly rgba. Original code from Robin W. Spencer (http://scaledinnovation.com).
 *  @return An rgba color string.
 *  @use    {@code CanvasUtil.hexToCanvasColor('#00ff00', 0.5);}
 */
utensils.CanvasUtil.hexToCanvasColor = function( hexColor, opacity ) {
  opacity = ( opacity != null ) ? opacity : "1.0";
  hexColor = hexColor.replace( "#", "" );
  var r = parseInt( hexColor.substring( 0, 2 ), 16 );
  var g = parseInt( hexColor.substring( 2, 4 ), 16 );
  var b = parseInt( hexColor.substring( 4, 6 ), 16 );
  return "rgba("+r+","+g+","+b+","+opacity+")";
};