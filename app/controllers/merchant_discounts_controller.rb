class MerchantDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def create
    @merchant = Merchant.find(params[:id])
    @discount = @merchant.discounts.create(disc_params)
    @discount.save
    redirect_to "/merchants/#{@merchant.id}/discounts"
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  private
  def disc_params
    params.permit(:name, :threshold, :percent)
  end
end
