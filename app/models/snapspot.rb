class Snapspot < ApplicationRecord
  # associations
  belongs_to :user
  # has_many :likes, dependent: :destroy
  # has_many :comments, dependent: :destroy 

  # validation
  validates :name,:location,:description presence: true

end
