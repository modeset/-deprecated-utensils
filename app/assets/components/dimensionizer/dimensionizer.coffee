
#= require roos
#= require detect
class roos.Dimensionizer
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
    @window = $(window)
    $('body').append(@render())
    @dimensionizer = $('#dimensionizer')
    @resize()
    @addListeners()

  addListeners: ->
    @window.on('resize', @resize)
    @dimensionizer.one('click', @remove)

  resize: =>
    @dimensionizer.html(@window.width() + 'px')

  remove: =>
    if @dimensionizer && roos.Detect.hasTransition
      @dimensionizer.one(roos.Detect.transition.end, => @dispose())
      @dimensionizer.removeClass('in')
    else
      @dispose()

  dispose: ->
    @window.off('resize', @resize)
    @dimensionizer.remove()

  render: ->
    html = """
          <div id="dimensionizer" class="fade in" style="
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

