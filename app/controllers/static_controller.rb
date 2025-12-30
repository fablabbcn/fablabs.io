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
      { :image_url => "news/fab15.jpg", :title => "FAB25 Czechia Highlights", :url => "https://fab25.fabevent.org/", :description => "FABx brought together 1000+ participants in the heart of Europe for an unforgettable week of keynotes, talks, hands-on workshops, making, networking, and cultural experiences."},
      { :image_url => "news/fabacademy.jpg", :title => "Fab Academy 2026: Registrations open", :url => "https://fabacademy.org", :description => "We're happy to announce that applications to join as a student or host node for Fab Academy 2026 are now open." },
      { :image_url => "news/fabricademy-2019.png", :title => "Fabricademy 2025 Started!", :url => "https://textile-academy.org" , :description => "The new Fabricademy courses focus on sustainable textiles, fashion and wearables."},
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

  helper_method :recent_projects
  def recent_projects
    begin

      response = Rails.cache.fetch('frontpage-projects', expires_in: 1.hours) do
        HTTParty.get('https://wikifactory.com/api/fablabsio/projects')
      end

      json = JSON.parse(response.body)

      projects = []
      if json
        projects = json.select { |p|
          p["image_url"] != nil
        }
        projects = projects.first(6)
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
