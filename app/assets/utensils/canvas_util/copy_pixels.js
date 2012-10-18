//= require utensils/canvas_util/_canvas_util

utensils.CanvasUtil.copyPixels = function( source, destination, sourceX, sourceY, sourceW, sourceH, destX, destY, destW, destH ) {
    sourceX = sourceX || 0;
    sourceY = sourceY || 0;
    sourceW = sourceW || source.canvas.width;
    sourceH = sourceH || source.canvas.height;
    destX = destX || 0;
    destY = destY || 0;
    destW = destW || source.canvas.width;
    destH = destH || source.canvas.height;
    destination.putImageData( source.getImageData( sourceX, sourceY, sourceW, sourceH ), destX, destY, destX, destY, destW, destH );
};
