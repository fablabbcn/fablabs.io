class UsersController < ApplicationController

  before_filter :require_login, except: [:new, :create, :verify_email, :show]

  def new
    @user = User.new
  end

  def create
    return render text: "Please go back and ensure that the 'ignore' field is EMPTY." if params[:name].present?

    @user = User.new user_params
    if @user.save
      UserMailer.delay.welcome(@user.id)
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
      if @user.email_changed?
        @user.unverify!
        UserMailer.verification(@user).deliver
      end
      redirect_to root_url, flash: { success: 'Settings updated' }
    else
      render 'edit'
    end
  end

  def resend_verification_email
    @user = current_user
    UserMailer.verification(@user).deliver
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
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

private

  def user_params
    params.require(:user).permit(
      :username,
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :country_code,
      :avatar_src,
      :use_metric
    )
  end

end
