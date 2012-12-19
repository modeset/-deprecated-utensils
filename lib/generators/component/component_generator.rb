class ComponentGenerator < Rails::Generators::NamedBase
  desc 'Generate a stub for a component.'
  source_root File.expand_path('../templates', __FILE__)

  def create_component_dir
    empty_directory("app/assets/components/#{file_name}")
  end

  def create_index
    create_file "app/assets/components/#{file_name}/index.js", "//= require ./#{file_name}"
  end

  def create_coffee
    create_file "app/assets/components/#{file_name}/#{file_name}.coffee", "class #{file_name.titleize}"
  end

  def create_sass
    create_file "app/assets/components/#{file_name}/_#{file_name}.sass", ".#{file_name}"
  end
end
