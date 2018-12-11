class OrdersController < ApplicationController
  before_action :fetch_customer, only: %i[index create]

  def index
    @orders = @customer.orders
  end

  def create
    @order = @customer.orders.new
    validation = CreateOrderValidator::CreateOrderSchema.with(record: @order).call(params.to_unsafe_h)
    if validation.success?
      @order.save
      json_response(@order)
    else
      respond_with_error(validation)
    end
  end

  private

  def fetch_customer
    @customer = Customer.find(params[:customer_id])
  end

  def order_params
    params.require(:order).permit(:customer_id, order_positions_attributes: [:product_id, :product_quantity, :price])
    # schema = Dry::Validation.Schema do
    #   required(:customer_id).filled(:int?)
    # end
  end

  def json_response(object, status= :ok)
    render json: object, status: status
  end
end
