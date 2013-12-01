class Backstage::BackstageController < ApplicationController
  before_filter :require_admin

private

  def require_admin
    if current_user
      unless current_user.has_role? :admin
        return redirect_to root_url, notice: "Not authorized"
      end
    else
      return redirect_to signin_url
    end
  end

end
