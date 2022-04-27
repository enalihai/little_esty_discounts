require 'rails_helper'

RSpec.describe "Holiday" do
  it 'exists' do
    input = {:date => "2022-05-30", :name => "Memorial Day"}
    holiday = Holiday.new(input)
    expect(holiday).to be_a(Holiday)
  end

  it 'has data that can be used' do
    input = {:date => "2022-05-30", :name => "Memorial Day"}
    holiday = Holiday.new(input)
    expect(holiday.date).to eq("2022-05-30")
    expect(holiday.name).to eq("Memorial Day")
  end
end
