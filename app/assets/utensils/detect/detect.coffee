
# usage: $(el).on(utensils.Detect.transition.end, @onDone) if utensils.Detect.hasTransition

#= require utensils/utensils

class utensils.Detect

  # Describes browser detection for transition end events
  # utensils.Detect.transition.end
  # utensils.Detect.hasTransition
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

