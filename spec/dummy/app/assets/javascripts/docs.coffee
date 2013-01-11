#= require docomo

class docomo.Docs extends docomo.Docomo
  constructor: ($, @el) ->
    super $, @el


  initialize: ->
    super()
    @progress = @el.find '.progress'
    @flash_demo = @el.find '#demo_flash_message .btn'
    @upgrade_btns = @el.find '#upgrade_demo .btn'
    @modifiers_demos = @el.find '.modifier-demo'
    @form_demo = @el.find '#demo_form'
    @demoSlider()


  addListeners: ->
    super()
    @el.find('[href=#]').on 'click', (e) => e.preventDefault()
    @progress.on 'click.docomo:progress', => @demoProgressBar arguments...
    @flash_demo.on 'click.docomo:flash', => @demoFlashMessage arguments...
    @upgrade_btns.on 'click.docomo:upgrade', => @demoUpgradeMessage arguments...
    @modifiers_demos.on 'click.docomo:modifier', => @demoModifiers arguments...
    @form_demo.on 'click.docomo:form_demo', => @demoForm arguments...


  removeListeners: ->
    super()
    @progress.off 'click.docomo:progress'
    @flash_demo.off 'click.docomo:flash'
    @upgrade_btns.off 'click.docomo:upgrade'
    @modifiers_demos.off 'click.docomo:modifier'
    @form_demo.off 'click.docomo:form_demo'


  keyed: (e) ->
    super(e)
    @toggleSpecs() if e.keyCode is 74        # "j"


  toggleSpecs: ->
    @spec_template ?= @templSpec()
    if @spec_frame
      @spec_frame.remove() and @spec_frame = null
    else
      @spec_frame = @spec_template.appendTo @el


# UTENSIL DEMOS #

  demoModifiers: (e) ->
    target = $(e.target)
    demo = target.closest('.docomo-showcase').find '.demo'
    data_targets = demo.data 'target'
    demo_targets = if data_targets is 'this' then demo else demo.find data_targets
    if target.data 'toggle'
      demo_targets.toggleClass target.data 'toggle'
    else
      demo_targets.removeClass demo.data 'remove'
      demo_targets.addClass target.data 'add'


  demoFlashMessage: (e) ->
    @memoized_fm ?= @el.find '#flash_message_demo'
    target = $(e.target)
    if target.data 'type'
      notification = @templFlashNotification target.data 'type'
      notification.appendTo @memoized_fm
      new utensils.Dismiss notification, autoDismiss: 2000
    else
      @fm_remove_classes ?= @el.find('#demo_flash_message > .button-group:first').data 'remove'
      @memoized_fm.removeClass(@fm_remove_classes).addClass(target.data 'add')


  demoUpgradeMessage: (e) ->
    @upgrades ?= @el.find '.upgrade-notifications'
    target = $(e.target)

    setTimeout(( =>
      state = if target.hasClass 'active' then 'block' else 'none'
      overall = if @upgrade_btns.hasClass 'active' then 'block' else 'none'
      @upgrades.find(".#{target.data 'toggle'}").css display: state
      @upgrades.css display: overall, position: 'fixed'
    ), 10)


  demoProgressBar: (e) ->
    target = $(e.target)
    pb = if target.hasClass 'progress' then target else target.closest '.progress'
    progress = new utensils.Progress(pb).set Math.floor Math.random() * 101


  demoSlider: ->
    slider_el = @el.find '#slider_control'
    handle = slider_el.find '.slider-handle'
    progress = slider_el.find '.slider-progress'
    slider = new utensils.Slider slider_el[0], handle[0], progress[0], (val) -> progress.html Math.round val


  demoForm: (e) ->
    target = $(e.target)
    @memoized_form ?= @el.find('#demo_form').next('form')
    add_classes = target.data 'add'
    remove_classes = target.closest('.button-group').data 'remove'
    is_state_group = (/disabled/).test(remove_classes)

    # Re-enable all the form elements
    if is_state_group
      @memoized_form.find('input,textarea,select').removeAttr("disabled")
      @memoized_form.find('.uneditable-field').attr("disabled", "disabled")

    # Add a status class to correct elements
    if is_state_group and add_classes isnt 'disabled'
      @memoized_form.find('.control-group').removeClass(remove_classes).addClass add_classes

    # Add disabled states to correct elements
    else if is_state_group and add_classes is 'disabled'
      @memoized_form.find('input,textarea,select').attr("disabled", "disabled")
      @memoized_form.find('.control-group').removeClass(remove_classes).addClass(add_classes)

    # Add top level classes for `form` (wells, layout)
    else
      @memoized_form.removeClass(remove_classes).addClass(add_classes)


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


  templSpec: (url="/teabag") ->
    templ = """
            <div id="jasmine_frame">
              <iframe frameborder="0" seamless="true" src="#{url}"></iframe>
            </div>
            """
    $(templ)

(->
  new docomo.Docs($)
)()

