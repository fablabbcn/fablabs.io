class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
    authorize_action_for @event
  end

  def index
    @events = Event.order('starts_at ASC').where('starts_at > ?', Time.now).group_by { |t| t.starts_at.beginning_of_day }
    authorize_action_for Event
  end

  def new
    @event = Event.new
    authorize_action_for @event
  end

  def create
    @event = Event.new(event_params)
    authorize_action_for @event
    if @event.save
      redirect_to event_url(@event), notice: "Event Created"
    else
      render :new
    end
  end

private

  def event_params
    params.require(:event).permit(
      :name,
      :description,
      :starts_at,
      :ends_at,
      :lab_id
    )
  end

end
