#= require utensils/utensils

utensils.CanvasUtil ?= {}

utensils.CanvasUtil.clearColor = 'rgba(0,0,0,0)'

utensils.CanvasUtil.dataImgPrefix = 'data:image/png;base64,'

utensils.CanvasUtil.hasCanvas = if !document.createElement('canvas').getContext then false else true