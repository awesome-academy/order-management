class BillDetailsController < ApplicationController
  before_action :load_bill_detail, only: %i(destroy update)
  before_action :find_bill, only: %i(index)
  
  def index
    @bill_details = BillDetail.includes(:bill).where_bill(params[:bill_id])
    @combos = Combo.page(params[:combo]).not_exits_in_bill(@bill_details.pluck(:combo_id)).per Settings.num_combo
    @products = Product.page(params[:product]).not_exits_in_bill(@bill_details.pluck(:product_id)).per Settings.num_product
    @bill_detail = BillDetail.new
    store_location
  end

  def show; end

  def create
    @bill_detail = BillDetail.new bill_detail_params
    if @bill_detail.save
      flash[:success] = t(".success_create")
      redirect_back_or @bill_detail
    else
      flash[:danger] = t(".error_create")
      redirect_back_or @bill_detail
    end
  end

  def update
    if @bill_detail.update count: params[:bill_detail][:count]
      flash[:success] = t(".success_edit")
      redirect_back_or @bill_detail.bill
    else
      flash[:danger] = t(".error_update")
      redirect_back_or @bill_detail.bill
    end
  end

  def destroy
    if @bill_detail.destroy
      flash[:success] = t(".delete_s")
    else
      flash[:danger] = t(".delete_err")
    end
    redirect_back_or @bill_detail.bill
  end

  private
  def bill_detail_params
    params.require(:bill_detail).permit BillDetail::BILL_DETAIL_PARAMS
  end

  def load_bill_detail
    @bill_detail = BillDetail.find_by id: params[:id]
    return if @bill_detail
    flash[:danger] = t(".not_exits")
    redirect_to root_path
  end

  def find_bill
    @bill = Bill.find_by id: params[:bill_id]
    return if @bill
    flash[:danger] = t(".not_exits")
  end
end
