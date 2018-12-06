require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = build(:product)
  end

  test 'valid product' do
    assert @product.valid?
  end

  test 'invalid without name' do
    @product.name = nil
    refute @product.valid?, 'product is valid without a name'
    assert_not_nil @product.errors[:name], 'no validation for name presence'
  end

  test 'invalid without description' do
    @product.description = nil
    refute @product.valid?, 'product is valid without a description'
    assert_not_nil @product.errors[:description], 'no validation for description presence'
  end

  test 'invalid with description longer than 800 chars' do
    @product.description = (0...805).map { ('a'..'z').to_a[rand(26)] }.join
    refute @product.valid?, 'product is valid with a description longer than 800 characters'
    assert_not_nil @product.errors[:description], 'no validation for description length'
  end

  test 'invalid without price' do
    @product.price = nil
    refute @product.valid?, 'product is valid without a price'
    assert_not_nil @product.errors[:price], 'no validation for price presence'
  end

  test 'invalid with a negative price' do
    @product.price = -5
    refute @product.valid?, 'product is valid with a negative price'
    assert_not_nil @product.errors[:price], 'no validation for price greater than 0'
  end

  test 'invalid when price is not a number' do
    @product.price = "fifty"
    refute @product.valid?, 'product is valid when price is not a number'
    assert_not_nil @product.errors[:price], 'no validation for price numericalty'
  end

  test 'invalid without quantity' do
    @product.quantity = nil
    refute @product.valid?, 'product is valid without a quantity'
    assert_not_nil @product.errors[:quantity], 'no validation for quantity presence'
  end

  test 'invalid with a negative quantity' do
    @product.quantity = -30
    refute @product.valid?, 'product is valid with a negative quantity'
    assert_not_nil @product.errors[:quantity], 'no validation for quantity greater than 0'
  end

  test 'invalid when quantity is a decimal fraction' do
    @product.quantity = 10.5
    refute @product.valid?, 'product is valid with a decimal fraction'
    assert_not_nil @product.errors[:quantity], 'no validation for quantity decimal fraction'
  end

  test 'invalid when quantity is not a number' do
    @product.quantity = "seventy"
    refute @product.valid?, 'product is valid when quantity is not a number'
    assert_not_nil @product.errors[:quantity], 'no validation for quantity numericalty'
  end
end
