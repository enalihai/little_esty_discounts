class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :discounts, through: :merchant

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  enum status: [:disabled, :enabled]

  def unit_price_to_currency
    "%.2f" % (unit_price.to_f/100).truncate(2)
  end

  def top_selling_date
    invoices.select('invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
            .group('invoices.id')
            .order('revenue desc')
            .first
            .created_at

  end
end
