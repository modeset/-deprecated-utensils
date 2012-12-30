source "http://rubygems.org"

gemspec

# Used by the dummy application
gem 'docomo', git: 'https://github.com/modeset/docomo.git'
gem 'rails', '>= 3.2.5'
gem 'teabag', '>= 0.4.6'

group :test do
  gem "phantomjs-linux" if  RUBY_PLATFORM =~ /linux/
end
