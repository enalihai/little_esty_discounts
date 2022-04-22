require 'rails_helper'

RSpec.describe 'merchant bulk discount index' do
  it 'shows percentage_discount and quantity for each bulk discount' do
    merchant_1 = Merchant.create(name: "Drew's")
    merchant_2 = Merchant.create(name: "Geddy's")

    bulk_discount_1 = merchant_1.bulk_discounts.create(percentage_discount: 20, quantity_threshold:15  )
    bulk_discount_2 = merchant_1.bulk_discounts.create(percentage_discount: 30, quantity_threshold:25  )
    bulk_discount_3 = merchant_2.bulk_discounts.create(percentage_discount: 10, quantity_threshold:22  )

    visit "/merchants/#{merchant_1.id}/bulk_discounts"

    within"#bulk_discounts" do
      expect(page).to have_content('20%')
      expect(page).to have_content('30%')
      expect(page).to have_content('15')
      expect(page).to have_content('25')
      expect(page).to_not have_content('10%')
      expect(page).to_not have_content('22')
    end
  end
end
