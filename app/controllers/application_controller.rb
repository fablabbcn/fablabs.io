class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception with
  # protect_from_forgery with: :exception
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def require_login
    if current_user.nil?
      redirect_to signin_url(goto: request.path), flash: { error: "You must first sign in to access this page" }
    end
  end

  # Access control should be cleaned up and fixed. This is a bit ugly to see.

  before_action :set_locale

  around_filter :user_time_zone, if: :current_user
  before_filter :cors_preflight_check
  after_filter :set_csrf_cookie_for_ng, :cors_set_access_control_headers

  def set_csrf_cookie_for_ng
    cookies['X-CSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Expose-Headers'] = 'ETag'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match'
    headers['Access-Control-Max-Age'] = "1728000"
    headers['X-CSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Credentials'] = 'true'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'
      headers['X-CSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
      render :text => '', :content_type => 'text/plain'
    end
  end

private

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

  def set_locale
    begin
      if params[:locale].present?
        I18n.locale = cookies[:locale] = params[:locale]
      elsif cookies[:locale]
        I18n.locale = cookies[:locale]
      else
        I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
      end
    rescue I18n::InvalidLocale
      I18n.locale = I18n.default_locale
    end
  end

  helper_method :current_country
  def current_country
    Country[(Rails.env.test? ? 'GB' : request.env["HTTP_CF_IPCOUNTRY"] || ENV["COUNTRY_CODE"])]
  end

  # def default_url_options(options = {})
  #   {locale: I18n.locale}
  # end

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
      # @current_user ||= User.find(cookies[:user_id]) if cookies[:user_id]
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      # Log out user if their id don't exist
      # cookies.delete(:user_id)
      session.delete(:user_id)
    end
  end

  def track_activity(trackable, actor = current_user, action = params[:action])
    current_user.created_activities.create action: action, trackable: trackable, actor: actor
  end

end
