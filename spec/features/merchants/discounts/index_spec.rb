require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Mollys")
    @merchant_2 = Merchant.create!(name: "Berrys")

    @discount1 = @merchant1.discounts.create!(name: "Christmas", threshold: 10, percent: 15)
    @discount2 = @merchant1.discounts.create!(name: "All Saint's Day", threshold: 15, percent: 20)
    @discount3 = @merchant1.discounts.create!(name: "Diamond Monday", threshold: 20, percent: 25)

    @discount4 = @merchant2.discounts.create!(name: "Regular Friday", threshold: 25, percent: 10)
  end

  it "has a link to a merchants discounts" do
    visit "merchants/#{@merchant1.id}"

    click_button("Promotions")
    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts")
  end

  it 'displays all of the attributes of a discount' do
    visit "/merchants/#{@merchant1.id}/discounts"

    expect(page).to have_content(@discount1.name)
    expect(page).to have_content(@discount1.threshold)
    expect(page).to have_content(@discount1.percent)
  end

  it "has shows only that specific merchants discounts" do
    visit "/merchants/#{@merchant1.id}/discounts"

    expect(page).to have_content(@discount1.name)
    expect(page).to have_content(@discount2.name)
    expect(page).to have_content(@discount3.name)
    expect(page).to_not have_content(@discount4.name)
  end
end
