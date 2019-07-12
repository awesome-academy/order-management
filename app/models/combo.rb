class Combo < ApplicationRecord
  has_many :bill_details, dependent: :destroy
  has_many :bills, through: :bill_details
  has_many :products
end
