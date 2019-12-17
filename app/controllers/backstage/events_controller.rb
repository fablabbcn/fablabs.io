class Backstage::EventsController < Backstage::BackstageController

  def index
    @e = Event.search(params[:q])
    @events = @e.result.page(params[:page])
  end
end
