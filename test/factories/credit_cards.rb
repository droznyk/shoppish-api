FactoryBot.define do
  factory :credit_card do
    number { 12345678 }
    cvc { 123 }
    expiration_date { "#{Time.now}" }
    customer
  end
end
