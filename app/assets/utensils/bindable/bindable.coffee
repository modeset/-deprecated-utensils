#= require utensils/utensils

class utensils.Bindable
  constructor: (context=$('body'), @dataKey='bindable')->
    @bindables = $("[data-#{@dataKey}]", context)
    @instanceKey = "#{@dataKey}-instance"


  bindAll: ->
    @bind(el) for el in @bindables
    @


  getRefs: ->
    $(bindable).data(@instanceKey) for bindable in @bindables


  dispose: ->
    for bindable in @bindables
      bindable = $(bindable)
      if instance = bindable.data(@instanceKey)
        instance.release() if typeof instance?.release is 'function'
        instance.dispose() if typeof instance?.dispose is 'function'
        bindable.data(@instanceKey, null)

    delete @bindables
    @bindables = []


  # Marked for Deprecation
  release: ->
    @dispose()


  bind: (el, dataKey=@dataKey) ->
    el = $(el)
    key = el.data(dataKey)
    if _class = @constructor.getClass(key)
      el.data(@instanceKey, new _class(el)) unless el.data(@instanceKey)
    else
      console?.error "Bindable for key: #{key} not found in Bindable.registry for instance", el


  @getClass: (key) ->
    @registry[key]?.class


  @register: (key, klass) ->
    @registry ?= {}
    @registry[key] = {class: klass}
    return null

