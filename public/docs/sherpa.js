
/*global utensil */

/*
    Controls various states within the style guide
    This whole thing is a big fat mess at the moment.
    Don't try this at home, it will get better... promise.
*/

// Adds behavior to the sherpa documentation..
var Sherpa = function(el) {
  this.el = el
  this.initialize()
};

// Get the party started..
Sherpa.prototype.initialize = function() {
  this.usage_sections = []
  this.api_sections = []
  this.options_sections = []
  this.style_sections = []
  this.todo_sections = []
  this.misc_sections = []
  this.settings_shown = false
  this.domLookup()
  this.addSectionIds()
  this.addSubsectionClasses()
  this.usage_examples = this.addUsageExampleToggler()
  this.clean()
  this.addListeners()
  this.usage_examples.trigger('click')
  this.popNotes()
  this.initialProgress()
  this.is_jasmine_shown = false
  // this.toggleSandbox()
};

// Find and store references to common DOM items..
Sherpa.prototype.domLookup = function() {
  this.sherpa_sections = this.el.find('.sherpa-section')
  this.sections = this.el.find('.sherpa-section > h1')
  this.subsections = this.el.find('.sherpa-section > h2')
  this.section_nav = this.el.find('.sherpa-anchor-nav li')
  this.showcases = this.el.find('.sherpa-showcase')
  this.usage_examples = this.el.find('.sherpa-showcase + pre')
  this.radio_demos = this.el.find('.radio-demo')
  this.check_demos = this.el.find('.check-demo')
  this.form_demo = this.el.find('#demo_form').next('form')
};

// Listen for various events on navigations, sections and keys..
Sherpa.prototype.addListeners = function() {
  this.section_nav.on('click', {self: this}, this.activateSectionNav)
  this.usage_examples.on('click', {self: this}, this.toggleUsageExample)
  this.subsections.on('click', {self: this}, this.toggleSubsection)
  this.radio_demos.on('click', {self: this}, this.radioDemo)
  this.check_demos.on('click', {self: this}, this.checkDemo)
  $('#demo_form').on('click', {self: this}, this.formDemo)
  $(window).keypress({self: this}, this.captureKeyStroke)
  $('#dimensionizer_demo').on('click', {self: this}, this.activateDimensionizer)
  this.showcases.find('[href=#]').on('click', function(e){e.preventDefault()})
  $('.progress').on('click', {self: this}, this.demoProgress)
};

Sherpa.prototype.addJasmine = function() {
  var self = this
  var frame = $('<div id="jasmine_frame"><iframe frameborder="0" seamless="true" src="/jasmine"></iframe></div>')
  frame.appendTo(this.el)
  frame.one('click', {self:this}, this.removeJasmine)
  this.is_jasmine_shown = true
};

Sherpa.prototype.removeJasmine = function(e) {
  $('#jasmine_frame').remove()
  this.is_jasmine_shown = false
};

Sherpa.prototype.toggleJasmine = function(e) {
  if (this.is_jasmine_shown) {
    this.removeJasmine()
  } else {
    this.addJasmine()
  }
};

// Typically handles toggling items associated with the settings menu..
Sherpa.prototype.captureKeyStroke = function(evt) {
  var self = evt.data.self
  var a = 65
  var o = 79
  var s = 83
  var m = 77
  var w = 87
  var u = 85
  var e = 69
  var t = 84
  var x = 88
  var j = 74

  if (evt.which === 63 && evt.shiftKey) {
    self.toggleSettings()
  } else if (evt.which === x && evt.shiftKey) {
    self.toggleSandbox()
  } else if (evt.which === w && evt.shiftKey) {
    self.subsections.trigger('click')
  } else if (evt.which === e && evt.shiftKey) {
    self.usage_examples.trigger('click')
  } else if (evt.which === u && evt.shiftKey) {
    self.toggleSubsectionByGrouping(self.usage_sections)
  } else if (evt.which === a && evt.shiftKey) {
    self.toggleSubsectionByGrouping(self.api_sections)
  } else if (evt.which === o && evt.shiftKey) {
    self.toggleSubsectionByGrouping(self.options_sections)
  } else if (evt.which === s && evt.shiftKey) {
    self.toggleSubsectionByGrouping(self.style_sections)
  } else if (evt.which === t && evt.shiftKey) {
    self.toggleSubsectionByGrouping(self.todo_sections)
  } else if (evt.which === m && evt.shiftKey) {
    self.toggleSubsectionByGrouping(self.misc_sections)
  } else if (evt.which === j && evt.shiftKey) {
    self.toggleJasmine()
  // } else {
    // console.log(evt.which)
  }
};

