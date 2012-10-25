//= require utensils/dom_util/_dom_util

utensils.DomUtil.recurseDisableElements = function ( elem, disabledElements ) {
  if( elem ) {
    // disable clicking/dragging on selected element types
    if( elem.tagName && disabledElements.indexOf( elem.tagName.toLowerCase() ) != -1 ) {  //  console.log('disabling: = '+elem.tagName.toLowerCase());
      try {
        elem.onmousedown = function(e){ return false; };  // TODO: remove this if touch events, so we can click inside??
        elem.onselectstart = function(){ return false; };
      } catch(err) {}
    }
    // loop through children and do the same
    if( elem.childNodes.length > 0 ){
      for( var i=0; i < elem.childNodes.length; i++ ) {
        utensils.DomUtil.recurseDisableElements( elem.childNodes[i], disabledElements );
      }
    }
  }
};
