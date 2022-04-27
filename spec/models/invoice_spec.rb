require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer)}
    it { should have_many(:transactions)}
    it { should have_many(:invoice_items)}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:merchants).through(:items)}
  end

  describe 'validations' do
    it { should validate_presence_of :status}
  end

  describe 'class methods' do
    it '#incomplete' do
      walmart = Merchant.create!(name: "Wal-Mart")
      bob = Customer.create!(first_name: "Bob", last_name: "Benson")
      item_1 = walmart.items.create!(name: "pickle", description: "sour cucumber", unit_price: 300)
      item_2 = walmart.items.create!(name: "eraser", description: "rubber bit", unit_price: 200)
      item_3 = walmart.items.create!(name: "candle", description: "beeswax", unit_price: 1000)
      item_4 = walmart.items.create!(name: "calculator", description: "scientific", unit_price: 2000)
      item_5 = walmart.items.create!(name: "ball", description: "soccer", unit_price: 900)
      item_6 = walmart.items.create!(name: "notebook", description: "leatherbound", unit_price: 2500)
      item_7 = walmart.items.create!(name: "wine glass", description: "stemless", unit_price: 350)
      item_8 = walmart.items.create!(name: "banjo", description: "five string", unit_price: 30100)
      item_9 = walmart.items.create!(name: "golf tees", description: "2 1/2 inch", unit_price: 100)
      item_10 = walmart.items.create!(name: "radio", description: "AM/FM", unit_price: 900)
      item_11 = walmart.items.create!(name: "adult diaper", description: "family size", unit_price: 400)
      invoice_1 = bob.invoices.create!(status: 1)
      invoice_2 = bob.invoices.create!(status: 1)
      invoice_3 = bob.invoices.create!(status: 1)
      invoice_4 = bob.invoices.create!(status: 1)
      invoice_5 = bob.invoices.create!(status: 1)
      invoice_6 = bob.invoices.create!(status: 1)
      invoice_7 = bob.invoices.create!(status: 1)
      invoice_8 = bob.invoices.create!(status: 1)
      invoice_9 = bob.invoices.create!(status: 1)
      invoice_10 = bob.invoices.create!(status: 1)
      invoice_11 = bob.invoices.create!(status: 1)
      InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 100, status: 1)
      InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 100, status: 2)
      InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, unit_price: 100, status: 2)
      InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 1, unit_price: 100, status: 0)
      InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, unit_price: 100, status: 2)
      InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 1, unit_price: 100, status: 2)
      InvoiceItem.create!(invoice_id: invoice_7.id, item_id: item_7.id, quantity: 1, unit_price: 100, status: 1)
      InvoiceItem.create!(invoice_id: invoice_8.id, item_id: item_8.id, quantity: 1, unit_price: 100, status: 0)
      InvoiceItem.create!(invoice_id: invoice_9.id, item_id: item_9.id, quantity: 1, unit_price: 100, status: 2)
      InvoiceItem.create!(invoice_id: invoice_10.id, item_id: item_10.id, quantity: 1, unit_price: 100, status: 2)
      InvoiceItem.create!(invoice_id: invoice_11.id, item_id: item_11.id, quantity: 1, unit_price: 100, status: 2)

      expect(Invoice.incomplete).to eq([invoice_1, invoice_4, invoice_7, invoice_8])
    end

    it '#sorted_by_newest' do
      walmart = Merchant.create!(name: "Wal-Mart")
      bob = Customer.create!(first_name: "Bob", last_name: "Benson")
      item_1 = walmart.items.create!(name: "pickle", description: "sour cucumber", unit_price: 300)
      item_2 = walmart.items.create!(name: "eraser", description: "rubber bit", unit_price: 200)
      item_3 = walmart.items.create!(name: "candle", description: "beeswax", unit_price: 1000)
      item_4 = walmart.items.create!(name: "calculator", description: "scientific", unit_price: 2000)
      item_5 = walmart.items.create!(name: "ball", description: "soccer", unit_price: 900)
      item_6 = walmart.items.create!(name: "notebook", description: "leatherbound", unit_price: 2500)
      item_7 = walmart.items.create!(name: "wine glass", description: "stemless", unit_price: 350)
      item_8 = walmart.items.create!(name: "banjo", description: "five string", unit_price: 30100)
      item_9 = walmart.items.create!(name: "golf tees", description: "2 1/2 inch", unit_price: 100)
      item_10 = walmart.items.create!(name: "radio", description: "AM/FM", unit_price: 900)
      item_11 = walmart.items.create!(name: "adult diaper", description: "family size", unit_price: 400)
      invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')
      invoice_2 = bob.invoices.create!(status: 1, created_at: '04 Apr 2022 00:53:36 UTC +00:00')
      invoice_3 = bob.invoices.create!(status: 1, created_at: '03 Apr 2022 00:53:36 UTC +00:00')
      invoice_4 = bob.invoices.create!(status: 1, created_at: '02 Apr 2022 00:53:36 UTC +00:00')
      invoice_5 = bob.invoices.create!(status: 1, created_at: '01 Apr 2022 00:53:36 UTC +00:00')
      invoice_6 = bob.invoices.create!(status: 1, created_at: '06 Apr 2022 00:53:36 UTC +00:00')
      invoice_7 = bob.invoices.create!(status: 1, created_at: '07 Apr 2022 00:53:36 UTC +00:00')
      invoice_8 = bob.invoices.create!(status: 1, created_at: '08 Apr 2022 00:53:36 UTC +00:00')
      invoice_9 = bob.invoices.create!(status: 1, created_at: '09 Apr 2022 00:53:36 UTC +00:00')
      invoice_10 = bob.invoices.create!(status: 1, created_at: '10 Apr 2022 00:53:36 UTC +00:00')
      invoice_11 = bob.invoices.create!(status: 1, created_at: '11 Apr 2022 00:53:36 UTC +00:00')
      InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 100, status: 1)
      InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 100, status: 2)
      InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, unit_price: 100, status: 2)
      InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 1, unit_price: 100, status: 0)
      InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, unit_price: 100, status: 2)
      InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 1, unit_price: 100, status: 2)
      InvoiceItem.create!(invoice_id: invoice_7.id, item_id: item_7.id, quantity: 1, unit_price: 100, status: 1)
      InvoiceItem.create!(invoice_id: invoice_8.id, item_id: item_8.id, quantity: 1, unit_price: 100, status: 0)
      InvoiceItem.create!(invoice_id: invoice_9.id, item_id: item_9.id, quantity: 1, unit_price: 100, status: 2)
      InvoiceItem.create!(invoice_id: invoice_10.id, item_id: item_10.id, quantity: 1, unit_price: 100, status: 2)
      InvoiceItem.create!(invoice_id: invoice_11.id, item_id: item_11.id, quantity: 1, unit_price: 100, status: 2)

      expect(Invoice.sorted_by_newest.take(5)).to eq([invoice_11, invoice_10, invoice_9, invoice_8, invoice_7])
    end
  end

  describe 'instance methods' do
    before(:each) do
      @merchant = Merchant.create!(name: "Wal-Mart")

      @item = @merchant.items.create!(name: "pickle", description: "sour cucumber", unit_price: 500)
      @item_2 = @merchant.items.create!(name: "vinegar", description: "used for pickling", unit_price: 100)

      @customer = Customer.create!(first_name: "Bob", last_name: "Benson")
      @invoice_1 = @customer.invoices.create!(status: 1)
      @invoice_2 = @customer.invoices.create!(status: 1)

      @invoice_item = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item.id, quantity: 5, unit_price: 500, status: 1)
      @invoice_item_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 5, unit_price: 100, status: 1)
    end

    it 'can calculate #invoice_total_revenue' do

      expect(@invoice_1.invoice_total_revenue).to eq(3000)
    end

    it 'can calculate #discount_revenue' do
      @discount = @merchant.discounts.create!(name: "Brewfest", threshold: 5, percent: 50)

      expect(@invoice_1.discount_revenue).to eq(1500)
    end

    # it 'can display discounts applied' do
    #   @discount = @merchant.discounts.create!(name: "Brewfest", threshold: 5, percent: 50)
    #   @discount_2 = @merchant.discounts.create!(name: "Nochance", threshold: 50000000, percent: 50)
    #
    #   expect(@invoice_1.items.discount_applied).to eq("Brewfest")
    # end
  end
end
