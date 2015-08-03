class Api::V0::ProjectsController < Api::V0::ApiController

  def index
    @projects = Project.all.joins(:collaborations).includes(:lab).references(:lab)
    respond_to do |format|
      format.json { respond_with @projects }
      # http://railscasts.com/episodes/362-exporting-csv-and-excel
      # format.csv { send_data @labs.to_csv }
      # format.xls { send_data @labs.to_csv(col_sep: "\t") }
    end
  end

  def show
    respond_with Project.find(params[:id])
  end

  def map
    respond_with Project.joins(:collaborations).includes(:lab).references(:lab).collect { |p| {id: p.id, title: p.title, name: p.lab.name, latitude: p.lab.latitude, longitude: p.lab.longitude, kind: p.lab.kind_name}}
  end

end
