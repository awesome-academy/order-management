class User < ApplicationRecord
  has_many :bills, dependent: :destroy

  validates :username, format: {with: Settings.VALID_EMAIL_REGEX},
  presence: true, length: {maximum: Settings.max_username},
  uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.min_password}, allow_nil: true

  has_secure_password

  def authenticated? token
    return false if digest.nil?
    BCrypt::Password.new("password_digest").is_password?(token)
  end
end
