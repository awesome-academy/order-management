class Table < ApplicationRecord
  TABLE_PARAMS = %i(number description amount_chair status).freeze
  enum amount_chair: {single_table: 1, double_table: 2, four_table: 4, eight_table: 8}
  enum status: {active: 1, unactive: 0}

  has_many :bills, dependent: :destroy

  validates :number, presence: true, length: {minimum: Settings.min_number_table, maximum: Settings.max_number_table}
  validates :description, presence: true

  scope :ordered_by_number, -> {order(number: :asc)}
  scope :find_by_name, -> name {joins(:bills).where("bills.name like ?", "%#{name}%").where(status: Settings.active_table)}
  scope :group_by_id, -> {group(:id)}
  scope :find_by_type, -> type {where(amount_chair: type)}
  scope :find_by_status, -> status {where(status: status)}

  delegate :name, to: :bill, prefix: true
  delegate :status, to: :bill, prefix: true
end
