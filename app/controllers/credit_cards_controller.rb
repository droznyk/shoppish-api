class CreditCardsController < ApplicationController
  before_action :fetch_credit_card, only: %i[show update destroy]

  def index
    @credit_cards = Customer.find(params[:customer_id]).credit_cards
    json_response(@credit_cards)
  end

  def create
    @credit_card = CreateCreditCardService.new(credit_card_params.merge(customer_id: params[:customer_id])).call
    @credit_card.persisted? ? json_response(@credit_card, :created) : respond_with_error(@credit_card)
  end

  def show
    json_response(@credit_card)
  end

  def update
    if @credit_card.update(credit_card_params)
      json_response(@credit_card)
    else
      respond_with_error(@credit_card)
    end
  end

  def destroy
    json_response(@credit_card) if @credit_card.destroy
  end

  private

  def credit_card_params
    params.require(:credit_card).permit(:number, :cvc, :expiration_date)
  end

  def json_response(object, status= :ok)
    render json: object, status: status
  end

  def fetch_credit_card
    @credit_card = Customer.find(params[:customer_id]).credit_cards.find(params[:id])
  end
end
