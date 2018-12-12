class OrdersController < ApplicationController
  before_action :fetch_customer, only: %i[index form_step3]

  def index
    @orders = @customer.orders
    json_response(@orders)
  end

  def form_step1
    @order = Order.new
    validation = CreateOrderValidator::Step1Schema.with(record: @order).call(params.to_unsafe_h)
    if validation.success?
      @order.save
      validation.output[:order][:order_positions].each do |position|
        @order.order_positions.create(position)
      end
      json_response_step1(@order)
    else
      respond_with_error(validation)
    end
  end

  def form_step2
    @customer = Customer.new
    validation = CreateOrderValidator::Step2Schema.with(record: @customer).call(params.to_unsafe_h)
    if validation.success?
      @customer.attributes = validation.output[:customer]
      @customer.save
      order = Order.find(params[:order][:order_id])
      order.update(customer_id: @customer.id)
      json_response_step2(@customer, order)
    else
      respond_with_error(validation)
    end
  end

  def form_step3(expiration_date_parser: ExpirationDateParserService.new)
    @credit_card = @customer.credit_cards.new
    validation = CreateOrderValidator::Step3Schema.with(record: @credit_card).call(params.to_unsafe_h)
    if validation.success?
      @credit_card.attributes = validation.output[:credit_card]
      @credit_card.expiration_date = expiration_date_parser.call(validation.output[:credit_card][:expiration_date])
      @credit_card.save
      json_response(@credit_card)
    else
      respond_with_error(validation)
    end
  end

  private

  def fetch_customer
    @customer = Customer.find(params[:customer][:customer_id])
  end

  def json_response(object, status= :ok)
    render json: object, status: status
  end

  def json_response_step1(order, status= :ok)
    render json: {order: order, positions: order.order_positions }, status: status
  end

  def json_response_step2(customer, order, status= :ok)
    render json: {customer: customer, updated_order: order }, status: status
  end
end
