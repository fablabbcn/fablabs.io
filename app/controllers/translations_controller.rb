class TranslationsController < ApplicationController

  before_filter :require_login
  before_filter { return redirect_to root_path unless current_user.has_role?(:superadmin) }

  def index
    params[:translation_locale] ||= "en"
    @translations = TRANSLATION_STORE
  end

  def create
    I18n.backend.store_translations(params[:locale], {params[:key] => params[:value]}, :escape => false)
    redirect_to new_translation_url, :notice => "Added translations"
  end

  def new
  end

end
