class Product < ApplicationRecord
  has_many :order_positions
  has_many :orders, through: :order_positions
  
  validates_presence_of :name, :description, :price, :quantity
  validates_numericality_of :price, :quantity, greater_than_or_equal_to: 0.0
  validates :description, length: { maximum: 800 }
  validates :quantity, numericality: { only_integer: true }
end
