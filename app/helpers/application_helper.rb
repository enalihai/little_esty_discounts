module ApplicationHelper
  def unit_price_to_currency(input)
    "%.2f" % (input.to_f/100).truncate(2)
  end
end
