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

    click_button("Discounts")
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

  it 'has a delete button that works' do
    visit "/merchants/#{@merchant_1.id}/discounts"

    within("div#disc-#{@discount_1.id}") do
      click_link("Delete Discount")
    end

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts")
    expect(page).to_not have_content("#{@discount_1.name}")
  end

  it 'has a link to create a new discount' do
    visit "/merchants/#{@merchant_1.id}/discounts"

    expect(page).to have_link("Create New Discount")
  end

  it 'has a header of upcoming holidays' do
    visit "/merchants/#{@merchant_1.id}/discounts"

    within("header") do
      expect(page).to have_content("Upcoming Holidays")
    end
  end

  it 'displays the name and date of the next 3 us holidays' do
    visit "/merchants/#{@merchant_1.id}/discounts"

    within("header") do
      expect(page).to have_content("Memorial Day - 2022-05-30")
      expect(page).to have_content("Juneteenth - 2022-06-30")
      expect(page).to have_content("Independence Day - 2022-07-04")
    end
  end
end
