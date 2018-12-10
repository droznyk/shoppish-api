FactoryBot.define do
  factory :credit_card do
    number { 12345678 }
    cvc { 123 }
    expiration_date { "2018-12-07" }
    customer { 1 }
  end
end
