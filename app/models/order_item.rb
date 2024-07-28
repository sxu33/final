class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  before_save :set_unit_price

  def total_price
    unit_price * quantity
  end

  def set_unit_price
    self.unit_price ||= product.price
  end

  

  def self.ransackable_attributes(auth_object = nil)
    ["id","order_id", "product_id", "quantity", "unit_price", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order", "product"]
  end
end
