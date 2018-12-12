class Order < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :order_positions
  has_many :products, through: :order_positions
  accepts_nested_attributes_for :order_positions
end
