# This file allows you to override various Teabag configuration directives when running from the command line. It is not
# required from within the Rails environment, so overriding directives that have been defined within the initializer
# is not possible.
#
# Set RAILS_ROOT and load the environment.
ENV["RAILS_ROOT"] = File.expand_path("../../spec/dummy", __FILE__)
require File.expand_path("../../spec/dummy/config/environment", __FILE__)

# Provide default configuration.
#
# You can override various configuration directives defined here by using arguments with the teabag command.
#
# teabag --driver=selenium --suppress-log
# rake teabag DRIVER=selenium SUPPRESS_LOG=false
Teabag.setup do |config|
  # Driver
  #config.driver         = "phantomjs" # available: phantomjs, selenium
  #config.phantomjs_bin  = nil

  # Behaviors
  #config.server_timeout = 20 # timeout for starting the server
  #config.fail_fast      = true # abort after the first failing suite

  # Output
  #config.formatters     = "dot" # available: dot, tap_y, swayze_or_oprah
  #config.suppress_log   = false # suppress logs coming from console[log/error/debug]
  #config.color          = true
end
