#= require utensils/utensils

class utensils.Detect

  # Describes browser detection for transition end events
  # utensils.Detect.transition.end
  # utensils.Detect.hasTransition
  @transition = (=>
    transitionEnd = (->
      el = document.createElement("transition")
      transEndEventNames =
        WebkitTransition: "webkitTransitionEnd"
        MozTransition: "transitionend"
        transition: "transitionend"
      name = undefined
      for name of transEndEventNames
        return transEndEventNames[name]  if el.style[name] isnt `undefined`
    )()
    @hasTransition = if transitionEnd then true else false
    return {end: transitionEnd ?= false}
  )()

