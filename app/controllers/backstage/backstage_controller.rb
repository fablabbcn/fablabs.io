class Backstage::BackstageController < ApplicationController
  before_filter :require_admin

private

  def require_admin
    if current_user
      unless superadmin or referee
        return redirect_to root_url, notice: "Not authorized"
      end
    else
      return redirect_to signin_url
    end
  end

  def superadmin
    current_user.has_role? :superadmin
  end

  def referee
    current_user.is_referee? or current_user.is_unique_referee?
  end
end
