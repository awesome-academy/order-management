class TablesController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_table, except: %i(new create index search_table)
  before_action :admin_user, except: %i(show)
  before_action :load_tables, only: %i(index search_table)
  before_action ->{create_session :table}

  def index; end
  
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
    respond_to do |format|
      if @table.update table_params
        flash[:success] = t(".success_edit")
        format.html {redirect_to @table}
        format.js
      else
        flash[:error] = t(".error_edit")
        format.html {render :edit}
        format.js
      end
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

  def search_table
    respond_to do |format|
      format.html
      format.js
    end
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

  def load_tables
    @tables = Table.where nil
    @tables = @tables.find_by_name_table(params[:name]) if params[:name].present?
    @tables = @tables.find_by_type(params[:type]) if params[:type].present?
    @tables = @tables.page(params[:page]).per Settings.num_table
  end
end
