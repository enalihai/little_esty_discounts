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
      flash[:notice] = "Invalid Input - fields must be filled out correctly"
      render :new
    end
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def update
    @discount = Discount.find(params[:id])
    if @discount.update(promo_params)
      redirect_to "/merchants/#{@discount.merchant.id}/discounts/#{@discount.id}"
    else
      redirect_to "/merchants/#{@discount.merchant.id}/discounts/#{@discount.id}"
      flash[:message] = "Error - Invalid Input"
    end
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
