class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  has_one_attached :image

   def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "name", "price", "updated_at", "on_sale", "new", "recently_updated", "category_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[image_attachment image_blob category]
  end
end
