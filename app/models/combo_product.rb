class ComboProduct < ApplicationRecord
  COMBO_PRODUCT_PARAMS = %i(combo_id product_id).freeze
  delegate :name, to: :product, prefix: true
  delegate :name, to: :combo, prefix: true

  belongs_to :combo, optional: true
  belongs_to :product, optional: true

  validates :combo_id, presence: true, numericality: true
  validates :product_id, presence: true, numericality: true
end
