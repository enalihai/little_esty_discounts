class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :merchants, through: :items

  validates_presence_of(:first_name)
  validates_presence_of(:last_name)

  def self.top_five
    joins(:transactions)
    .select('customers.*, count(customers.id) AS customer_count')
    .group(:id)
    .where("transactions.result = 'success'")
    .order('customer_count desc')
    .limit(5)
  end
end
