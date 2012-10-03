
#= require utensil
#= require detect

class utensil.Dimensionizer
  constructor: (data) ->
    @data = if data then data else {}
    @options()
    @initialize()

  options: ->
    @pos_x = @data.pos_x || 'right'
    @pos_y = @data.pos_y || 'top'
    @offset = @data.offset || '5'
    @bg_color = if @data.color then 'rgba(255,255,255,0.7)' else 'rgba(0,0,0,0.7)'
    @color = if @data.color then '#000' else '#fff'

  initialize: ->
    @win = $(window)
    $('body').append(@render())
    @dimensionizer = $('#_dimensionizer')
    @resize()
    @addListeners()

  addListeners: ->
    @win.on('resize.dimensionizer', => @resize arguments...)
    @dimensionizer.one('click.dimensionizer', => @remove arguments...)

  resize: ->
    @dimensionizer.html(@win.width() + 'px')

  remove: ->
    if @dimensionizer && utensil.Detect.hasTransition
      @dimensionizer.one(utensil.Detect.transition.end, => @dispose arguments...)
      @dimensionizer.removeClass('in')
    else
      @dispose()

  dispose: ->
    @win.off('resize.dimensionizer')
    @dimensionizer.remove()

  render: ->
    html = """
           <div id="_dimensionizer" class="fade in" style="
             position:fixed;
             #{@pos_y}:#{@offset}px;
             #{@pos_x}:#{@offset}px;
             background-color:#{@bg_color};
             border-radius:0.5em;
             font-weight:bold;
             color:#{@color};
             cursor:default;
             padding:0.5em;
             z-index:99999;
           ">
           </div>
           """
    return html

