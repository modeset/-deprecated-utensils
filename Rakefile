#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'fileutils'
require File.expand_path('../lib/utensils/application', __FILE__)

Utensils::Application.load_tasks

task :default => :sherpa

desc "Generate the documentation"
task :sherpa do
  system "ruby ./sherpa/sherpa.rb"
end

desc "Copy haml files over to the fixtures directory"
task :fixtures do
  # Kill the old ones
  old_fixtures = Dir["./spec/javascripts/fixtures/**/*.haml"]
  old_fixtures.each do |old_fixture|
    FileUtils.remove_file(old_fixture)
  end
  # Copy the new ones over to fixtures
  fixtures = Dir["./app/assets/**/*.haml"]
  fixtures.each do |fixture|
    file_name = File.basename(fixture)
    FileUtils.copy_file(fixture, "spec/javascripts/fixtures/#{file_name}") unless file_name == 'snippet.html.haml'
  end
end

desc "Write the fixtures into the markdown file"
task :readmes do
  manifest = Dir["./app/assets/**/*.md"]
  manifest.each do |file|
    readme = File.expand_path(file)
    path = File.dirname(readme)
    replace_blocks(readme, path)
  end
end

desc "Update the readmes and sherpa in one shot"
task :readmes_sherpa => ['readmes', 'sherpa']

desc "Update all of the docs in one shot"
task :document => ['readmes','fixtures', 'sherpa']


# Utility method for replacing blocks of text with fixtures
def replace_blocks(readme, path)
  markdown = ""
  fixture_path = nil
  fixture_file = nil
  fixture_contents = nil
  start_tag = nil
  blocks = []

  contents = File.read(readme)
  contents.gsub! /^<!-*~ (.\S*) -*>(.*?)<!-* end -*>$/m do |match|
    fixture_path = $1
    fixture_file = File.join(path, fixture_path)
    fixture_contents = File.read(fixture_file).strip
    sub = <<-EOF
<!--~ #{fixture_path} -->
```#{File.extname(fixture_file).gsub('.','')}
#{fixture_contents}
```
<!-- end -->
    EOF
    sub.strip
  end
  File.write(readme, contents)
end

