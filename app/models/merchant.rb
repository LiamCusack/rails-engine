class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices

  def self.list_by_most_items_sold(params)
    joins(invoices: [ :invoice_items, :transactions]).
    merge(Invoice.shipped).
    merge(Transaction.success).
    group('merchants.id').
    select('merchants.*, SUM(invoice_items.quantity) AS count').
    order('count DESC').
    limit(params[:quantity])
  end
end
