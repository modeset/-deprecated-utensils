
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
  this.addListeners()
  this.usage_examples.trigger('click')
  this.popNotes()
};

// Find and store references to common DOM items..
Sherpa.prototype.domLookup = function() {
  this.sherpa_sections = this.el.find('.sherpa-section')
  this.sections = this.el.find('.sherpa-section > h1')
  this.subsections = this.el.find('.sherpa-section > h2')
  this.section_nav = this.el.find('.sherpa-anchor-nav li')
  this.showcases = this.el.find('.sherpa-showcase')
  this.usage_examples = this.el.find('.sherpa-showcase + pre')
};

// Listen for various events on navigations, sections and keys..
Sherpa.prototype.addListeners = function() {
  this.section_nav.on('click', {self: this}, this.activateSectionNav)
  this.usage_examples.on('click', {self: this}, this.toggleUsageExample)
  this.subsections.on('click', {self: this}, this.toggleSubsection)
  $(window).keypress({self: this}, this.captureKeyStroke)
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
  // } else {
  //   console.log(evt.which)
  }
};

// Just printing to the console for now, but just you wait..
Sherpa.prototype.toggleSettings = function() {
  if (!this.settings_shown) {
    var table = '<table><thead>'
    table += '<tr><th>Keyboard Shortcuts</th><th>&nbsp;</th></tr>'
    table += '</thead><tbody>'
    table += '<tr><td>Toggle settings window</td><td><code>&lt;SHIFT&gt; + ?</code></td></tr>'
    table += '<tr><td>Toggle showing only h1, showcase and usage blocks</td><td><code>&lt;SHIFT&gt; + x</code></td></tr>'
    table += '<tr><td>Toggle all Section documentation</td><td><code>&lt;SHIFT&gt; + w</code></td></tr>'
    table += '<tr><td>Toggle all Usage Example blocks</td><td><code>&lt;SHIFT&gt; + e</code></td></tr>'
    table += '<tr><td>Toggle all Usage blocks</td><td><code>&lt;SHIFT&gt; + u</code></td></tr>'
    table += '<tr><td>Toggle API documentation</td><td><code>&lt;SHIFT&gt; + a</code></td></tr>'
    table += '<tr><td>Toggle options documentation</td><td><code>&lt;SHIFT&gt; + o</code></td></tr>'
    table += '<tr><td>Toggle style documentation</td><td><code>&lt;SHIFT&gt; + s</code></td></tr>'
    table += '<tr><td>Toggle todo documentation</td><td><code>&lt;SHIFT&gt; + t</code></td></tr>'
    table += '<tr><td>Toggle misc. documentation</td><td><code>&lt;SHIFT&gt; + m</code></td></tr>'
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
    if (is_sandbox) {
      this.usageExampleHide(el, pre)
    }
  }
};

// Make sections linkable from the nav..
Sherpa.prototype.addSectionIds = function() {
  this.sections.each(function(index, el) {
    var $el = $(el)
    var id = $el.html().toLowerCase().replace(/\s|-/, '_')
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
    var id = $el.html().toLowerCase().replace(/\s|_/, '-')
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

// Bring the magic..
(function() {
  var sherpa = new Sherpa($('body'))
}());

