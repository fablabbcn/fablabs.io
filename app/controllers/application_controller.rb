class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_login
    if current_user.nil?
      redirect_to signin_url(goto: request.path), flash: { error: "You must first sign in to access this page" }
    end
  end

  before_action :set_locale

private

  def set_locale
    if current_user
      if params[:locale].present? and params[:locale] != current_user.locale
        current_user.update_attribute(:locale, params[:locale])
      end
      I18n.locale = current_user.locale
    else
      I18n.locale = params[:locale] if params[:locale].present?
    end
    # current_user.locale
    # request.subdomain
    # request.env["HTTP_ACCEPT_LANGUAGE"]
    # request.remote_ip
  end

  helper_method :current_country
  def current_country
    Country[(Rails.env.test? ? 'GB' : ENV["HTTP_CF_IPCOUNTRY"] || ENV["COUNTRY_CODE"])]
  end

  def default_url_options(options = {})
    {locale: I18n.locale}
  end

  helper_method :current_or_null_user
  def current_or_null_user
    current_user || User.new
    # if current_user == nil
    #   User.new
    # else
    #   current_user
    # end
  end

  helper_method :current_user
  def current_user
    begin
      @current_user ||= User.find(cookies[:user_id]) if cookies[:user_id]
    rescue ActiveRecord::RecordNotFound
      # Log out user if their id don't exist
      cookies.delete(:user_id)
    end
  end

end
