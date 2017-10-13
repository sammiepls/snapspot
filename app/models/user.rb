class User < ApplicationRecord
  # associations
  has_many :snapspots, dependent: :destroy
  # has_many :likes, dependent: :destroy
  # has_many :comments, dependent: :destroy

  # validations
  has_secure_password
  validates :username, :email, presence: true
  validates :username, :email, uniqueness:true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :password, length: { minimum:7, maximum:20 }, allow_nil: true
  validates :password_confirmation, confirmation:true, allow_nil:true

  def self.authenticate(params)
    user = User.find_by(username:params[:user][:username])
    user.authenticate(params[:user][:password])
  end
end
