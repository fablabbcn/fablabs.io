module Api
  class ProfileController < ApiController
    before_action :doorkeeper_authorize!

    def show
      if current_user.unverified?
        render json: { error: 'Verify your account first' }, status: :unauthorized
      else
        respond_with current_user
      end
      # render json: ApiUserSerializer.new(current_user, {}).serialized_json
    end

  end
end
