class Product < ApplicationRecord
  has_many :bill_details, dependent: :destroy
  has_many :bills, through: :bill_details
  belongs_to :combo, optional: true
end
