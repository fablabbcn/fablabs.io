class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by email: params[:email]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to params[:goto], flash: { success: "Signed in!" }, only_path: true
    else
      flash[:error] = "Invalid email or password"
      render "new"
    end
  end

  # def destroy
  #   session[:user_id] = nil
  #   redirect_to root_url, flash: { success: "Signed out!" }
  # end

end
