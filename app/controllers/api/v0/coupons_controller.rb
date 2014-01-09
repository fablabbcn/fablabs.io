class Api::V0::CouponsController < Api::V0::ApiController

  def show
    # @coupon = Coupon.where(code: params[:id]).first
    # render json: @coupon
    @user = User.where(fab10_coupon_code: params[:id]).first
    render json: @user
  end

  def redeem
    # @coupon = Coupon.where(code: params[:id]).first
    # @coupon.redeemed_at = Time.now
    # @coupon.save

    @user = User.where(fab10_coupon_code: params[:id]).first
    if @user
      @user.fab10_claimed_at = Time.now
      @user.save
    end
    render json: @user
    # render json: @coupon
  end

end
