//= require utensils/image_util/crop_image

/*
 *  Requires a <div> (container) with an <img> as the first child.
 *  Also requires a little CSS.
 *
 *  div.section-background
 *    position: relative
 *    overflow: hidden
 *
 *    img
 *      position: absolute
 *      max-width: none
 */

utensils.ImageCrop = function ( container, width, height, origW, origH, scaleType, imgIndex ) {

  var _containerW = width;
  var _containerH = height;
  var _imgOrigW = origW;
  var _imgOrigH = origH;
  var _scaleType = scaleType;

  var imgIndex = imgIndex || 0;
  var _img = container.getElementsByTagName('img')[imgIndex] || null;

  if( typeof DOMUtil !== 'undefined' ) DOMUtil.recurseDisableElements( _img, ['img'] );

  var init = function() {
    resize();
  };

  var updateContainerSize = function ( width, height ) {
    _containerW = width;
    _containerH = height;
    resize();
  };
  
  var setScaleType = function ( scaleType ) {
    _scaleType = scaleType;
    resize();
  };

  var resize = function() {
    utensils.ImageUtil.cropImage( container, _containerW, _containerH, _img, _imgOrigW, _imgOrigH, _scaleType )
  };

  var dispose = function () {
    container = null;
    _img = null;
  };

  init();

  return {
    updateContainerSize : updateContainerSize,
    setScaleType : setScaleType,
    resize : resize,
    dispose: dispose
  };
};



