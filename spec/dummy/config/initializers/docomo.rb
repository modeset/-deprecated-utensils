Docomo.setup do |config|

  # pygments are used when using the utensils:document rake task
  config.root = Utensils::Engine.root
  config.title = "Utensils Documentation"
  config.manifest_matcher = ["app/assets/utensils/**/*.md"]
  config.output_path = "docs"

end
