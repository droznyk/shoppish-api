class CreateCreditCardService
  def initialize(credit_card_params)
    @customer = Customer.find(credit_card_params[:customer_id])
    @credit_card_params = credit_card_params
  end

  def call(expiration_date_parser: ExpirationDateParserService.new)
    @credit_card_params[:expiration_date] = expiration_date_parser.call(@credit_card_params[:expiration_date])
    @credit_card = @customer.credit_cards.create(@credit_card_params)
  end

  private

  class OtherExpirationDateParser
    def call(expiration_date)
      month, year = expiration_date.split('/').map(&:to_i)
      year = "20#{year}".to_i
      expiration_date = DateTime.new(year, month, -1)
    end
  end
end
