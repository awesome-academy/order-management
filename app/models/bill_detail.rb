class BillDetail < ApplicationRecord
  BILL_DETAIL_PARAMS = %i(type_detail count price bill_id product_id combo_id).freeze
  enum type_detail: {combo: 1, product: 0}

  belongs_to :bill
  belongs_to :combo, optional: true
  belongs_to :product, optional: true

  validates :count, presence: true, numericality: true

  delegate :name, to: :product, prefix: true, allow_nil: true
  delegate :price, to: :product, prefix: true, allow_nil: true
  delegate :name, to: :combo, prefix: true, allow_nil: true
  delegate :price, to: :combo, prefix: true, allow_nil: true
  delegate :id, to: :bill, prefix: true
  delegate :status, to: :bill, prefix: true

  scope :where_bill, -> bill_id{where(bill_id: bill_id)}
  scope :status_bill, -> status_bill{where(bill_status: status_bill)}
  scope :order_by_type, -> {order(type_detail: :asc)}
end
