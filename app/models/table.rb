class Table < ApplicationRecord
  TABLE_PARAMS = %i(number description amount_chair).freeze
  enum amount_chair: {single_table: 1, double_table: 2, four_table: 4, eight_table: 8}

  has_many :bills, dependent: :destroy

  validates :number, presence: true, length: {minimum: Settings.min_number_table, maximum: Settings.max_number_table}
  validates :description, presence: true

  scope :ordered_by_number, -> {order(number: :asc)}
  
  delegate :name, to: :bill, prefix: true
  delegate :status, to: :bill, prefix: true
end
