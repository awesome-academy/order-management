class CombosController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_combo, except: %i(new create index search_combo)
  before_action :admin_user, except: %i(show)
  before_action :load_combos, only: %i(index search_combo)
  before_action ->{create_session :combo}

  def index; end
  
  def new
    @combo = Combo.new
  end

  def create
    @combo = Combo.new combo_params
    if @combo.save
      flash[:success] = t("success_create")
      redirect_to @combo
    else
      render :new
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @combo.update combo_params
        format.html {redirect_to @combo}
        format.js
      else
        format.html {render :edit}
        format.js
      end
    end
  end

  def show
    @combo_product = ComboProduct.new
    @products = Product.list_products(@combo.products.pluck(:id)).ordered_by_name
    store_location
  end

  def destroy
    if @combo.destroy
      flash[:success] = t(".delete_s")
    else
      flash[:danger] = t(".delete_err")
    end
    redirect_to combos_url
  end

  def search_combo
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def combo_params
    params.require(:combo).permit Combo::COMBO_PARAMS
  end

  def load_combo
    @combo = Combo.find_by id: params[:id]
    return if @combo
    flash[:danger] = t(".not_exits")
    redirect_to root_path
  end

  def load_combos
    @combos = Combo.where nil
    @combos = @combos.find_by_name(params[:name]) if params[:name].present?
    @combos = @combos.find_by_status(params[:status]) if params[:status].present?
    @combos = @combos.page(params[:page]).per Settings.num_combo
  end
end
