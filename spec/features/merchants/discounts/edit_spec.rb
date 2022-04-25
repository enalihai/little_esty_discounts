require 'rails_helper'

RSpec.describe 'create new discounts' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Mollys")
    @merchant_2 = Merchant.create!(name: "Berrys")

    @discount_1 = @merchant_1.discounts.create!(name: "Christmas", threshold: 10, percent: 15)
    @discount_2 = @merchant_1.discounts.create!(name: "All Saint's Day", threshold: 15, percent: 20)
    @discount_3 = @merchant_1.discounts.create!(name: "Diamond Monday", threshold: 20, percent: 25)

    @discount_4 = @merchant_2.discounts.create!(name: "Regular Friday", threshold: 25, percent: 10)
  end

  it 'has a link to edit the discount' do
    visit "/merchants/#{@merchant_1.id}/discounts/#{@discount_1.id}"

    click_link("Edit Discount")

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts/#{@discount_1.id}/edit")

    expect(page).to have_content("Discount Edit Page")
  end

  it 'takes me back to the discount show page and has updated attributes' do
    visit "/merchants/#{@merchant_1.id}/discounts/#{@discount_1.id}"

    click_link("Edit Discount")

    fill_in :name, with: "0mas"
    fill_in :threshold, with: 0
    fill_in :percent, with: 0

    click_button("Submit")

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts/#{@discount_1.id}")

    expect(page).to have_content("Discount Name: 0mas")
    expect(page).to have_content("Quantity Needed: 0 items")
    expect(page).to have_content("Percent Discounted: 0%")
  end
end
