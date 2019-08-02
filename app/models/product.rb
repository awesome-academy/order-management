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

  scope :list_products, -> id_product{where.not(id: id_product)}
  scope :ordered_by_name, -> {order(name: :asc)}
  scope :not_exits_in_bill, -> id_product{where.not(id: id_product)}
  scope :find_by_name, -> name {where("name like ?", "%#{name}%")}
  scope :find_by_status, -> status {where(status: status)}
end
