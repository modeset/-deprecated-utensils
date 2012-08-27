
#= require detect
describe 'Detect', ->

  describe 'transition', ->
    it 'creates the transition object', ->
      expect(roos.Detect.transition).toBeDefined()

    it 'returns one of the existing strings based on the browser', ->
      el = document.createElement('tranny')
      transEndEventNames =
        WebkitTransition: "webkitTransitionEnd"
        MozTransition: "transitionend"
        OTransition: "oTransitionEnd"
        msTransition: "MSTransitionEnd"
        transition: "transitionend"
      value = undefined
      for name of transEndEventNames
        value = transEndEventNames[name]  if el.style[name] isnt `undefined`
      expect(value).toEqual(roos.Detect.transition.end)

    it 'reports whether the users browser has transition end support', ->
      if roos.Detect.transition.end
        expect(roos.Detect.hasTransition).toEqual(true)
      else
        expect(roos.Detect.hasTransition).toEqual(false)

