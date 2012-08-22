# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../lib/roos/application',  __FILE__)
run Roos::Application
