class ActivitiesController < ApplicationController
  def index
    @activities = Activity.includes(:actor, :creator, :trackable).limit(10)
  end
end
