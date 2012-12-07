$:.push File.expand_path("../lib", __FILE__)

require "utensils/version"

Gem::Specification.new do |s|
  s.name        = "utensils"
  s.version     = Utensils::VERSION
  s.authors     = ["Matt Kitt"]
  s.email       = ["info@modeset.com"]
  s.homepage    = "https://github.com/modeset/utensils"
  s.summary     = "A UI component library"
  s.description = "A UI component library"

  s.files = Dir["{app,config,lib,vendor}/**/*"] + ["MIT-LICENSE", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "railties", ">= 3.2.5"
  s.add_dependency "sass-rails"
  s.add_dependency "coffee-rails"
  # s.add_dependency "jquery-rails"
end
