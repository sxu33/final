# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  before_action :set_cart

  def show
  end

  def add_item
    product = Product.find(params[:product_id])
    @cart.add_product(product.id)
    redirect_to cart_path
  end

  def remove_item
    product = Product.find(params[:product_id])
    @cart.remove_product(product.id)
    redirect_to cart_path
  end

  def update_item
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    if quantity > 0
      @cart.update_product(product.id, quantity)
    else
      @cart.remove_product(product.id)
    end
    redirect_to cart_path
  end

   def checkout
    @user = current_user
    @addresses = @user.addresses
    if @addresses.empty?
      @address = Address.new
    else
      @address = @addresses.first
    end
    @cart_items = @cart.cart_items
    @provinces = Province.all
  end
  
  private

  def set_cart
    if user_signed_in?
      @cart = current_user.cart || current_user.create_cart
    else
      @cart = Cart.find_by(id: session[:cart_id])
      if @cart.nil?
        @cart = Cart.create
        session[:cart_id] = @cart.id
      end
    end
  end
end
