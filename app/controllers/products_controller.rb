class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @query = params[:query]
    @category_id = params[:category_id]

    if @category_id.present?
      @products = Product.where("name LIKE ? AND category_id = ?", "%#{@query}%", @category_id).page(params[:page]).per(10)
    else
      @products = Product.where("name LIKE ?", "%#{@query}%").page(params[:page]).per(10)
    end
  end

  def on_sale
    @products = Product.where(on_sale: true).page(params[:page]).per(10)
  end

  def new_arrivals
    @products = Product.where(new: true).page(params[:page]).per(10)
  end

  def recently_updated
    @products = Product.where(recently_updated: true).page(params[:page]).per(10)
  end
end
