class Province < ApplicationRecord
  has_many :addresses
  has_one :tax_rate, dependent: :destroy
  
  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["addresses", "tax_rate"]
  end
end