// Just printing to the console for now, but just you wait..
Sherpa.prototype.toggleSettings = function() {
  if (!this.settings_shown) {
    var table = '<table><thead>'
    table += '<tr><th>Keyboard Shortcuts</th><th>&nbsp;</th></tr>'
    table += '</thead><tbody>'
    table += '<tr><td>Toggle showing only h1, showcase and usage blocks</td><td><code>&lt;SHIFT&gt; + x</code></td></tr>'
    table += '<tr><td>Toggle the Jasmine notification window</td><td><code>&lt;SHIFT&gt; + j</code></td></tr>'
    table += '<tr><td>Toggle all Section documentation</td><td><code>&lt;SHIFT&gt; + w</code></td></tr>'
    table += '<tr><td>Toggle all Usage Example blocks</td><td><code>&lt;SHIFT&gt; + e</code></td></tr>'
    table += '<tr><td>Toggle all Usage blocks</td><td><code>&lt;SHIFT&gt; + u</code></td></tr>'
    table += '<tr><td>Toggle API documentation</td><td><code>&lt;SHIFT&gt; + a</code></td></tr>'
    table += '<tr><td>Toggle options documentation</td><td><code>&lt;SHIFT&gt; + o</code></td></tr>'
    table += '<tr><td>Toggle style documentation</td><td><code>&lt;SHIFT&gt; + s</code></td></tr>'
    table += '<tr><td>Toggle todo documentation</td><td><code>&lt;SHIFT&gt; + t</code></td></tr>'
    table += '<tr><td>Toggle misc. documentation</td><td><code>&lt;SHIFT&gt; + m</code></td></tr>'
    table += '<tr><td>Toggle settings window</td><td><code>&lt;SHIFT&gt; + ?</code></td></tr>'
    table += '</tbody></table>'
    this.el.prepend('<div class="sherpa-settings">' + table + '</div>')
  } else {
    this.el.find('.sherpa-settings').remove()
  }
  this.settings_shown = !this.settings_shown
};

// Toggle the h1, showcase, and usage example
Sherpa.prototype.toggleSandbox = function() {
  this.sherpa_sections.children().toggleClass('sherpa-hidden')
  this.sections.removeClass('sherpa-hidden')
  this.showcases.removeClass('sherpa-hidden')
  this.usage_examples.removeClass('sherpa-hidden')
  var is_sandbox = this.sherpa_sections.children().first().hasClass('sherpa-hidden')

  for (var i = 0, len = this.usage_examples.length; i < len; i += 1) {
    var el = $(this.usage_examples[i])
    var pre = el.next('pre')
    this.usageExampleHide(el, pre)
  }
};

// Make sections linkable from the nav..
Sherpa.prototype.addSectionIds = function() {
  this.sections.each(function(index, el) {
    var $el = $(el)
    var id = $el.html().toLowerCase().replace(/\s|-|&amp;|,/g, '_')
    $el.attr('id', id)
  })
};

// Aside navigation toggling..
Sherpa.prototype.activateSectionNav = function(e) {
  var el = $(e.target).closest('li')
  var self = e.data.self
  self.section_nav.removeClass('active')
  el.addClass('active')
};

// Make sub section headers togglable..
Sherpa.prototype.addSubsectionClasses = function() {
  var self = this
  this.subsections.each(function(index, el) {
    var $el = $(el)
    var id = $el.html().toLowerCase().replace(/\s|_|&amp;|,/g, '-')
    $el.addClass(id + ' sherpa-togglable')
    $el.attr('title', 'Toggle Section')
    self.addSubsectionToGrouping(id, $el)
  })
};

// Associate common sub sections together for toggling via settings..
Sherpa.prototype.addSubsectionToGrouping = function(title, el) {
  if (title.match(/^usage/)) {
    this.usage_sections.push(el)
  } else if (title.match(/^api|^behavior/)) {
    this.api_sections.push(el)
  } else if (title.match(/^option/)) {
    this.options_sections.push(el)
  } else if (title.match(/^style|^css|^sass/)) {
    this.style_sections.push(el)
  } else if (title.match(/^todo/)) {
    this.todo_sections.push(el)
  } else {
    this.misc_sections.push(el)
  }
};

// Response to clicking on a sub section heading..
Sherpa.prototype.toggleSubsection = function(e) {
  var el = $(e.target)
  var self = e.data.self
  el.toggleClass('sherpa-closed')
  el.nextUntil('h2').toggleClass('sherpa-hidden')
};

// Iterate through the grouping of sub section labels and toggle them..
Sherpa.prototype.toggleSubsectionByGrouping = function(grouping) {
  for (var i = 0, len = grouping.length; i < len; i += 1) {
    grouping[i].trigger('click')
  }
};

// Usage Example Toggling..
Sherpa.prototype.addUsageExampleToggler = function() {
  var contents = '<h4 class="sherpa-togglable sherpa-togglable-usage-example" title="Toggle Usage">View Usage</h4>'
  this.showcases.each(function(index, el) {
    $(el).after(contents)
  })
  return this.el.find('.sherpa-togglable-usage-example')
};

