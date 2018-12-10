require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  def setup
    @customer = create(:customer)
  end

  test 'valid customer' do
    assert @customer.valid?
  end

  test 'invalid without a name' do
    @customer.name = nil
    refute @customer.valid?, 'customer is valid without a name'
    assert_not_nil @customer.errors[:name], 'no validation for name presence'
  end

  test 'invalid without an email' do
    @customer.email = nil
    refute @customer.valid?, 'customer is valid without an email'
    assert_not_nil @customer.errors[:email], 'no validation for email presence'
  end

  test 'invalid when email already taken' do
    @customer_duplicate = build(:customer)
    refute @customer_duplicate.valid?, 'customer is valid when email already taken'
    assert_not_nil @customer.errors[:email], 'no validation for email uniqueness'
  end

  test 'invalid without a street' do
    @customer.street = nil
    refute @customer.valid?, 'customer is valid without a street'
    assert_not_nil @customer.errors[:street], 'no validation for street presence'
  end

  test 'invalid without a zip_code' do
    @customer.zip_code = nil
    refute @customer.valid?, 'customer is valid without a zip_code'
    assert_not_nil @customer.errors[:zip_code], 'no validation for zip_code presence'
  end

  test 'invalid without a city' do
    @customer.city = nil
    refute @customer.valid?, 'customer is valid without a city'
    assert_not_nil @customer.errors[:city], 'no validation for city presence'
  end
end
