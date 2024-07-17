class ProductsController < ApplicationController
  def index
    @sort_by = params[:sort_by]
    @products = case @sort_by
                when 'on_sale'
                  Product.where(on_sale: true)
                when 'new_arrivals'
                  Product.where('created_at >= ?', 3.days.ago)
                when 'recently_updated'
                  Product.where('updated_at >= ?', 3.days.ago)
                else
                  Product.all
                end.page(params[:page]).per(10)
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

  
end
