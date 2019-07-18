class Bill < ApplicationRecord
  belongs_to :user
  belongs_to :table
  has_many :bill_details, dependent: :destroy
  has_many :products, through: :bill_details
  has_many :combos, through: :bill_details

  delegate :number, to: :table, prefix: true
end
