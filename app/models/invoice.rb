class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates_presence_of :status

  enum status: ["in progress".to_sym, :completed, :cancelled]

  def self.incomplete
    joins(:invoice_items)
    .where('invoice_items.status != ?', '2')
    .distinct
    .order(:id)
  end

  def self.sorted_by_newest
    order(created_at: :desc)
  end

  def dates
    created_at.strftime("%A, %B %d, %Y")
  end

  def full_name
    customer.first_name + " " +  customer.last_name
  end

  def invoice_total_revenue
    invoice_items.sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def discount_revenue
    invoice_items.joins(:discounts)
    .select('invoice_items.id, MAX((invoice_items.unit_price * invoice_items.quantity)* (discounts.percent /100.00)) AS applied_discount')
    .where('invoice_items.quantity >= discounts.threshold')
    .group('invoice_items.id')
    .sum(&:applied_discount)
  end
end
