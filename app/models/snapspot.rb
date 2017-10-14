class Snapspot < ApplicationRecord
  # associations
  belongs_to :user
  # has_many :likes, dependent: :destroy
  # has_many :comments, dependent: :destroy

  # validation
  validates :name,:description, presence: true
  validate :address_lat_lng, :must_have_three_tags

  # tags
  acts_as_taggable

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

  def must_have_three_tags
    if !self.tag_list.count == 3
      errors.add(:tags, "Please supply 3 tags that best describe your SnapSpot")
    end
  end

end
