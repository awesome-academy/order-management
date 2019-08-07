class BillsController < ApplicationController
  before_action :load_bill, only: %i(destroy update payment)
  before_action :load_table, only: %i(index search_table)
  before_action ->{create_session :bill}, except: %i(list_bill)
  before_action ->{create_session :list_bill}, only: %i(list_bill)


  def index
    @table = Table.new
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
      ActionCable.server.broadcast "bills",
        stt: Bill.active.size,
        name_customer: @bill.name,
        name_user: current_user.name,
        bill_id: @bill.id,
        type: "add_bill"
      update_status_table Settings.active_table
      flash[:success] = t(".success_create")
      redirect_to bill_bill_details_path(@bill)
    else
      flash[:danger] = t(".error_create")
      redirect_to bills_path
    end
  end

  def update
    if @bill.update status: bill_params[:status]
      ActionCable.server.broadcast "bills",
        bill_id: @bill.id,
        type: "update_bill"
      update_status_table Settings.unactive_table
      flash[:success] = t(".payment_s")
    else
      flash[:danger] = t(".payment_e")
    end
    redirect_to bills_path
  end

  def destroy
    if @bill.destroy
      update_status_table Settings.unactive_table
      ActionCable.server.broadcast "bills",
        bill_id: @bill.id,
        type: "destroy_bill"
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

  def search_table
    respond_to do |format|
      format.html
      format.js
    end
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

  def load_table
    @tables = Table.where nil
    @tables = @tables.find_by_name(params[:name]) if params[:name].present?
    @tables = @tables.find_by_type(params[:type]) if params[:type].present?
    @tables = @tables.find_by_status(params[:status]) if params[:status].present?
    @tables = @tables.page(params[:page]).group_by_id.per Settings.num_table_order
  end

  def update_status_table status
    return if @bill.table.update status: status
    flash[:danger] = t(".delete_err")
    redirect_to bills_path
  end
end
