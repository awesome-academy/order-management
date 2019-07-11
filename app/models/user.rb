class User < ApplicationRecord
  has_many :bills, dependent: :destroy
end
