class ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
  end
end
