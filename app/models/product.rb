class Product < ApplicationRecord
  PRODUCT_PARAMS = %i(name price image status).freeze
  enum status: {allowed: 1, unallowed: 0}

  has_many :bill_details, dependent: :destroy
  has_many :bills, through: :bill_details
  has_many :combo_products, dependent: :destroy
  has_many :combos, through: :combo_products
  mount_uploader :image, PictureUploader

  validates :price, presence: true, length: {minimum: Settings.min_password}, numericality: true
  validates :name, presence: true, length: {minimum: Settings.min_name, maximum: Settings.max_name}
end
