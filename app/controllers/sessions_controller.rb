class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by username: params[:session][:username].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      flash[:success] = t(".success")
      redirect_page
    else
      flash.now[:danger] = t(".err")
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private
  def redirect_page
    if current_user.manager?
      create_session :home
      redirect_to root_path
    elsif current_user.chef?
      create_session :list_bill
      redirect_to list_bill_path 
    else
      create_session :bill
      redirect_to bills_path
    end 
  end
end
