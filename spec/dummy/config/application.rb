require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "action_controller/railtie"
require "active_resource/railtie"
require "sprockets/railtie"

Bundler.require
require "utensils"

module Dummy
  class Application < Rails::Application
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
    config.assets.paths << Rails.root.join('../javascripts')

    # Your secret key for verifying the integrity of signed cookies.  If you change this key, all old
    # signed cookies will become invalid!  Make sure the secret is at least 30 characters and all
    # random, no regular words or you'll be exposed to dictionary attacks.
    config.secret_token = '1b7238f4a5b0b481e4cc39f9a788452e5f986697115ee5c07c42681d7985b11b252a9fd0bca086e1c9c8117a49ae452e8a68e55aaee7af7034307c67062a82e2'

    # Use the database for sessions instead of the cookie-based default, which shouldn't be used to
    # store highly confidential information (create the session table with
    # "rails generate session_migration")
    # config.session_store :active_record_store
    config.session_store :cookie_store, key: '_dummy_session'
  end
end
