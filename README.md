# Utensils

[![Build Status](https://travis-ci.org/modeset/utensils.png?branch=master)](https://travis-ci.org/modeset/utensils)

Client side component library, tuned to work with the asset pipeline.

[utensils.modeset.com](http://utensils.modeset.com/)


## Installation
Currently not yet released as a gem, so rock the latest from GitHub in
your `Gemfile`.

```
gem 'utensils', github: 'modeset/utensils'
```

Utensils is under continuous development. It's stable, but is subject to
changes.


## Development
Use the interactive docs via [docomo](https://github.com/modeset/docomo)
at `/docs/live` for on the fly documentation generation.

View the tests through [teabag](https://github.com/modeset/teabag) at
`/teabag`, or run them from the CLI with:

```
rake teabag
```

Prior to committing, make sure to generate the latest static assets by
running:

```
rake utensils:document
```

### Generators
Utensils comes packed with a few generators for your pleasure:

```
utensils:component [file_name]  - stubs a new component with sass/cs files
utensils:utensil [file_name]    - stubs a new utensil with sass/cs/spec/markup files
```


## Roadmap
- Add Generators (install)
- Release the gem (check the name)
- Complete Todo items
- Background scaler
- Stateful button
- Spinner
- Auto Complete
- Migrate [modeset.js](https://github.com/modeset/modeset.js) files
- Mobilize (templates, styles, cs, etc..)


## License
Licensed under the [MIT License](http://creativecommons.org/licenses/MIT/)

Copyright 2013 [Mode Set](https://github.com/modeset)


## Talk Nerdy To Me
![crest](https://secure.gravatar.com/avatar/aa8ea677b07f626479fd280049b0e19f?s=75)

