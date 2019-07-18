class Product < ApplicationRecord
  PRODUCT_PARAMS = %i(name price image status).freeze
  enum status: {allowed: 1, unallowed: 0}

  has_many :bill_details, dependent: :destroy
  has_many :bills, through: :bill_details
  has_many :combo_products, dependent: :destroy
  has_many :combos, through: :combo_products
  mount_uploader :image, PictureUploader

  validates :price, presence: true, numericality: true
  validates :name, presence: true, length: {minimum: Settings.min_name_product, maximum: Settings.max_name_product}

  scope :list_products, -> ids{where.not(id: ids)}
  scope :ordered_by_name, -> {order(name: :asc)}
end
