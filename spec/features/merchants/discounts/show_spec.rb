require 'rails_helper'

RSpec.describe 'discount show page', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Mollys")
    @merchant_2 = Merchant.create!(name: "Berrys")

    @discount_1 = @merchant_1.discounts.create!(name: "Christmas", threshold: 10, percent: 15)
    @discount_2 = @merchant_1.discounts.create!(name: "All Saint's Day", threshold: 15, percent: 20)
    @discount_3 = @merchant_1.discounts.create!(name: "Diamond Monday", threshold: 20, percent: 25)

    @discount_4 = @merchant_2.discounts.create!(name: "Regular Friday", threshold: 25, percent: 10)
  end

  it 'exists and displays the attributes of the discount' do
    visit "/merchants/#{@merchant_1.id}/discounts/#{@discount_1.id}"

    expect(page).to have_content("Discount Name: Christmas")
    expect(page).to have_content("Quantity Needed: #{@discount_1.threshold} items")
    expect(page).to have_content("Percent Discounted: #{@discount_1.percent}%")
    expect(page).to_not have_content("Percent Discounted: #{@discount_2.percent}%")
    expect(page).to_not have_content("Percent Discounted: #{@discount_2.percent}%")
  end
end
