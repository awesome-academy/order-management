class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_user, except: %i(new create index search_user)
  before_action :admin_user, except: %i(show edit update)
  before_action :load_users, only: %i(index search_user)
  before_action ->{create_session :user}
  before_action ->{permission_access @user}, only: %i(show edit update)

  def index; end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t(".success_create")
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t(".success_edit")
      redirect_to @user
    else
      render :edit
    end
  end

  def show; end

  def destroy
    if @user.destroy
      flash[:success] = t(".delete_s")
    else
      flash[:danger] = t(".delete_err")
    end
    redirect_to users_url
  end

  def search_user
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def load_user
    @user = User.find_by_id params[:id]
    return if @user
    flash[:danger] = t(".not_exits")
    redirect_to root_path
  end

  def load_users
    @users = User.where nil
    @users = @users.find_by_name(params[:name]) if params[:name].present?
    @users = @users.find_by_role(params[:role]) if params[:role].present?
    @users = @users.page(params[:page]).per Settings.num_user
  end
end
