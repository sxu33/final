class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true
  enum status: { unpaid: 0, paid: 1, shipped: 2 }

  def tax_amount
    tax_rate = address.province.tax_rate
    total_price * (tax_rate.gst + tax_rate.pst + tax_rate.hst)
  end

  def grand_total
    total_price + tax_amount
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "user_id", "address_id", "total_price", "status", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "address", "order_items", "products"]
  end

  end

