class UsersController < ApplicationController

  before_filter :require_login, except: [:new, :create, :verify_email, :show]

  def new
    @user = User.new
  end

  def create
    return render text: "Please go back and ensure that the 'ignore' field is EMPTY." if params[:name].present?

    @user = User.new user_params
    if @user.save
      UserMailer.welcome(@user.id).deliver_now
      # cookies.permanent[:user_id] = { value: @user.id, domain: '.fablabs.dev' }
      session[:user_id] = @user.id
      track_activity @user

      if params[:goto]
        redirect_to params[:goto], flash: { success: "Signed in!" }
      else
        redirect_to root_path, flash: { success: "Thanks for signing up. Please check your email to complete your registration." }
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
      if Figaro.env.mailchimp_enabled == true
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
        if Figaro.env.mailchimp_enabled
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
  end

private

  def user_params
    params.require(:user).permit(
      :agree_policy_terms,
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

end
