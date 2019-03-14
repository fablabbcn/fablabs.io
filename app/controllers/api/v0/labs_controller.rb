class Api::V0::LabsController < Api::V0::ApiController

  def index
    @labs = Lab.with_approved_state.includes(:links)
    respond_to do |format|
      format.json { respond_with @labs }
      # http://railscasts.com/episodes/362-exporting-csv-and-excel
      # format.csv { send_data @labs.to_csv }
      # format.xls { send_data @labs.to_csv(col_sep: "\t") }
    end
  end

  def show
    @lab = Lab.with_approved_state.includes(:links, :employees => [:user]).find(params[:id])
    render json: @lab.to_json(:include => {
        
        :links => { :only => :url }, 
        :employees => { 
          :include => { 
            :user => {
              :methods => :avatar_url,
              :only => [ :user_id, :username, :first_name, :last_name, :avatar_url]
            },
          },
          :only => [:user, :job_title, :user_id]
      },
      
    }, 
    :methods => :avatar_url,
    :exclude => [:phone]
    )
  end

  def map
    respond_with Lab.select(:latitude,:longitude,:name,:id)
      .with_approved_state.includes(:links),
      each_serializer: MapSerializer
  end

  def search
    @labs = Lab.where("slug LIKE ? or name LIKE ?", "%#{params[:q]}%", "%#{params[:q]&.capitalize}%")
    render json: @labs, each_serializer: LabSerializer
  end

end
