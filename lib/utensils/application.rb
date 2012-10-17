 $LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')

require 'rubygems'
require 'bundler/setup'
require 'action_controller/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups(:assets => %w(development test)))


module Utensils
  class Application < Rails::Application
    config.session_store :cookie_store, :key => '_utensils_app_session'
    config.secret_token = '5df96576e3993124e11fa574f45b0704401b333941e356a414eff39cade37040e81988de770e8e580a63903f3a61c96c019c9ca0283a4c19d49e0967ec9ce6cc'

    config.consider_all_requests_local       = true
    config.encoding                          = 'utf-8'
    config.assets.enabled                    = true
    config.assets.version                    = '1.0'
    config.assets.paths                      << 'app/assets'
    config.assets.paths                      << 'app/assets/app'
    config.assets.compile                    = true
    config.serve_static_assets               = true
    config.assets.prefix                     = 'assets'
    config.assets.digest                     = false
    config.assets.compress                   = false
    config.active_support.deprecation        = :log

    # Configure assets for production
    unless Rails.env.production?
      config.assets.debug     = true
      config.action_controller.perform_caching = false
      config.cache_classes = false
    else
    # Tune down the output of the css
      config.action_controller.perform_caching = true
      config.cache_classes = true
    end

  end
end


Utensils::Application.initialize!

Utensils::Application.routes.draw do
  mount Jasminerice::Engine => '/jasmine'
  match '*page' => 'pages#show'
  root :to => 'pages#index'
end

class PagesController < ActionController::Base
  def index
  end
  def show
    render :action => params['page']
  end
end

