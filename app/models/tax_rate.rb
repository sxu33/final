class TaxRate < ApplicationRecord
  belongs_to :province

  validates :gst, :pst, :hst, presence: true
end
