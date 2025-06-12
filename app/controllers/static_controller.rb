class StaticController < ApplicationController

  def home
    # @nearby_labs = Lab.with_approved_state.where(country_code: current_country.alpha2.downcase).order("RANDOM()").limit(3)
    # @country_labs = @nearby_labs.exists?
    render layout: 'welcome'
  end

  def alt
    @recent_labs = recent_labs()
    @news = [
      { :image_url => "news/fab15.jpg", :title => "FAB Bhtuan Highlights", :url => "https://fab23.fabevent.org/media/fab23-bhutan-a-success-by-any-measure", :description => "FAB Bhutan was a GREAT success. Check out the latest here"},
      { :image_url => "news/fabacademy.jpg", :title => "Fab Academy 2024: Registrations open", :url => "https://fabacademy.org", :description => "We're happy to announce that Applications to become a Host Node for Fab Academy 2024 are Now Open." },
      { :image_url => "news/fabricademy-2019.png", :title => "Fabricademy 2024 Started!", :url => "https://textile-academy.org" , :description => "The new Fabricademy courses focus on sustainable textiles, fashion and wearables."},
    ]    
    render layout: 'welcome'

  end


  def about; end
  def cookie_policy; end
  def privacy_policy; end
  def tos; end

  def country_guess
    render plain: (current_country ? "I think you are in #{current_country}" : "I don't know where you are")
  end

  def api
    render :api, layout: false
  end

  def choose_locale
    render :choose_locale, layout: !request.xhr?
    # if request.xhr?

    # else
    #   redirect_to request.referer, params: { locale: I18n.locale }
    # end
  end

  def styleguide
  end

  def version
    render json: {
      env: Rails.env,
      version: VERSION,
      ruby: RUBY_VERSION,
      rails: Rails::VERSION::STRING,
      branch: GIT_BRANCH,
      revision: GIT_REVISION,
      message: GIT_MSG,
    }
  end

  def metrics
    the_json = Rails.cache.fetch('metrics', expires_in: 1.minute) do
     {
        labs: Lab.count,
        approved_labs: Lab.with_approved_state.count,
        organizations: Organization.count,
        machines: Machine.count,
        jobs: Job.count,
        events: Event.count,
        users: User.count,
        projects: Project.count,
        employees: Employee.count
      }
    end
    render json: the_json
  end

  private

  helper_method :recent_labs
  def recent_labs
    Lab.with_approved_state.order("created_at DESC").limit(9)
  end

end
