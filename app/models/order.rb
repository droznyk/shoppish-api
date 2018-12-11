class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_positions
  has_many :products, through: :order_positions
end
