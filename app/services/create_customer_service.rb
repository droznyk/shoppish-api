class CreateCustomerService
  def initialize(params)
    @customer = Customer.new(params)
  end

  def call
    @customer.save
    @customer
  end
end
