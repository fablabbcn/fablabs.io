class SessionsController < ApplicationController

  layout 'application'

  def new
    return redirect_to root_url, notice: t("shared.already_signed_in") if current_user
  end

  def create
    user = User.where('email = :eu or email_fallback = :eu or username = :eu', eu: params[:email_or_username]).first

    if required_fields_present? && user && user.authenticate(params[:password])
      # cookies.permanent[:user_id] = { value: user.id, domain: '.fablabs.dev' }
      session[:user_id] = user.id
      # redirect_to URI.parse(params[:goto]).path, flash: { success: "Signed in!" }, only_path: true
      redirect_to params[:goto], flash: { success: t("shared.signed_in") }
      # Update user IP
      user.update!(last_sign_in_ip: user.current_sign_in_ip)
      user.update!(current_sign_in_ip: request.remote_ip)
    else
      flash.now[:error] = t("shared.invalid_email_or_password")
      render "new"
    end
  end

  def destroy
    if current_user && ENV['DISCOURSE_ENABLED'] == 'true'
      DiscourseUserLogoutWorker.perform_async(current_user.id)
    end

    session.delete(:user_id)
    redirect_to root_url, flash: { success: t("shared.signed_out") }
  end

  private

  def required_fields_present?
    params[:email_or_username].present? && params[:password].present?
  end
end
