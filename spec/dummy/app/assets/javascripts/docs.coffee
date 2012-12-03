#= require jquery.min
#= require application
#= require docomo

class docomo.Docs extends docomo.Docomo
  constructor: ($, @el) ->
    super($, @el)


  initialize: ->
    super()
    @progress = @el.find '.progress'
    @flash_demo = @el.find '#demo_flash_message nav:last-child .btn'
    @upgrade_btns = @el.find '#upgrade_demo .btn'
    @sliderDemo()


  addListeners: ->
    super()
    @el.find('[href=#]').on 'click', (e) => e.preventDefault()
    @progress.on 'click.docomo:progress', => @demoProgressBar arguments...
    @flash_demo.on 'click.docomo:flash', => @demoFlashMessage arguments...
    @upgrade_btns.on 'click.docomo:upgrade', => @demoUpgradeMessage arguments...


  removeListeners: ->
    super()
    @progress.off 'click.docomo:progress'
    @flash_demo.off 'click.docomo:flash'
    @upgrade_btns.off 'click.docomo:upgrade'


  keyed: (e) ->
    super(e)
    @toggleSpecs() if e.keyCode is 74        # "j"


  toggleSpecs: ->
    @spec_template ?= @templSpec()
    if @spec_frame
      @spec_frame.remove() && @spec_frame = null
    else
      @spec_frame = @spec_template.appendTo(@el)


# UTENSIL DEMOS #


  demoProgressBar: (e) ->
    target = $(e.target)
    pb = if target.hasClass 'progress' then target else target.closest '.progress'
    progress = new utensils.Progress(pb).set Math.floor Math.random() * 101


  demoFlashMessage: (e) ->
    @memoized_fm ?= @el.find '#flash_message'
    notification = @templFlashNotification $(e.target).data 'type'
    notification.appendTo @memoized_fm
    new utensils.Dismiss notification, autoDismiss: 2000


  demoUpgradeMessage: (e) ->
    @upgrades ?= @el.find '.upgrade-notifications'
    target = $(e.target)

    setTimeout(( =>
      state = if target.hasClass 'active' then 'block' else 'none'
      overall = if @upgrade_btns.hasClass 'active' then 'block' else 'none'
      @upgrades.find(".#{target.data 'toggle'}").css display: state
      @upgrades.css display: overall, position: 'fixed'
    ), 10)


  sliderDemo: ->
    slider_el = @el.find '#slider_control'
    handle = slider_el.find '.slider-handle'
    progress = slider_el.find '.slider-progress'
    slider = new utensils.Slider slider_el[0], handle[0], progress[0], (val) -> progress.html Math.round val


# DEMO TEMPLATES #


  templShortcut: ->
    """
    #{super()}
    <SHIFT> + j \tToggle the spec window
    """


  templFlashNotification: (modifier) ->
    templ = """
            <li class='notification fade in #{modifier}'>
              <p>This is a message</p>
              <a class="close" href="#">&times;</a>
            </li>
            """
    $(templ)


  templSpec: (url="/jasmine") ->
    templ = """
            <div id="jasmine_frame">
              <iframe frameborder="0" seamless="true" src="#{url}"></iframe>
            </div>
            """
    $(templ)

(->
  new docomo.Docs($)
)()

