FactoryBot.define do
  factory :customer do
    name { "John Elder" }
    email { "john@elder.com" }
    street { "Sesame 101" }
    zip_code { "44-115" }
    city { "Washington" }
  end
end
