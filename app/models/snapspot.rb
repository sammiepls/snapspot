class Snapspot < ApplicationRecord
  # associations
  belongs_to :user
  # has_many :likes, dependent: :destroy
  # has_many :comments, dependent: :destroy

  # validation
  validates :name,:description, presence: true
  validate :address_lat_lng

  # geocoded
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address

  def address_lat_lng
    if !address.present? && !latitude.present? && !longitude.present?
      errors.add(:messages, "Address, latitude and longitude can't be blank")
    end
  end

end
