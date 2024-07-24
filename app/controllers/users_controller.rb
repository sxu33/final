class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @addresses = @user.addresses
    
  end
end
