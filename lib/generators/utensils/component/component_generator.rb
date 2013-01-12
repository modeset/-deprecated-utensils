module Utensils
  module Generators
    class ComponentGenerator < Rails::Generators::NamedBase
      desc 'Generate a stub for a component.'
      source_root File.expand_path('../templates', __FILE__)

      def create_component_dir
        empty_directory("app/assets/components/#{file_name}")
      end

      def create_coffee_index
        create_file "app/assets/components/#{file_name}/index.js", "//= require ./#{file_name}"
      end

      def create_coffee
        template "behavior.coffee", "app/assets/components/#{file_name}/#{file_name}.coffee"
      end

      def create_sass_index
        create_file "app/assets/components/#{file_name}/index.sass", "@import #{file_name}"
      end

      def create_sass
        create_file "app/assets/components/#{file_name}/_#{file_name}.sass", ".#{file_name.dasherize}"
      end
    end
  end
end

