class UsersController < ApplicationController

  invisible_captcha only: [:create], honeypot: :maker_name, on_spam: :spam_callback
  before_action :require_login, except: [:new, :create, :verify_email, :show, :index]

  def spam_callback
    flash[:success] = 'We think you are not human! Apologies for the inconvenience.'
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def index
    @users = User.order(:id).page(params[:page]).per(params[:per])
  end

  def create
    logger.info 'Creating user through Users controller'

    @user = User.new user_params
    @user.current_sign_in_ip = request.remote_ip
    if verify_recaptcha(model: @user) && @user.save
      UserMailer.welcome(@user.id).deliver_now
      # cookies.permanent[:user_id] = { value: @user.id, domain: '.fablabs.dev' }
      session[:user_id] = @user.id
      track_activity @user

      if params[:goto]
        redirect_to params[:goto], flash: { success: t("shared.signed_in") }
      else
        redirect_to root_path, flash: { success: t("shared.success_sign_up") }
      end
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
    authorize_action_for @user
  end

  def update
    @user = current_user
    authorize_action_for @user
    email_changed = (@user.email != user_params[:email])
    if email_changed
      if ENV['MAILCHIMP_ENABLED'] == true
        @client = MailchimpService::Client.instance
        @client.unsubscribe(@user)
      end
    end
    if @user.update_attributes user_params
      if email_changed
          UserMailer.verification(@user.id).deliver_now
        @user.unverify!
      end
      redirect_to root_url, flash: { success: 'Settings updated' }
    else
      render 'edit'
    end
  end


  def change_password
    @user = current_user
    # authorize_action_for @user
  end

  def update_password
    @user = current_user
    if change_password_params[:password] == change_password_params[:password_confirmation] 
      if @user.update_attributes change_password_params
        redirect_to root_url, flash: {success: 'Password updated successfully'} 
      else
          render 'change_password'
      end
    else
      @user.errors.add(:password_confirmation, "Passwords do not match")
      render 'change_password'
    end
  end

  def resend_verification_email
    @user = current_user
    UserMailer.verification(@user.id).deliver_now
    render 'sent_verification_email'
  end

  def verify_email
    begin
      @user = User.with_unverified_state.find_by!(email_validation_hash: params[:id])
      if @user.verify!
        # cookies.permanent[:user_id] = { value: @user.id, domain: '.fablabs.dev' }
        if ENV['MAILCHIMP_ENABLED']
          @client = MailchimpService::Client.instance
          @client.subscribe(@user)
        end
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Thanks for verifying your email"
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end
  end

  def show
    @user = User.friendly.find(params[:id])

    if @user.unverified?
      if current_user == @user
        # Let the user view their own profile but show a banner
        flash.now[:alert] = "Please verify your email to make your profile public."
      else
        # Why should you get a profile with out work
        raise ActiveRecord::RecordNotFound
      end
    end
  end

private

  def user_params
    params.require(:user).permit(
      :agree_policy_terms,
      :dob,
      :username,
      :first_name,
      :last_name,
      :email,
      :email_fallback,
      :phone,
      :password,
      :password_confirmation,
      :country_code,
      :avatar,
      :use_metric,
      :bio,
      :url,
      links_attributes: [ :id, :link_id, :url, '_destroy' ]
    )
  end

  def change_password_params
    params.require(:user).permit(
      :password,
      :password_confirmation
    )
  end

end
