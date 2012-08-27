
require 'fileutils'
class FixturesGenerator

  def initialize
    remove_fixtures
    copy_fixtures
  end

  def remove_fixtures
    fixtures = Dir["./spec/javascripts/fixtures/**/*.haml"]
    fixtures.each do |fixture|
      FileUtils.remove_file(fixture)
    end
  end

  def copy_fixtures
    fixtures = Dir["./app/assets/**/*.haml"]
    fixtures.each do |fixture|
      file_name = File.basename(fixture)
      FileUtils.copy_file(fixture, "spec/javascripts/fixtures/#{file_name}") unless file_name == 'snippet.html.haml'
    end
  end

end

generator = FixturesGenerator.new

