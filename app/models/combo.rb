class Combo < ApplicationRecord
  COMBO_PARAMS = %i(name price status).freeze
  enum status: {allowed: 1, unallowed: 0}

  has_many :bill_details, dependent: :destroy
  has_many :bills, through: :bill_details
  has_many :combo_products, dependent: :destroy
  has_many :products, through: :combo_products
  
  validates :price, presence: true, numericality: true
  validates :name, presence: true, length: {minimum: Settings.min_name_combo, maximum: Settings.max_name_combo}

  scope :list_combos, -> id_combo{where.not(id: id_combo)}
  scope :ordered_by_name, -> {order name: :asc}
  scope :not_exits_in_bill, -> id_combo{where.not(id: id_combo)}
end
