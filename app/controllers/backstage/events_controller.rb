class Backstage::EventsController < Backstage::BackstageController

  def index
    @e = Event.ransack(params[:q])
    @events = @e.result.page(params[:page])
  end
end
