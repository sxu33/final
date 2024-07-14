class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
