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

# Docomo
# -----------------------------------------------------------------------------
namespace :utensils do
  desc "Generate documentation for asset libraries"
  task :document => :environment do
    Docomo.configuration.use_pygments = true
    Docomo::Processor.new.render_to_file
  end
  desc "Copy over the fixture files for testing"
  task :fixtures do
    # Kill the old ones
    old_fixtures = Dir["./spec/javascripts/fixtures/**/*.haml"]
    old_fixtures.each do |old_fixture|
      FileUtils.remove_file(old_fixture)
    end
    # Copy the new ones over to fixtures
    fixtures = Dir["./app/assets/utensils/**/*.haml"]
    fixtures.each do |fixture|
      file_name = File.basename(fixture)
      FileUtils.copy_file(fixture, "spec/javascripts/fixtures/#{file_name}") unless file_name == 'snippet.html.haml'
    end
  end
end
