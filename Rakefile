#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'fileutils'
require File.expand_path('../lib/roos/application', __FILE__)

Roos::Application.load_tasks

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

