
# Utensils Jasmine Specs

All of the `_spec` files live within the utensil's directory alongside
their behavior, style and markup files.

Jasmine is setup under [jasminerice](https://github.com/bradphelan/jasminerice), which
incorporates a patched version of [jasmine-jquery](https://github.com/velesin/jasmine-jquery)

The fixtures in `/spec/javascripts/fixtures/` are copied in from each
utensil's markup directory. This is invoked by the rake task:

```ruby
bundle exec rake fixtures
```
Note, this directory is blown away every time this task is run, so don't
drop anything in here that doesn't belong.

## View Specs
Run the Jasmine spec's at `/jasmine`

