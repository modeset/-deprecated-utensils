//= require utensils/canvas_util/_canvas_util

/**
 *  Draws an arc - a portion of a circle.
 *  @use    {@code CanvasUtil.drawArc(context, 50, 50, 40, 90, 180);}
 */
utensils.CanvasUtil.drawArc = function( ctx, x, y, radius, startAngle, endAngle ) {
  ctx.save();
  ctx.beginPath();
  ctx.arc( x, y, radius, (Math.PI / 180) * (startAngle - 90), (Math.PI / 180) * (endAngle - 90), false );
  ctx.closePath();
  ctx.stroke();
  ctx.fill();
  ctx.restore();
};
