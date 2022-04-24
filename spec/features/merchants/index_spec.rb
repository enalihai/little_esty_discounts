require 'rails_helper'

RSpec.describe 'merchant index' do
  it 'can find all merchants' do
    merchant_1 = Merchant.create!(name: "Testy Tom")
    merchant_2 = Merchant.create!(name: "OOP Pete")
    merchant_3 = Merchant.create!(name: "Michael Van Coverage")

    merchants = Merchant.all

    visit '/merchants/'
    
    expect(page).to have_content("Testy Tom")
    expect(page).to have_content("OOP Pete")
    expect(page).to have_content("Michael Van Coverage")
  end
end
