class SessionsController < ApplicationController

  layout 'sessions'

  def new
  end

  def create
    user = User.where('email = :eu or username = :eu', eu: params[:email_or_username]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to URI.parse(params[:goto]).path, flash: { success: "Signed in!" }, only_path: true
    else
      flash.now[:error] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, flash: { success: "Signed out!" }
  end

end
