$:.push File.expand_path("../lib", __FILE__)

require "utensils/version"

Gem::Specification.new do |s|
  s.name        = "utensils"
  s.version     = Utensils::VERSION
  s.authors     = ["Mode Set"]
  s.email       = ["info@modeset.com"]
  s.homepage    = "https://github.com/modeset/utensils"
  s.summary     = "Client side component library, tuned to work with the asset pipeline."
  s.description = "Client side component library, tuned to work with the asset pipeline."

  s.files = Dir["{app,config,lib,vendor}/**/*"] + ["MIT-LICENSE", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "railties", ">= 3.2.5"
  s.add_dependency "sass-rails"
  s.add_dependency "bourbon"
  s.add_dependency "normalize-rails"
  s.add_dependency "coffee-rails"
  s.add_development_dependency 'teabag', '>= 0.4.6'

  # Used by the dummy application
  s.add_development_dependency 'docomo'
  s.add_development_dependency 'rails', '>= 3.2.5'
end
