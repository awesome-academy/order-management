class BillsController < ApplicationController
  before_action :load_bill, only: %i(destroy update)

  def index
    @tables = Table.includes(:bills).page(params[:page]).per Settings.num_table_order
  end

  def show
    @bill_active = Bill.includes(:table).table_bill_active(params[:id]).take
    @bill = Bill.new
    @table = Table.find_by id: params[:id]
    return if @table
    flash[:danger] = t(".not_exits")
    store_location
    redirect_to root_path
  end

  def create
    @bill = Bill.new bill_params
    if @bill.save
      flash[:success] = t(".success_create")
      redirect_to bill_bill_details_path(@bill)
    else
      flash[:danger] = t(".error_create")
      redirect_to bill_path(@bill.table_id)
    end
  end

  def update
    if @bill.update status: bill_params[:status]
      flash[:success] = t(".update_s")
    else
      flash[:danger] = t(".update_e")
    end
    redirect_to bill_path(@bill.table_id)
  end

  def destroy
    if @bill.destroy
      flash[:success] = t(".delete_s")
    else
      flash[:danger] = t(".delete_err")
    end
    redirect_to @bill
  end

  private
  def bill_params
    params.require(:bill).permit Bill::BILL_PARAMS
  end

  def load_bill
    @bill = Bill.find_by id: params[:id]
    return if @bill
    flash[:danger] = t(".not_exits")
    redirect_to root_path
  end
end
