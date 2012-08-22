
#= require namespace
#= require bindable
#= require toggler

class roos.Tooltip extends roos.Toggler
  constructor: (el) ->
    @el = $(el)
    @tmpl_head = 'tooltip/templates/tooltip_'
    @tmpl_type = roos.tmpl_type || 'hamlc'
    super(el)

  options: ->
    super()
    @event_type = 'hover'
    @content = @el.attr('title')

  toggle: (e) =>
    super(e)
    if @is_active then @show() else @hide()


  render: ->
    str = """
          <div class="tooltip top">
            <div class="tooltip-arrow"></div>
            <div class="tooltip-inner">#{@content}</div>
          </div>
      """
    return str

  show: ->
    $('body').append(@render())
    $('.tooltip').css(top: 0, left: 0, display: 'block')

  hide: ->
    $('.tooltip').remove()

Bindable.register 'tooltip', roos.Tooltip

