class BillDetailsController < ApplicationController
  before_action :load_bill_detail, only: %i(destroy update show)
  before_action :find_bill, only: %i(index show_products show_combos show)
  before_action ->{create_session :bill}
  
  def index
    @bill_details = BillDetail.includes(:bill).where_bill(params[:bill_id])
    respond_to do |format|
      format.html
      format.js do
        @bill = Bill.find_by(id: bill_detail_params[:bill_id])
      end
    end
  end

  def show
    respond_to do |format|
      format.html {@bill_detail}
      format.js
    end
  end

  def create
    respond_to do |format|
      @bill_detail = BillDetail.new bill_detail_params
      @bill = Bill.find_by id: bill_detail_params[:bill_id]
      if @bill_detail.save
        load_bill_details @bill.id
        ActionCable.server.broadcast "bills",
          bill_id: @bill.id,
          bill_detail_id: @bill_detail.id,
          href: @bill_detail.product? ? "products/#{@bill_detail.product_id}" : "combos/#{@bill_detail.combo_id}",
          type: @bill_detail.type_detail,
          stt: @bill_details.size,
          name: @bill_detail.product? ? @bill_detail.product_name : @bill_detail.combo_name,
          count: @bill_detail.count,
          type: "add"
        if @bill_detail.product?
          @products = Product.page(params[:product]).not_exits_in_bill(@bill.bill_details.pluck(:product_id)).per Settings.num_product
        else
          @combos = Combo.page(params[:combo]).not_exits_in_bill(@bill.bill_details.pluck(:combo_id)).per Settings.num_combo
        end
        format.js
      else
        format.html {redirect_to @bill_detail}
      end
    end
  end

  def update
    respond_to do |format|
      if @bill_detail.update count: params[:bill_detail][:count]
        load_bill_details @bill_detail.bill_id
        format.js
        @bill ||= Bill.find_by(id: bill_detail_params[:bill_id])
        ActionCable.server.broadcast "bills",
          bill_id: @bill.id,
          bill_detail_id: @bill_detail.id,
          count: @bill_detail.count,
          type: "update"
      else
        format.html do
          flash[:danger] = t(".error_update")
          redirect_to @bill_detail.bill
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @bill_detail.destroy
        format.js do
          load_bill_details @bill_detail.bill_id
          @bill = Bill.find_by(id: params[:bill_id])
          ActionCable.server.broadcast "bills",
            bill_id: @bill.id,
            bill_detail_id: @bill_detail.id,
            type: "destroy"
        end
      end
    end
  end

  def show_products
    @bill ||= Bill.find_by(id: bill_detail_params[:bill_id])
    @products = Product.page(params[:product]).not_exits_in_bill(@bill.bill_details.pluck(:product_id)).per Settings.num_product
  end

  def show_combos
    @bill ||= Bill.find_by(id: bill_detail_params[:bill_id])
    @combos = Combo.page(params[:combo]).not_exits_in_bill(@bill.bill_details.pluck(:combo_id)).per Settings.num_combo
  end

  private
  def bill_detail_params
    params.require(:bill_detail).permit BillDetail::BILL_DETAIL_PARAMS
  end

  def load_bill_detail
    @bill_detail = BillDetail.find_by id: params[:id]
    return if @bill_detail
    flash[:danger] = t(".not_exits")
    redirect_toload_bill_details
  end

  def find_bill
    @bill = Bill.find_by id: params[:bill_id]
  end

  def load_bill_details bill_id
    @bill_details = BillDetail.where_bill bill_id
  end
end
