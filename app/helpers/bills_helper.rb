module BillsHelper
  def sum_prduct bill
    bill.bill_details.inject(0){|sum, n| sum + n.count}
  end

  def sum_price bill
    bill.bill_details.inject(0){|sum, n| sum + n.count * n.price}
  end

  def get_name_bill bill_detail
    bill_detail.combo? ? bill_detail.combo_name : bill_detail.product_name
  end

  def get_type bill_detail
    bill_detail.combo? ? t(".combo") : t(".product")
  end

  def get_price bill_detail
    bill_detail.price * bill_detail.count
  end

  def sum_product bill_detail_count, combo_product_count
    bill_detail_count * combo_product_count
  end

  def get_bill table
    return if table.bills.active.size == 0
    table.bills.active.first
  end
end
