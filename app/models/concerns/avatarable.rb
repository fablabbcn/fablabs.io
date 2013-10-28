module Avatarable
  extend ActiveSupport::Concern

  def avatar
    avatar_src.present? ? avatar_src : Rails.application.config.url + ActionController::Base.helpers.asset_path("assets/#{default_avatar}")
  end
end