// Cleanup empty `p` tags being generated from the compiler (see sherpa/todo.md)..
Sherpa.prototype.clean = function() {
  var ptags = $('p')
  ptags.each(function(index, el) {
    var $el = $(el)
    if($el.is(':empty')) {
      $el.remove()
    }
  })
};

// Toggle a usage example
Sherpa.prototype.toggleUsageExample = function(e) {
  var el = $(e.target)
  var self = e.data.self
  var pre = el.next('pre')
  var state = pre.hasClass('sherpa-hidden') ? self.usageExampleShow(el, pre) : self.usageExampleHide(el, pre)
};

// Switch the text when a usage example is shown..
Sherpa.prototype.usageExampleShow = function(el, pre) {
  var text = el.html()
  el.html(text.replace(/^View/, 'Hide'))
  el.removeClass('sherpa-closed')
  pre.removeClass('sherpa-hidden')
  return 'shown'
};

// Switch the text when a usage example is hidden..
Sherpa.prototype.usageExampleHide = function(el, pre) {
  var text = el.html()
  el.html(text.replace(/^Hide/, 'View'))
  el.addClass('sherpa-closed')
  pre.addClass('sherpa-hidden')
  return 'hidden'
};

// Colorize lists under certain h6's for style (h6 is hidden btw)
Sherpa.prototype.popNotes = function() {
  var sixes = this.el.find('.sherpa-section > h6')
  var self = this
  sixes.each(function(index, el) {
    var $el = $(el)
    var text = $el.html().toLowerCase()
    var next = $el.next('ul')
    if (text.match(/^note|^warning|^alert|^deprec/) && next.length > 0) {
      $el.css({display:'none'})
      next.addClass('sherpa-notes')
      if (text.match(/^warning/)) {
        next.addClass('sherpa-warnings')
      }
      else if (text.match(/^alert|^deprec/)) {
        next.addClass('sherpa-alerts')
      }
    }
  })
};

// Demos

// Activate the dimensionizer tool..
Sherpa.prototype.activateDimensionizer = function(e) {
  e.preventDefault()
  var dimensionizer = new utensil.Dimensionizer()
};

Sherpa.prototype.initialProgress = function() {
  var pb = this.el.find('.progress.important').first()
  setTimeout(function() {
    var progress = new utensil.Progress(pb)
  }, 1000)
};

Sherpa.prototype.demoProgress = function(e) {
  var self = e.data.self
  var target = $(e.target)
  var pb = target.hasClass('progress') ? target : target.closest('.progress')
  var progress = new utensil.Progress(pb)
  progress.set(Math.floor(Math.random() * 101))
};

// Demos using radio groups..
Sherpa.prototype.radioDemo = function(e) {
  var self = e.data.self
  var target = $(e.target)
  var demo = target.closest('.sherpa-showcase').find('.demo')
  var data_targets = demo.data('target')
  var demo_targets = (data_targets === 'this') ? demo : demo.find(data_targets)
  var add_classes = target.data('add')
  var remove_classes = demo.data('remove')
  demo_targets.removeClass(remove_classes)
  demo_targets.addClass(add_classes)
};

// Demos using check groups
Sherpa.prototype.checkDemo = function(e) {
  var self = e.data.self
  var target = $(e.target)
  var demo = target.closest('.sherpa-showcase').find('.demo')
  var data_targets = demo.data('target')
  var demo_targets = (data_targets === 'this') ? demo : demo.find(data_targets)
  var toggle_classes = target.data('toggle')
  demo_targets.toggleClass(toggle_classes)
};

Sherpa.prototype.formDemo = function(e) {
  var self = e.data.self
  var target = $(e.target)
  var form = self.form_demo
  var add_classes = target.data('add')
  var remove_classes = target.closest('.button-group').data('remove')

  var is_state_group = (/disabled/).test(remove_classes)

  // Re-enable all the form elements
  if (is_state_group) {
    form.find('input,textarea,select').removeAttr("disabled")
    form.find('.uneditable-field').attr("disabled", "disabled")
  }

  // Add a status class to correct elements
  if (is_state_group && add_classes !== 'disabled') {
    form.find('.control-group').removeClass(remove_classes).addClass(add_classes)

  // Add disabled states to correct elements
  } else if (is_state_group && add_classes === 'disabled') {
    form.find('input,textarea,select').attr("disabled", "disabled")
    form.find('.control-group').removeClass(remove_classes).addClass(add_classes)

  // Add top level classes for `form` (wells, layout)
  } else {
    form.removeClass(remove_classes).addClass(add_classes)
  }
};

// Bring the magic..
(function() {
  var sherpa = new Sherpa($('body'))
}());

