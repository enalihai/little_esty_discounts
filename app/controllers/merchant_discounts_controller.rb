class MerchantDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def create
    @merchant = Merchant.find(params[:id])
    @discount = @merchant.discounts.create(disc_params)

    if @discount.save
      redirect_to "/merchants/#{@merchant.id}/discounts"
    else
      redirect_to "/merchants/#{@merchant.id}/discounts"
      flash[:alert] = "Error: Fields cant be empty, use integers for threshold and percent"
    end
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def destroy
    @discount = Discount.find(params[:id])
    merch_id = @discount.merchant_id
    @discount.destroy
    redirect_to "/merchants/#{merch_id}/discounts"
  end

  private
  def disc_params
    params.permit(:name, :threshold, :percent)
  end
end
