class RecoveriesController < ApplicationController

  layout 'application'

  def check_inbox; end

  def new
    @recovery = Recovery.new
    @recovery.build_user
  end

  def create
    @recovery = Recovery.new recovery_params
    @recovery.ip = request.remote_ip
    if @recovery.save
      UserMailer.account_recovery_instructions(@recovery.user.id).deliver_now
      redirect_to check_inbox_recoveries_url
    else
      render :new
    end
  end

  def show
    @recovery = Recovery.find_by(key: params[:id]) || raise(ActiveRecord::RecordNotFound)
  end

  def update
    @recovery = Recovery.where(key: params[:id]).first
    user_params = recovery_params[:user_attributes].slice(:password, :password_confirmation)
    if @recovery.user and user_params[:password].present?
      if @recovery.user.update_attributes user_params
        # cookies.permanent[:user_id] = { data: @recovery.user.id, domain: '.fablabs.dev' }
        session[:user_id] = @recovery.user.id
        redirect_to root_path, flash: { success: 'Password reset' }
      else
        render :show
      end
    else
      flash.now[:error] = "Password can't be blank"
      render :show
    end
  end

private

  def recovery_params
    params.require(:recovery).permit(:email_or_username, user_attributes: [:password, :password_confirmation])
  end

end
