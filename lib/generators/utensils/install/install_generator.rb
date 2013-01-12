module Utensils
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc 'Install the base assets for setting up a new project using utensils.'
      source_root File.expand_path('../templates', __FILE__)

      def create_sass_files
        copy_file 'application.sass', 'app/assets/stylesheets/application.sass'
        copy_file 'spec/dummy/app/assets/stylesheets/_config.sass', 'app/assets/stylesheets/_config.sass'
        copy_file 'spec/dummy/app/assets/stylesheets/dinosaur.sass', 'app/assets/stylesheets/dinosaur.sass'
      end

      def create_coffee_files
        copy_file 'application.coffee', 'app/assets/javascripts/application.coffee'
        copy_file 'spec/dummy/app/assets/javascripts/dinosaur.coffee', 'app/assets/javascripts/dinosaur.coffee'
        copy_file 'spec/dummy/app/assets/javascripts/polyfill.coffee', 'app/assets/javascripts/polyfill.coffee'
      end

      def create_haml_files
        copy_file 'application.html.haml', 'app/views/layouts/application.html.haml'
        empty_directory 'app/views/layouts/shared'
        copy_file 'flash_message.html.haml', 'app/views/layouts/shared/_flash_message.html.haml'
        copy_file 'upgrade.html.haml', 'app/views/layouts/shared/_upgrade.html.haml'
      end

      def create_public_assets
        copy_file 'spec/dummy/public/404.html', 'public/404.html'
        copy_file 'spec/dummy/public/422.html', 'public/422.html'
        copy_file 'spec/dummy/public/500.html', 'public/500.html'
        copy_file 'spec/dummy/public/apple-touch-icon-114x114-precomposed.png', 'public/apple-touch-icon-114x114-precomposed.png'
        copy_file 'spec/dummy/public/apple-touch-icon-57x57-precomposed.png', 'public/apple-touch-icon-57x57-precomposed.png'
        copy_file 'spec/dummy/public/apple-touch-icon-72x72-precomposed.png', 'public/apple-touch-icon-72x72-precomposed.png'
        copy_file 'spec/dummy/public/apple-touch-icon-precomposed.png', 'public/apple-touch-icon-precomposed.png'
        copy_file 'spec/dummy/public/apple-touch-icon.png', 'public/apple-touch.png'
        copy_file 'spec/dummy/public/error.html', 'public/error.html'
        copy_file 'spec/dummy/public/favicon.ico', 'public/favicon.ico'
        copy_file 'spec/dummy/public/maintenance.html', 'public/maintenance.html'
      end

    end
  end
end

