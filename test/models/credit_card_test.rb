require 'test_helper'

class CreditCardTest < ActiveSupport::TestCase
  def setup
    @credit_card = create(:credit_card)
  end

  test 'valid credit card' do
    assert @credit_card.valid?
  end

  test 'invalid without number' do
    @credit_card.number = nil
    refute @credit_card.valid?, 'credit card is valid without a number'
    assert_not_nil @credit_card.errors[:number], 'no validation for number presence'
  end

  test 'invalid with number shorter than 8 digits' do
    @credit_card.number = 123
    refute @credit_card.valid?, 'credit card is valid with number length == 3'
    assert_not_nil @credit_card.errors[:number], 'no validation for number length'
  end

  test 'invalid with number longer than 8 digits' do
    @credit_card.number = 1234567890
    refute @credit_card.valid?, 'credit card is valid with number length == 10'
    assert_not_nil @credit_card.errors[:number], 'no validation for number length'
  end

  test 'invalid when number is a string' do
    @credit_card.number = "1234abcd"
    refute @credit_card.valid?, 'credit card is valid when number is a string'
    assert_not_nil @credit_card.errors[:number], 'no validation for number numericality'
  end

  test 'invalid without cvc' do
    @credit_card.cvc = nil
    refute @credit_card.valid?, 'credit card is valid without a cvc'
    assert_not_nil @credit_card.errors[:cvc], 'no validation for cvc presence'
  end

  test 'invalid with cvc shorter than 3 digits' do
    @credit_card.cvc = 1
    refute @credit_card.valid?, 'credit card is valid with cvc length == 1'
    assert_not_nil @credit_card.errors[:cvc], 'no validation for cvc length'
  end

  test 'invalid with cvc longer than 3 digits' do
    @credit_card.cvc = 123456
    refute @credit_card.valid?, 'credit card is valid with cvc length == 6'
    assert_not_nil @credit_card.errors[:cvc], 'no validation for cvc length'
  end

  test 'invalid when cvc is a string' do
    @credit_card.number = "salami"
    refute @credit_card.valid?, 'credit card is valid when cvc is a string'
    assert_not_nil @credit_card.errors[:cvc], 'no validation for cvc numericality'
  end

  test 'invalid without expiration_date' do
    @credit_card.expiration_date = nil
    refute @credit_card.valid?, 'credit card is valid without an expiration_date'
    assert_not_nil @credit_card.errors[:expiration_date], 'no validation for expiration_date presence'
  end

  test 'invalid when expiration_date is in past' do
    @credit_card.expiration_date = 2.days.ago
    refute @credit_card.valid?, 'credit card is valid when expiration_date is in past'
    assert_not_nil @credit_card.errors[:expiration_date], 'no validation for expiration_date in past'
  end
end
