class PagesController < ApplicationController

  def show
    @page = Page.friendly.find(params[:id])
    unless @page.published?
      if !current_user || !current_user.has_role?(:superadmin)
        raise ActiveRecord::RecordNotFound
      end
    end
  end
end
