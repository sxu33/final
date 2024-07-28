# app/models/address.rb
class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :orders

  validates :street, :city, :province_id, :postal_code, presence: true

  def full_address
    "#{street}, #{city}, #{province.name}, #{postal_code}"
  end

 def self.ransackable_attributes(auth_object = nil)
    ["id", "user_id", "province_id", "street", "city", "postal_code", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "province"]
  end
end
