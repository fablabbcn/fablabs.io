class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # TODO enable crsf 
  # protect_from_forgery with: :exception

  before_action :sentry_user_context, if: :current_user

  def require_login
    if current_user.nil?
      redirect_to signin_url(goto: request.path), flash: { error: "You must first sign in to access this page" }
    end
  end

  def require_superadmin
    if !current_user || !current_user.has_role?(:superadmin)
      flash[:error] = 'You must be superadmin to access this page'
      redirect_to root_path
    end
  end

  before_action :set_locale

  around_action :user_time_zone, if: :current_user

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

  def sentry_user_context
    Sentry.set_user(email: current_user.email, id: current_user.id)
  end
end
