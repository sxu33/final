class TaxRate < ApplicationRecord
  belongs_to :province

  validates :gst, :pst, :hst, presence: true
  
def self.ransackable_attributes(auth_object = nil)
    ["id", "province_id", "gst", "pst", "hst", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["province"]
  end
end
