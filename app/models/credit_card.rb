class CreditCard < ApplicationRecord
  belongs_to :customer, dependent: :destroy

  validates :number, presence: true, length: { is: 8 }, numericality: { only_integer: true }
  validates :cvc, presence: true, length: { is: 3 }, numericality: { only_integer: true }
  validates :expiration_date, presence: true
  validate :expiration_date_cannot_be_in_the_past

  private

  def expiration_date_cannot_be_in_the_past
    if expiration_date.present? && expiration_date < Date.today
      errors.add(:expiration_date, "can't be in the past")
    end
  end
end
