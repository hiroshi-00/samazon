class ProductsController < ApplicationController
  before_action :set_product, only: %i[show create edit update destroy]
  
  def index
    if sort_params.present?
      @category = Category.request_category(sort_params[:sort_category])
      @products = Product.sort_products(sort_params, params[:page])
    elsif params[:category].present?
      @category = Category.request_category(params[:category])
      @products = Product.category_products(@category, params[:page])
    else
      @products = Product.display_list(params[:page])
    end
    @categories = Category.all
    @major_category_names = Category.major_categories
    @sort_list = Product.sort_list
  end

  def show
    @reviews = @product.reviews
    @review = @reviews.new
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to product_url @product
  end

  def edit
    @categories = Category.all
  end

  def update
    @product.update(product_params)
    redirect_to product_url @product
  end

  def destroy
    @product.destroy
    redirect_to product_url
  end
  
  private
    def set_product
      @product = Product.find(params[:id])
    end
    
    def product_params
      params.require(:product).permit(:name, :description, :price, :category_id)
    end
    
    def sort_params
      params.permit(:sort, :sort_category)
    end
end
