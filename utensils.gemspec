$:.push File.expand_path("../lib", __FILE__)

require "utensils/version"

Gem::Specification.new do |s|
  s.name        = "utensils"
  s.version     = Utensils::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Utensils."
  s.description = "TODO: Description of Utensils."

  s.files = Dir["{app,config,lib,vendor}/**/*"] + ["LICENSE", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "railties", ">= 3.2.5"
  s.add_dependency "sass-rails"
  s.add_dependency "coffee-rails"
  # s.add_dependency "jquery-rails"
end
