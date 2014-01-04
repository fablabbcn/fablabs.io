class TranslationsController < ApplicationController

  before_filter :require_login
  before_filter { return redirect_to root_path unless current_user.has_role?(:superadmin) }

  def index
    params[:translation_locale] ||= "en"
    @translations = I18n.backend.store
  end

  def create
    I18n.backend.store_translations(params[:locale], {params[:key] => params[:value]}, :escape => false)
    redirect_to translations_url, :notice => "Added translations"
  end

end
