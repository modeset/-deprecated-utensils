require 'sass-rails'
require 'bourbon'
require 'normalize-rails'
require 'coffee-rails'

class Utensils::Engine < ::Rails::Engine
  isolate_namespace Utensils

  initializer :assets, :group => :all do |app|
    app.config.sass.load_paths << root.join('app/assets')
    app.config.assets.paths << root.join('app/assets')
  end
end
