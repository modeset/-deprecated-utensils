#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../lib/roos/application', __FILE__)

Roos::Application.load_tasks

desc "Generate the documentation"
task :sherpa do
  system "ruby ./lib/generators/sherpa/sherpa.rb"
end

desc "Copy haml files over to the fixtures directory"
task :fixtures do
  system "ruby ./lib/generators/roos/fixtures_generator.rb"
end

