class Bill < ApplicationRecord
  BILL_PARAMS = %i(name status user_id table_id number_customer).freeze
  enum status: {cancle: 2, active: 1, unactive: 0}

  belongs_to :user
  belongs_to :table
  has_many :bill_details, dependent: :destroy
  has_many :products, through: :bill_details
  has_many :combos, through: :bill_details

  validates :name, presence: true, length: {minimum: Settings.min_name, maximum: Settings.max_name}
  validates :status, presence: true
  validates :user_id, presence: true, numericality: true
  validates :table_id, presence: true, numericality: true
  validates :number_customer, presence: true, numericality: true
  
  delegate :number, to: :table, prefix: true
  delegate :id, to: :table, prefix: true
  delegate :sum_chair, to: :bill, prefix: true

  scope :table_bill_active, -> (table_id){where(table_id: table_id, status: 1)}
  scope :name_in_table, -> (table_id, name){where(table_id: table_id, name: name, status: 1)}
  scope :sum_chair, -> {sum(:bill_details).group_by(:id, desc)}
end
