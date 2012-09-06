# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../lib/utensils/application',  __FILE__)
run Utensils::Application
