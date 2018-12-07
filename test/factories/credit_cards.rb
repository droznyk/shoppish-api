FactoryBot.define do
  factory :credit_card do
    number { 1 }
    cvc { 1 }
    expiration_date { "2018-12-07" }
    customer { nil }
  end
end
