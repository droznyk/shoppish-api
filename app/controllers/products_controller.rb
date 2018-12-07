class ProductsController < ApplicationController
  before_action :fetch_product, only: %i[show update destroy]
  def index
    @products = Product.all
    json_response(@products)
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      json_response(@product, :created)
    else
      respond_with_error(@product, :unprocessable_entity)
    end
  end

  def show
    json_response(@product)
  end

  def update
    if @product.update(product_params)
      json_response(@product)
    else
      respond_with_error(@product, :unprocessable_entity)
    end
  end

  def destroy
    json_response(@product) if @product.destroy
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity)
  end

  def json_response(object, status= :ok)
    render json: object, status: status
  end

  def fetch_product
    @product = Product.find(params[:id])
  end

  def respond_with_error(object, status)
    render json: { errors: object.errors }, status: status
  end
end
