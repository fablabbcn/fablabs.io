class StaticController < ApplicationController

  def home
    return redirect_to labs_path if current_user
    @nearby_labs = Lab.with_approved_state.where(country_code: current_country.alpha2.downcase).order("RANDOM()").limit(3)
    @country_labs = @nearby_labs.exists?
  end

  def about
  end

  def choose_locale
    render :choose_locale, layout: !request.xhr?
    # if request.xhr?

    # else
    #   redirect_to request.referer, params: { locale: I18n.locale }
    # end
  end
end
