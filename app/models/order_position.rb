class OrderPosition < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :product_quantity, presence: true. numericality: { only_integer: true }
  validates :price, presence: true, numericality: { greater_than: 0.0 }
end
