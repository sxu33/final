class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0 }

  def total_price
    product.price * quantity
  end
 def self.ransackable_attributes(auth_object = nil)
    ["cart_id", "created_at", "id", "id_value", "product_id", "quantity", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["cart", "product"]
  end
  
end