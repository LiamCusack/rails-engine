class Item < ApplicationRecord
  validates_presence_of :name,
                        :unit_price,
                        :description

  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find_top_item_revenue(params)
    joins(invoice_items: {invoice: :transactions}).
    merge(Invoice.shipped).
    merge(Transaction.success).
    group("items.id").
    select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue").
    order("revenue DESC").
    limit(params[:quantity])
  end
end
