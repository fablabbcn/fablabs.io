class RecoveriesController < ApplicationController

  layout 'sessions'

  def new
    @recovery = Recovery.new
    @recovery.build_user
  end

  def create
    @recovery = Recovery.new recovery_params
    @recovery.ip = request.remote_ip
    if @recovery.save
      render :check_inbox
    else
      render :new
    end
  end

  def show
    @recovery = Recovery.find_by_key(params[:id]) || raise(ActiveRecord::RecordNotFound)
  end

  def update
    @recovery = Recovery.where(key: params[:id]).first
    user_params = recovery_params[:user_attributes].slice(:password, :password_confirmation)
    if @recovery.user and user_params[:password].present?
      if @recovery.user.update_attributes user_params
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
    params.require(:recovery).permit!
  end

end
