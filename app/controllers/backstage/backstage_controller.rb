class Backstage::BackstageController < ApplicationController
  before_filter :require_admin

private

  def require_admin
    redirect_to root_url unless current_or_null_user.admin?
  end

end
