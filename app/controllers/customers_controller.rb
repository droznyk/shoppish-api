class CustomersController < ApplicationController
  before_action :fetch_customer, only: %i[show update]
  def create
    @customer = CreateCustomerService.new(customer_params).call
    @customer.persisted? ? json_response(@customer, :created) : respond_with_error(@customer)
  end

  def show
    json_response(@customer)
  end

  def update
    if @customer.update(customer_params)
      json_response(@customer)
    else
      respond_with_error(@customer)
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :street, :zip_code, :city)
  end

  def fetch_customer
    @customer = Customer.find(params[:id])
  end

  def json_response(object, status= :ok)
    render json: object, status: status
  end
end
