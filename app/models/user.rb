class User < ApplicationRecord
  # associations
  has_many :authentications, dependent: :destroy
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

  # authentication
  enum access_level: [ :user, :superadmin ]

  def capitalize
    self.first_name = self.first_name.capitalize
    self.last_name = self.last_name.capitalize
    self.email = self.email.downcase
  end

  def full_name
    self.first_name + " " + self.last_name
  end

  # FB
  def self.create_with_auth_and_hash(authentication, auth_hash)

    user = self.create!(
    # If you dont know how to call it, use byebug and auto_hash to see how to call it
    username: auth_hash["extra"]["raw_info"]["short_name"],
    first_name: auth_hash["extra"]["raw_info"]["first_name"],
    last_name: auth_hash["extra"]["raw_info"]["last_name"],
    email: auth_hash["extra"]["raw_info"]["email"],
    password: SecureRandom.hex(7)
    )
    # This connects the authentication to this user
    user.authentications << authentication
    return user
  end

  # grab fb_token to access Facebook for user data
  def fb_token
    x = self.authentications.find_by(provider: 'facebook')
    return x.token unless x.nil?
  end

  def self.authenticate(params)
    user = User.find_by(username:params[:user][:username])
    user.authenticate(params[:user][:password])
  end
end
