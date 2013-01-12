class Utensils::UtensilGenerator < Rails::Generators::NamedBase
  desc 'Generate a stub for a utensil.'
  source_root File.expand_path('../templates', __FILE__)

  def create_utensil_dir
    empty_directory("app/assets/utensils/#{file_name}")
  end

  def create_index
    create_file "app/assets/utensils/#{file_name}/index.js", "//= require ./#{file_name}"
  end

  def create_coffee
    create_file "app/assets/utensils/#{file_name}/#{file_name}.coffee", "class #{file_name.camelize}"
  end

  def create_sass
    create_file "app/assets/utensils/#{file_name}/index.sass", "@import #{file_name}"
    create_file "app/assets/utensils/#{file_name}/_#{file_name}.sass", ".#{file_name.dasherize}"
  end

  def create_spec_dir
    empty_directory("app/assets/utensils/#{file_name}/spec")
  end

  def create_spec
    create_file "app/assets/utensils/#{file_name}/spec/#{file_name}_spec.coffee", "#= require utensils/#{file_name}"
  end

  def create_markup_dir
    empty_directory("app/assets/utensils/#{file_name}/markup")
  end

  def create_haml
    create_file "app/assets/utensils/#{file_name}/markup/#{file_name}.html.haml", ""
  end
end

