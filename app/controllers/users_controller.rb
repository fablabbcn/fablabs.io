class UsersController < ApplicationController

  before_filter :require_login, except: [:new, :create, :verify_email]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, flash: { success: "Thanks for signing up. Please check your email to complete your registration." }
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes user_params
      redirect_to root_url, flash: { success: 'Settings updated' }
    else
      render 'edit'
    end
  end

  def resend_verification_email
    @user = current_user
    @user.send_verification_email
    render 'sent_verification_email'
  end

  def verify_email
    begin
      @user = User.with_unverified_state.find_by!(email_validation_hash: params[:id])
      if @user.verify!
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Thanks for verifying your email"
      end
    rescue ActiveRecord::RecordNotFound
      render text: "Fail"
    end
  end

private

  def user_params
    params.require(:user).permit!
  end

end
