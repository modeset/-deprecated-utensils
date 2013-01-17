module Utensils
  module Generators
    class ComponentGenerator < Rails::Generators::NamedBase

      class_option :no_js,  :type => :boolean
      class_option :no_css, :type => :boolean

      desc 'Generate a stub for a component.'
      source_root File.expand_path('../templates', __FILE__)

      def create_component_dir
        empty_directory("app/assets/components/#{file_name}")
      end

      def create_coffee_index
        return if options[:no_js]
        create_file "app/assets/components/#{file_name}/index.js", "//= require ./#{file_name}"
      end

      def create_coffee
        return if options[:no_js]
        template "behavior.coffee", "app/assets/components/#{file_name}/#{file_name}.coffee"
      end

      def create_sass_index
        return if options[:no_css]
        create_file "app/assets/components/#{file_name}/index.sass", "@import #{file_name}"
      end

      def create_sass
        return if options[:no_css]
        create_file "app/assets/components/#{file_name}/_#{file_name}.sass", ".#{file_name.dasherize}"
      end
    end
  end
end

