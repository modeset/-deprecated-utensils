#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../lib/roos/application', __FILE__)

Roos::Application.load_tasks

desc 'Probe the contents from running sherpa without any saved output'
task :docs do
  system "ruby ./bin/sherpa.rb"
end
