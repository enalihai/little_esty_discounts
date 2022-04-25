require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Mollys")
    @merchant_2 = Merchant.create!(name: "Berrys")

    @discount_1 = @merchant_1.discounts.create!(name: "Christmas", threshold: 10, percent: 15)
    @discount_2 = @merchant_1.discounts.create!(name: "All Saint's Day", threshold: 15, percent: 20)
    @discount_3 = @merchant_1.discounts.create!(name: "Diamond Monday", threshold: 20, percent: 25)

    @discount_4 = @merchant_2.discounts.create!(name: "Regular Friday", threshold: 25, percent: 10)
  end

  it "has a link to a merchants discounts" do
    visit "merchants/#{@merchant_1.id}"

    click_button("Promotions")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts")
  end

  it 'displays all of the attributes of a discount' do
    visit "/merchants/#{@merchant_1.id}/discounts"

    within "ul#discounts-list" do
      expect(page).to have_content(@discount_1.name)
      expect(page).to have_content(@discount_1.threshold)
      expect(page).to have_content(@discount_1.percent)
    end
  end

  it "has shows only that specific merchants discounts" do
    visit "/merchants/#{@merchant_1.id}/discounts"

    within "ul#discounts-list" do
      expect(page).to have_content(@discount_1.name)
      expect(page).to have_content(@discount_2.name)
      expect(page).to have_content(@discount_3.name)
      expect(page).to_not have_content(@discount_4.name)
    end
  end
end
