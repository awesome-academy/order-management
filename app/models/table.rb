class Table < ApplicationRecord
  has_many :bills, dependent: :destroy
  
  delegate :name, to: :bill, prefix: true
end
