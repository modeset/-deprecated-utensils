#= require utensils/detect

describe 'Detect', ->

  describe 'transition', ->
    it 'creates the transition object', ->
      expect(utensils.Detect.transition).not.to.be undefined

    it 'returns one of the existing strings based on the browser', ->
      el = document.createElement('transition')
      transEndEventNames =
        WebkitTransition: "webkitTransitionEnd"
        MozTransition: "transitionend"
        OTransition: "oTransitionEnd"
        msTransition: "MSTransitionEnd"
        transition: "transitionend"
      value = undefined
      for name of transEndEventNames
        value = transEndEventNames[name]  if el.style[name] isnt `undefined`
      expect(value).to.be utensils.Detect.transition.end

    it 'reports whether the users browser has transition end support', ->
      if utensils.Detect.transition.end
        expect(utensils.Detect.hasTransition).to.be true
      else
        expect(utensils.Detect.hasTransition).to.be false

