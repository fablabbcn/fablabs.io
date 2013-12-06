# Be sure to restart your server when you modify this file.

# Fablabs::Application.config.session_store :redis_store
Fablabs::Application.config.session_store :cookie_store, key: '_fablabs_session', domain: :all, tld_length: 2
# App.config.session_store ... , :domain => :all, :tld_length => 2
# Rails.application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 20.minutes
