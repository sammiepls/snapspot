class Like < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :snapspot

  # validation
  validates :user_id, uniqueness: { scope: :snapspot_id }

end
