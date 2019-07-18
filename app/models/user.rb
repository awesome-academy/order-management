class User < ApplicationRecord
  USER_PARAMS = %i(phone address name username role password password_confirmation).freeze
  enum role: {employee: 0, manager: 1}

  has_many :bills, dependent: :destroy

  validates :username, format: {with: Settings.VALID_EMAIL_REGEX},
  presence: true, length: {maximum: Settings.max_username},
  uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.min_password}, allow_nil: true
  validates :name, presence: true, length: {minimum: Settings.min_name, maximum: Settings.max_name}
  validates :phone, presence: true, length: {minimum: Settings.min_phone, maximum: Settings.max_phone}
  validates :address, presence: true, length: {minimum: Settings.min_address, maximum: Settings.max_address}

  scope :ordered_by_name, -> {order(name: :asc)}
  
  has_secure_password

  def authenticated? token
    return false if digest.nil?
    BCrypt::Password.new("password_digest").is_password?(token)
  end
end
