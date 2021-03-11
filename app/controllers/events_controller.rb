class EventsController < ApplicationController

  def index
    @events = Event.upcoming.includes(:lab)
    #authorize_action_for @events
    @events = @events.order('starts_at ASC').page(params['page']).per(params['per'])
  end

  def edit
    @lab = Lab.friendly.find(params[:lab_id])
    @event = Event.find(params[:id])
    authorize_action_for @event
  end

  def show
    @event = Event.find(params[:id])
    #authorize_action_for @event
  end

  def index_old
    @lab = Lab.friendly.find(params[:lab_id])
    @events = @lab.events
    #authorize_action_for @events
    @events = @events.order('starts_at ASC').page(params['page']).per(params['per'])
  end

  def new
    @lab = Lab.friendly.find(params[:lab_id])
    @event = Event.new
    authorize_action_for @event
  end

  def update
    @lab = Lab.friendly.find(params[:lab_id])
    @event = Event.find(params[:id])
    authorize_action_for @event
    if @event.update_attributes event_params
      # track_activity @event, current_user
      redirect_to [@event.lab,@event], notice: "Event Updated"
    else
      render :new
    end
  end

  def create
    @lab = Lab.friendly.find(params[:lab_id])
    @event = @lab.events.build(event_params)
    @event.creator = current_user
    authorize_action_for @event
    if @event.save
      track_activity @event, current_user
      redirect_to [@event.lab,@event], notice: "Event Created"
    else
      render :new
    end
  end

private

  def event_params
    params.require(:event).permit!
    # (
    #   :name,
    #   :description,
    #   :starts_at,
    #   :ends_at,
    #   :lab_id
    # )
  end

end
