#=require utensils/utensils

class utensils.Indicator

  constructor: (@el, data, @component) ->
    @indication = @el.find('.indication')
    @initialize()

  initialize: ->
    @buildIndicators()
    @addListeners()
    @activated()

# PUBLIC #

  dispose: ->
    @component.dispatcher.off("#{@component.namespace}:transition.start")

# PROTECTED #

  buildIndicators: ->
    indicators_html = ''
    # add <li> buttons
    for i in [1..@component.num_panels]
      indicators_html += "<li><a href='#slide_#{i}'>#{i}</a></li>"
    @indication.append(indicators_html)
    # add clicks
    @indicators = @indication.find('li')
    @indication.find('a').on 'click', => @indicated arguments...

  addListeners: ->
    @component.dispatcher.on("#{@component.namespace}:transition.start", => @activated arguments...)

  activated: (e) ->
    indicator_index = @component.index % @component.num_panels  # mod page index in case of infinite scrolling
    @indicators.removeClass('active')
    @indicators.eq(indicator_index).addClass('active')

  indicated: (e) ->
    e.preventDefault()
    newIndex = $(e.target).parent().index()
    newIndex = @component.index - ( @component.index % @component.num_panels ) + newIndex # for infinite scrolling - mods the page index so we're in the current range
    @component.activate(newIndex)

