class DiscourseController < ApplicationController

  layout 'application'

  before_action :require_login

  def sso
    secret = ENV['DISCOURSE_SSO_SECRET']
    sso = SingleSignOn.parse(request.query_string, secret)
    sso.email = current_user.email
    sso.name = current_user.full_name
    sso.username = current_user.username
    sso.external_id = current_user.id
    sso.sso_secret = secret

    redirect_to sso.to_url("#{ENV['DISCOURSE_ENDPOINT']}session/sso_login")
  rescue => e
    Rails.logger.error(e.message)
    Rails.logger.error(e.backtrace)
    flash[:error] = 'SSO error'
    redirect_to root_path
  end

  def embed
  end
end
