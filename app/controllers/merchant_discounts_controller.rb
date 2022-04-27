class MerchantDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    holiday_list
  end

  def create
    @merchant = Merchant.find(params[:id])
    @discount = @merchant.discounts.create(disc_params)
    merch_id = @merchant.id
    disc_id = @discount.id

    if @discount.save
      redirect_to "/merchants/#{@merchant.id}/discounts"
      flash[:message] = "New Discount Created"
    else
      redirect_to "/merchants/#{merch_id}/discounts/new"
      flash[:message] = "Invalid Input"
    end
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    @discount = Discount.find(params[:id])
    if @discount.update(disc_params)
      redirect_to "/merchants/#{@discount.merchant.id}/discounts/#{@discount.id}"
      flash[:message] = "Discount Updated!"
    else
      render "edit"
      flash[:message] = "Invalid Input"
    end
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
