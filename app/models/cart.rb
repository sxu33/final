class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product_id)
    current_item = cart_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = cart_items.build(product_id: product_id)
      current_item.quantity = 1
    end
    current_item.save
  end

  def remove_product(product_id)
    current_item = cart_items.find_by(product_id: product_id)
    current_item&.destroy
  end

  def update_product(product_id, quantity)
    current_item = cart_items.find_by(product_id: product_id)
    if current_item
      current_item.update(quantity: quantity)
    end
  end

  def total_price
    cart_items.to_a.sum { |item| item.total_price }
  end

   def self.ransackable_attributes(auth_object = nil)
    ["id", "user_id", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "cart_items", "products"]
  end
end