class Api::V0::CouponsController < Api::V0::ApiController

  def show
    render json: Coupon.where(code: params[:id]).first
  end

end
