class TablesController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_table, except: %i(new create index)
  before_action :admin_user, except: %i(show)

  def index
    @tables = Table.page(params[:page]).per(Settings.num_table).ordered_by_number
  end
  
  def new
    @table = Table.new
  end

  def create
    @table = Table.new table_params
    if @table.save
      flash[:success] = t(".success_create")
      redirect_to @table
    else
      render :new
    end
  end

  def edit; end

  def update
    if @table.update table_params
      flash[:success] = t(".success_edit")
      redirect_to @table
    else
      render :edit
    end
  end

  def show; end

  def destroy
    if @table.destroy
      flash[:success] = t(".delete_s")
    else
      flash[:danger] = t(".delete_err")
    end
    redirect_to tables_url
  end

  private
  def table_params
    params.require(:table).permit Table::TABLE_PARAMS
  end

  def load_table
    @table = Table.find_by id: params[:id]
    return if @table
    flash[:danger] = t(".not_exits")
    redirect_to root_path
  end
end
