require 'dry-validation'

class CreateOrderValidator
  CreateOrderSchema = Dry::Validation.Params do
    required(:customer_id).maybe
    required(:order).schema do
      required(:order_positions).each do
        schema do
          required(:product_id).filled
          required(:product_quantity).filled
          required(:price).filled
        end
      end
    end
  end
end
