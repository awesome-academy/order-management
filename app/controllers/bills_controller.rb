class BillsController < ApplicationController
  before_action :load_bill, only: %i(destroy update payment)

  def index
    @table = Table.new
    @tables = Table.includes(:bills).page(params[:page]).per Settings.num_table_order
  end

  def show
    @table = Table.find_by id: params[:id]
    @bill = Bill.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @bill = Bill.new bill_params
    if @bill.save
      flash[:success] = t(".success_create")
      redirect_to bill_bill_details_path(@bill)
    else
      flash[:danger] = t(".error_create")
      redirect_to bills_path
    end
  end

  def update
    if @bill.update status: bill_params[:status]
      flash[:success] = t(".payment_s")
    else
      flash[:danger] = t(".payment_e")
    end
    redirect_to bills_path
  end

  def destroy
    if @bill.destroy
      flash[:success] = t(".delete_s")
    else
      flash[:danger] = t(".delete_err")
    end
    redirect_to @bill
  end

  def payment; end

  def list_bill
    @bills = Bill.active.order_by.page(params[:page]).per Settings.num_bill
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
