class Api::V1::UsersController < Api::V1::ApiController

  doorkeeper_for :all

  def me
    render json: current_user, serializer: UserJsonapiSerializer, root: "data"
  end

  def update
    body_parameters = request_body
    @user = current_user
    authorize_action_for @user
    email_changed = (@user.email != body_parameters[:email])
    if @user.update_attributes body_parameters
      if email_changed
        UserMailer.delay.verification(@user.id)
        @user.unverify!
      end
      render json: current_user, serializer: UserJsonapiSerializer, root: "data", status: :ok
    else
      # Would be nice to have a proper error class.
      render json: { error: 406 }, status: :not_acceptable
    end
  end

  private
    def request_body
      raw_params =  JSON.parse(request.body.to_json).map {|b| JSON.parse(b) }
      body_params = raw_params.map { |r| ActionController::Parameters.new(Hash[ r.map{ |k, v| [k.to_sym, v] } ]) }.first
      logger.info body_params
      user_params(body_params)
    end

    def user_params(parameters)
      parameters.require(:data).permit({
        attributes: [
          :username,
          :first_name,
          :last_name,
          :email,
          :avatar_src,
          :fab10_coupon_code
        ]
      })
    end

    def user_attributes
      user_params[:attributes] || {}
    end

end
