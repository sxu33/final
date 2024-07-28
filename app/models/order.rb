class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
   accepts_nested_attributes_for :order_items, allow_destroy: true

  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true
  enum status: { unpaid: 0, paid: 1, shipped: 2 }

  def tax_amount
    total_price * (gst_rate + pst_rate + hst_rate)
  end

  def grand_total
    total_price + tax_amount
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "user_id", "address_id", "total_price", "status", "gst_rate", "pst_rate", "hst_rate", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "address", "order_items", "products"]
  end
end
