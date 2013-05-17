module Utensils
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc 'Install the base assets for setting up a new project using utensils.'
      source_root File.expand_path('../../../../../spec/dummy', __FILE__)

      def cleanup_assets
        remove_file "app/assets/stylesheets/application.css"
        remove_file "app/assets/javascripts/application.js"
        remove_dir "public"
      end

      def create_sass_files
        copy_file 'app/assets/stylesheets/_config.sass'
        copy_file 'app/assets/stylesheets/application.sass'
        copy_file 'app/assets/stylesheets/dinosaur.sass'
      end

      def create_coffee_files
        copy_file 'app/assets/javascripts/application.coffee'
        copy_file 'app/assets/javascripts/dinosaur.coffee'
        copy_file 'app/assets/javascripts/polyfill.coffee'
      end

      def create_haml_files
        copy_file 'app/views/layouts/pages.html.haml', 'app/views/layouts/application.html.haml'
        empty_directory 'app/views/layouts/shared'
        copy_file 'app/views/layouts/shared/_flash_message.html.haml'
        copy_file 'app/views/layouts/shared/_upgrade.html.haml'
      end

      def create_public_assets
        empty_directory 'public'
        copy_file 'public/404.html'
        copy_file 'public/422.html'
        copy_file 'public/500.html'
        copy_file 'public/apple-touch-icon-114x114-precomposed.png'
        copy_file 'public/apple-touch-icon-144x144.png'
        copy_file 'public/apple-touch-icon-57x57-precomposed.png'
        copy_file 'public/apple-touch-icon-72x72-precomposed.png'
        copy_file 'public/apple-touch-icon-precomposed.png'
        copy_file 'public/apple-touch-icon.png'
        copy_file 'public/error.html'
        copy_file 'public/favicon.ico'
        copy_file 'public/maintenance.html'
      end

    end
  end
end

