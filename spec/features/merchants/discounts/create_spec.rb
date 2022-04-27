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

  it 'has a link to create a new discount' do
    visit "/merchants/#{@merchant_1.id}/discounts"

    click_link "Create New Discount"
  end

  it 'takes me to a form to make a new discount then takes me back to the merchants discount page where I see the new discount' do
    visit "/merchants/#{@merchant_1.id}/discounts"

    click_link "Create New Discount"

    fill_in :name, with: "International Championship"
    fill_in :threshold, with: 20
    fill_in :percent, with: 25

    click_button "Submit"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts")

    within "ul#discounts-list" do
      expect(page).to have_content("International Championship")
      expect(page).to have_content("Quantity Needed: 20 items")
      expect(page).to have_content("Percent Discounted: 25%")
    end
  end

  it 'tests for empty input###edge' do
    visit "/merchants/#{@merchant_1.id}/discounts/new"
    fill_in :threshold, with: 10
    fill_in :percent, with: 15

    click_button "Submit"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts/new")
    # expect(page).to have_content("Invalid Input - fields must be filled out correctly")
  end

  it 'tests for symbols###edge' do
    visit "/merchants/#{@merchant_1.id}/discounts/new"
    fill_in :name, with: "Lou's Bobba"
    fill_in :threshold, with: 10
    fill_in :percent, with: "%"

    click_button "Submit"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts/new")
  end

  it 'renders a new form if values are invalid ###edge' do
    visit "/merchants/#{@merchant_1.id}/discounts/new"

    fill_in :name, with: "Lou's Bobba"
    fill_in :threshold, with: 10
    fill_in :percent, with: "%"

    click_button "Submit"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts/new")
  end

  it 'has a button to the discounts index' do
    visit "/merchants/#{@merchant_1.id}/discounts/new"

    expect(page).to have_button("Discounts Index")
  end
end
