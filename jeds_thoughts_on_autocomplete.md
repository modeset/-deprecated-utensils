# Autocomplete implementation

stream of thought to be deleted....

Pulling this out of [pinnacol](https://github.com/modeset/pinnacol-assurance-online/blob/master/app/assets/javascripts/manage/components/tags/taggable.coffee), we want to use as much of that as possible.

Autocomplete should be bindable through data attributes, thinking off
the top of my head:

  - collection may be finite and ok to fetch all of them at once `data-collection='/posts/categories'`
  - collection may be infinite and should be configurable to handle a query function, function object, or the like `data-collection= myapp.PostCategories`

seems like in order to make the autocomplete component usable it is almost always going to be instantiated from within another component where you can orchestrate the behaviour as we probably need to _do_ something with the selection, once it is selected. perhaps that is data bindable also with like `data-selection-endpoint-url=/posts/categories/new` or some such nonsense.  

in the case of pinnacol, the user can create new tags or select old ones, in the the case of the next use case in qdoba, we are selecting from an infinte list but the user cannot create a new item to be posted. I'm not sure the best way to be able to support this kind of action configurably from data attributes.

The standard use case i can imagine is something more like

```coffeescript
class UserSelect

  constructor: (el)->
    @el = el
    @autocompleter = new utensils.Autocomplete(@el.find('input'))
    @bind @autocompleter.SELECT => @chooseUser(arguments...)

  @chooseUser(e, user)->
    args =
      url     : "/uesrs/#{user.id}"
      type    : 'GET'
      success : => @displayUser(arguments...)
      error   : console?.log "error"
    $.ajax(args)

  @displayUser(data)->
    @el.html(JST['views/user_details'])

```

comments?
