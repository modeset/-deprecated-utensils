#!/usr/bin/env rake
require 'fileutils'

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

# Dummy App
# -----------------------------------------------------------------------------
APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'
Bundler::GemHelper.install_tasks

# Teabag
# -----------------------------------------------------------------------------
desc "Run the javascript specs"
task :teaspoon => "app:teaspoon"

# Docomo
# -----------------------------------------------------------------------------
namespace :utensils do
  desc "Generate documentation for asset libraries"
  task :document => :environment do
    Docomo.configuration.use_pygments = true
    Docomo::Processor.new.render_to_file
  end
end

task :default => [:teaspoon]
