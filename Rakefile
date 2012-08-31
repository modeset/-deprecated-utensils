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

desc "Write the fixture into the markdown file"
task :readmes do
  # manifest = Dir["./sherpa/**/*.md"]
  manifest = Dir["./sherpa/test.md"]
  manifest.each do |file|
    readme = File.expand_path(file)
    path = File.dirname(readme)
    blocks = find_blocks(readme, path)
    replace_blocks(blocks, readme)
  end
end




def find_blocks(readme, path)
  markdown = ""
  fixture_path = nil
  fixture_file = nil
  fixture_contents = nil
  start_tag = nil
  blocks = []

  File.new(readme, "r").each do |line|
    if !!(line =~ /^<!-*~\s[^(end)]/)
      start_tag = line
      fixture_path = line.gsub(/<!-*~/, "").gsub(/-->/, "").strip
      fixture_file = File.join(path, fixture_path)
      fixture_contents = File.read(fixture_file)
    end
    if !!(line =~ /^<!-*\send\s-*>/)
      blocks.push(start_tag: start_tag, contents: fixture_contents)
    end
  end
  blocks
end

def replace_blocks(blocks, readme)
  readme_file = File.readlines(readme)
  blocks.each do |block|
    puts block
    # readme_file.gsub(/#{block[:start_tag]}(.*)<!-- end -->/im, block[:contents])
  end
  # puts readme_file
end


# - Find all the markdown files
# - See if there are any identifiers within each file
# - if there are, write the contents in based on the filename given
#   - based on the identifier, read the file in and write it into the contents range, replacing what is there
#   - save the file
# - else just skip it and move on to the next
#
# - Needs to handle multiple fixtures

