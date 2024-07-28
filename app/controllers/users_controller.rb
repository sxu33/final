class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @addresses = @user.addresses
    @orders = @user.orders.includes(:order_items, :address)
    
  end
end
