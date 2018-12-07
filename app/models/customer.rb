class Customer < ApplicationRecord
  has_many :orders
  has_many :credit_cards

  validates_presence_of :name, :email, :street, :zip_code, :city
  validates_uniqueness_of :email
end
