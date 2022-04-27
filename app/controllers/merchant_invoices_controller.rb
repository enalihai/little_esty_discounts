class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
    @items = @invoice.items
    @merchant = Merchant.find(params[:merchant_id])
  end
end
