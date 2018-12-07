class CreateCustomerService
  def initialize(params)
    @customer = Customer.new(params)
  end

  def call
    @customer.save
    return @customer
  end
end
