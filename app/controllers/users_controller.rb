class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

  end
  
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  def wepay_connect
    @user = current_user
    wepay_gateway = WepayRails::Payments::Gateway.new
    redirect_to wepay_gateway.auth_code_url(wepay_auth_url)
  end


  def create_wepay_account
    @user = current_user
    wepay_gateway = WepayRails::Payments::Gateway.new(@user.wepay_token)
    response = wepay_gateway.create_account({
      :name => "#{@user.name} on Up and Away",
      :description => "This account will collect money on behalf of this user's Up and Away Campaign.",
    })
    @user.wepay_account_id = response[:account_id]
    @user.wepay_account_uri = response[:account_uri]
    @user.save
    redirect_to @user, :notice => "Up&Away and WePay are Connected =)"
  end

  def wepay_auth
    @user = current_user
  if params[:code].present?
    wepay_gateway = WepayRails::Payments::Gateway.new
    access_token = wepay_gateway.get_access_token(params[:code], wepay_auth_url)
    @user.update_attributes(:wepay_token => access_token, :wepay_id => wepay_gateway.account_id) 
      if @user.save
        flash[:success] = "You Got Your Access Token, Now Create Your Account "
      end
  else
    flash[:notice] = "Your WePay account was not connected."
    redirect_to root_path
  end
end


end