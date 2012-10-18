//= require utensils/image_util/_image_util
//= require utensils/image_util/get_offset_and_size_to_crop

utensils.ImageUtil.CROP = 'CROP';
utensils.ImageUtil.CROP_TOP = 'CROP_TOP';
utensils.ImageUtil.CROP_BOTTOM = 'CROP_BOTTOM';
utensils.ImageUtil.LETTERBOX = 'LETTERBOX';

utensils.ImageUtil.cropImage = function ( containerEl, containerW, containerH, imageEl, imageW, imageH, cropType ) {
  var cropFill = ( cropType == utensils.ImageUtil.CROP || cropType == utensils.ImageUtil.CROP_TOP || cropType == utensils.ImageUtil.CROP_BOTTOM );
  var offsetAndSize = utensils.ImageUtil.getOffsetAndSizeToCrop(containerW, containerH, imageW, imageH, cropFill);

  // set outer container size
  containerEl.style.width = containerW+'px';
  containerEl.style.height = containerH+'px';

  // resize image
  imageEl.width = offsetAndSize[2];
  imageEl.height = offsetAndSize[3];
  imageEl.style.width = offsetAndSize[2]+'px';
  imageEl.style.height = offsetAndSize[3]+'px';

  // position image
  imageEl.style.left = offsetAndSize[0]+'px';
  imageEl.style.top = offsetAndSize[1]+'px';

  // special y-positioning 
  if( cropType == utensils.ImageUtil.CROP_TOP ) {
    imageEl.style.top = '0px';
    imageEl.style.bottom = '';
  } else if( cropType == utensils.ImageUtil.CROP_BOTTOM ) {
    imageEl.style.top = '';
    imageEl.style.bottom = '0px';
  }
};