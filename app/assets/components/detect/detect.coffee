
# usage: $(el).on(utensil.Detect.transition.end, @onDone) if utensil.Detect.hasTransition

#= require utensil
class utensil.Detect

  # Describes browser detection for transition end events
  # utensil.Detect.transition.end
  # utensil.Detect.hasTransition
  @transition = (=>
    transitionEnd = (->
      el = document.createElement("tranny")
      transEndEventNames =
        WebkitTransition: "webkitTransitionEnd"
        MozTransition: "transitionend"
        OTransition: "oTransitionEnd"
        msTransition: "MSTransitionEnd"
        transition: "transitionend"
      name = undefined
      for name of transEndEventNames
        return transEndEventNames[name]  if el.style[name] isnt `undefined`
    )()
    @hasTransition = true if transitionEnd
    return {end: transitionEnd} if transitionEnd
  )()

