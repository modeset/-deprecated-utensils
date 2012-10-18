//= require utensils/canvas_util/_canvas_util

/**
 *  Draws a filled circle. Original code from Robin W. Spencer (http://scaledinnovation.com).
 *  @use    {@code CanvasUtil.drawCircle( context, 50, 50, 40 );}
 */
utensils.CanvasUtil.drawCircle = function( ctx, x, y, radius, extraSetup ) {
  ctx.save();
  if( extraSetup ) extraSetup( ctx );
  ctx.beginPath();
  ctx.arc( x, y, radius, 0.0, 2 * Math.PI, false );
  ctx.closePath();
  ctx.stroke();
  ctx.fill();
  ctx.restore();
};
