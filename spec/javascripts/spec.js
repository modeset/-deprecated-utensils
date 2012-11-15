//= require jquery.min

//= require utensils/directional/spec
//= require utensils/utensils/spec
//= require utensils/bindable/spec
//= require utensils/detect/spec
//= require utensils/timesicle/spec
//= require utensils/timeslot/spec
//= require utensils/triggerable/spec
//= require utensils/toggle/spec
//= require utensils/toggle_group/spec

//= require utensils/dismiss/spec
//= require utensils/drop/spec
//= require utensils/collapse/spec
//= require utensils/tab/spec
//= require utensils/pop/spec
//= require utensils/tip/spec
//= require utensils/progress/spec
//= require utensils/modal/spec

//= require_tree ./

// Jasmine (rice) defaults to the HTML Reporter, yank it out
// in favor of the Trivial Reporter... it's way faster!
(function() {
  var jasmineEnv = jasmine.getEnv()
  jasmineEnv.reporter.subReporters_.shift()
  var reporter = new jasmine.TrivialReporter()
  jasmineEnv.addReporter(reporter)
}())

