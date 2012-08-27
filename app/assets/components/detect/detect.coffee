
# usage: $(el).on(roos.Detect.transition.end, @onDone) if roos.Detect.hasTransition

#= require roos
class roos.Detect

  # Describes browser detection for transition end events
  # roos.Detect.transition.end
  # roos.Detect.hasTransition
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

