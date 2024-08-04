class About < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "content", "id", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
   validates :title, presence: true
  validates :content, presence: true
end
