class AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def new
    @address = Address.new
  end

  def create
    @address = current_user.addresses.build(address_params)
    if @address.save
      redirect_to user_account_path, notice: 'Address was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to user_account_path, notice: 'Address was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @address.destroy
    redirect_to user_account_path, notice: 'Address was successfully deleted.'
  end

  private

  def set_address
    @address = current_user.addresses.find_by(id: params[:id])
    redirect_to user_account_path, alert: 'Address not found.' if @address.nil?
  end

  def address_params
    params.require(:address).permit(:street, :city, :province_id, :postal_code)
  end
end
