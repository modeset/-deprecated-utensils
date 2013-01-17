module Utensils
  module Generators
    class UtensilGenerator < Rails::Generators::NamedBase

      class_option :no_js,     :type => :boolean
      class_option :no_css,    :type => :boolean
      class_option :no_markup, :type => :boolean

      desc 'Generate a stub for a utensil.'
      source_root File.expand_path('../templates', __FILE__)

      def create_utensil_dir
        empty_directory("app/assets/utensils/#{file_name}")
      end

      def create_coffee_index
        return if options[:no_js]
        create_file "app/assets/utensils/#{file_name}/index.js", "//= require ./#{file_name}"
      end

      def create_coffee
        return if options[:no_js]
        template "behavior.coffee", "app/assets/utensils/#{file_name}/#{file_name}.coffee"
      end

      def create_sass_index
        return if options[:no_css]
        create_file "app/assets/utensils/#{file_name}/index.sass", "@import #{file_name}"
      end

      def create_sass
        return if options[:no_css]
        create_file "app/assets/utensils/#{file_name}/_#{file_name}.sass", ".#{file_name.dasherize}"
      end

      def create_spec_dir
        return if options[:no_js]
        empty_directory("app/assets/utensils/#{file_name}/spec")
      end

      def create_spec
        return if options[:no_js]
        template "spec.coffee", "app/assets/utensils/#{file_name}/spec/#{file_name}_spec.coffee"
      end

      def create_markup_dir
        return if options[:no_markup]
        empty_directory("app/assets/utensils/#{file_name}/markup")
      end

      def create_haml
        return if options[:no_markup]
        create_file "app/assets/utensils/#{file_name}/markup/#{file_name}.html.haml", ".#{file_name.dasherize}(data-bindable=\"#{file_name.dasherize}\")"
      end

      def create_readme
        template "readme.md", "app/assets/utensils/#{file_name}/readme.md"
      end

    end
  end
end

