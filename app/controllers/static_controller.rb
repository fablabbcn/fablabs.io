class StaticController < ApplicationController

  def home
    return redirect_to labs_path if current_user
  end

  def about
  end

  def developers
  end

  def choose_locale
    render :choose_locale, layout: !request.xhr?
    # if request.xhr?

    # else
    #   redirect_to request.referer, params: { locale: I18n.locale }
    # end
  end
end
