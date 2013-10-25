module Avatarable
  extend ActiveSupport::Concern

  def avatar
    avatar_src.present? ? avatar_src : ENV['URL'] + ActionController::Base.helpers.asset_path("assets/#{default_avatar}")
  end
end