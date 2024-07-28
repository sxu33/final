class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
    @addresses = current_user.addresses
    @address = Address.new
    @cart_items = current_user.cart.cart_items
    @tax_rate = calculate_tax_rate(@addresses.first)
  end

  def create_address
    @address = current_user.addresses.build(address_params)
    if @address.save
      redirect_to new_order_path, notice: 'Address was successfully created.'
    else
      @order = Order.new
      @addresses = current_user.addresses
      @cart_items = current_user.cart.cart_items
      @tax_rate = calculate_tax_rate(@addresses.first)
      render :new
    end
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.total_price = calculate_total_price
    @order.status = "unpaid"

    if @order.save
      create_order_items
      current_user.cart.cart_items.destroy_all
      redirect_to invoice_order_path(@order), notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def invoice
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:address_id)
  end

  def address_params
    params.require(:address).permit(:street, :city, :province_id, :postal_code)
  end

  def calculate_tax_rate(address)
    return TaxRate.new(gst: 0, pst: 0, hst: 0) if address.nil?
    address.province.tax_rate
  end

  def calculate_total_price
    total = current_user.cart.cart_items.sum { |item| item.product.price * item.quantity }
    address = current_user.addresses.find(params[:order][:address_id])
    tax_rate = address.province.tax_rate
    total * (1 + tax_rate.gst + tax_rate.pst + tax_rate.hst)
  end

  def create_order_items
    current_user.cart.cart_items.each do |item|
      @order.order_items.create(
        product: item.product,
        quantity: item.quantity,
        unit_price: item.product.price
      )
    end
  end
end
