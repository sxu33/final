class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_items
  has_many :carts, through: :cart_items
  accepts_nested_attributes_for :cart_items, allow_destroy: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  has_one_attached :image

   def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "name", "price", "updated_at", "on_sale", "new", "recently_updated", "category_id","cart_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[image_attachment image_blob category cart]
  end
end
