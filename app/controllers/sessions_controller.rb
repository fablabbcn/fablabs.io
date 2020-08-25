class SessionsController < ApplicationController

  layout 'application'

  def new
    return redirect_to root_url, notice: "You're already signed in" if current_user
  end

  def create
    user = User.where('email = :eu or email_fallback = :eu or username = :eu', eu: params[:email_or_username]).first

    if required_fields_present? && user && user.authenticate(params[:password])
      # cookies.permanent[:user_id] = { value: user.id, domain: '.fablabs.dev' }
      session[:user_id] = user.id
      # redirect_to URI.parse(params[:goto]).path, flash: { success: "Signed in!" }, only_path: true
      redirect_to params[:goto], flash: { success: "Signed in!" }
    else
      flash.now[:error] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    if current_user && ENV['DISCOURSE_ENABLED'] == 'true'
      DiscourseUserLogoutWorker.perform_async(current_user.id)
    end

    session.delete(:user_id)
    redirect_to root_url, flash: { success: "Signed out!" }
  end

  private

  def required_fields_present?
    params[:email_or_username].present? && params[:password].present?
  end
end
