class Snapspot < ApplicationRecord
  # associations
  belongs_to :user
  # has_many :likes, dependent: :destroy
  # has_many :comments, dependent: :destroy

  # validation
  validates :name,:address,:description, presence: true
  # geocoded
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

end
