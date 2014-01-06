class Api::V0::CouponsController < Api::V0::ApiController

  def show
    @coupon = Coupon.where(code: params[:id]).first
    render json: @coupon
  end

  def redeem
    @coupon = Coupon.where(code: params[:id]).first
    @coupon.redeemed_at = Time.now
    @coupon.save
    render json: @coupon
  end

end
