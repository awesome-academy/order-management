class BillDetail < ApplicationRecord
  belongs_to :bill
  belongs_to :combo, optional: true
  belongs_to :product, optional: true
end
