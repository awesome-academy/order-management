class Combo < ApplicationRecord
  has_many :bill_details, dependent: :destroy
  has_many :bills, through: :bill_details
  has_many :combo_products, dependent: :destroy
  has_many :products, through: :combo_products
  
  scope :list_combos, -> ids{where.not(id: ids)}
end
