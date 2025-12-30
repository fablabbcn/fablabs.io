class Api::V0::LabsController < Api::V0::ApiController
  # protect_from_forgery with: :null_session
  # skip_forgery_protection

  def index
    @labs = Lab.with_approved_state.includes(:links)
    render json: @labs, each_serializer: LabSerializer
  end

  def show
    @lab = Lab.with_approved_state
              .includes(:links, employees: [:user])
              .find(params[:id])

    render json: @lab.to_json(
      include: {
        links: { only: [:url] },
        employees: {
          include: {
            user: {
              methods: [:avatar_url],
              only: [:user_id, :username, :first_name, :last_name, :avatar_url]
            }
          },
          only: [:user_id, :job_title]
        }
      },
      methods: [:avatar_url],
      except: [:phone]
    )
  end

  def map
    labs = Lab.select(:latitude, :longitude, :name, :id, :slug, :kind, :activity_status)
              .with_approved_state
              .includes(:links)

    render json: labs, each_serializer: MapSerializer
  end

  def search
    @labs = Lab.where("slug LIKE ? OR name LIKE ?", "%#{params[:q]}%", "%#{params[:q]&.capitalize}%")
    render json: @labs, each_serializer: LabSerializer
  end
end
