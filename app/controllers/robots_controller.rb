class RobotsController < ApplicationController

  def robots
    subdomain = %w(www api).include?(request.subdomain) ? request.subdomain : 'www'
    render "robots.#{request.subdomain}.txt"
  end

end
