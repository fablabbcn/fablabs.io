require 'httparty'

class StaticController < ApplicationController

  def home
    # @nearby_labs = Lab.with_approved_state.where(country_code: current_country.alpha2.downcase).order("RANDOM()").limit(3)
    # @country_labs = @nearby_labs.exists?
    render layout: 'welcome'
  end

  def alt
    @projects = []
    # TODO: Make the call to wikifactory async. Now it adds seconds delay.
    begin
      @projects = recent_projects()
    rescue Exception => error
      puts error.inspect
    end
    @recent_labs = recent_labs()
    @news = [
      { :image_url => "news/fab15.jpg", :title => "FAB 15 Highlights", :url => "https://www.flickr.com/photos/fabfoundation/collections/72157710335192311/", :description => "FAB15 Egypt was a GREAT success. You can view all of the official photos from the FABulous week here."},
      { :image_url => "news/fabacademy.jpg", :title => "Fab Academy 2020: Registrations open", :url => "https://fabacademy.org", :description => "We're happy to announce that Applications to become a Host Node for Fab Academy 2020 are Now Open." },
      { :image_url => "news/fabricademy-2019.png", :title => "Fabricademy 2019-2020 Started!", :url => "https://textile-academy.org" , :description => "The new Fabricademy courses focus on sustainable textiles, fashion and wearables."},
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
      revision: GIT_REVISION
    }
  end

  def metrics
    render json: {
      labs: Lab.count,
      organizations: Organization.count,
      machines: Machine.count,
      events: Event.count,
      users: User.count,
      employees: Employee.count
    }
  end

  private

  helper_method :recent_projects
  def recent_projects
    begin
      response = HTTParty.get('https://wikifactory.com/api/fablabsio/projects')
      json = JSON.parse(response.body)

      projects = []
      if json
        projects = json.select { |p|
          p["image_url"] != nil
        }
        if projects.length > 6
          projects = projects.slice(0,6)
        end
      end
      return projects
    rescue
      return []
    end
  end

  helper_method :recent_labs
  def recent_labs
    Lab.with_approved_state.order("created_at DESC").limit(9)
  end

end
