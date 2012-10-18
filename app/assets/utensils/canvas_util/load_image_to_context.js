//= require utensils/canvas_util/_canvas_util

// useful for grabbing an image and caching it as a pixel source
utensils.CanvasUtil.loadImageToContext = function( imagePath, callback ) {
    var image = new Image();
    image.onload = function() {
        var canvasSource = document.createElement("canvas");
        canvasSource.width = image.width;
        canvasSource.height = image.height;
        var context = canvasSource.getContext("2d");
        context.drawImage( image, 0, 0 );
        callback( context );
    };
    image.src = imagePath;
};
