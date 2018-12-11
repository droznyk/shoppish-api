FactoryBot.define do
  factory :order_position do
    order { nil }
    product { nil }
    product_quantity { 1 }
    price { 1.5 }
  end
end
