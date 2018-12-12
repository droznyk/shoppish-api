require 'dry-validation'

class CreateOrderValidator
  Step1Schema = Dry::Validation.Params do
    optional(:customer_id).maybe
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

  Step2Schema = Dry::Validation.Params do
    configure do
      option :record

      config.messages_file = File.join(Rails.root, 'config',
        'locales', 'validation_errors.en.yml')

      def case_insensitive_unique?(attr_name, value)
        record.class.where.not(name: record.name).where("LOWER(#{attr_name}) = ?", value.downcase).empty?
      end
    end

    required(:customer).schema do
      required(:name).filled(:str?)
      required(:email).filled(:str?, case_insensitive_unique?: :email)
      required(:street).filled(:str?)
      required(:zip_code).filled(:str?)
      required(:city).filled(:str?)
    end
  end

  Step3Schema = Dry::Validation.Params do
    configure do
      option :record

      config.messages_file = File.join(Rails.root, 'config',
        'locales', 'validation_errors.en.yml')

      def in_future?(value)
        month, year = value.split('/').map(&:to_i)
        year = "20#{year}".to_i
        value = DateTime.new(year, month, -1)
        value >= Date.today
      end

      def equal_length?(expected_length, value)
        value.to_s.length == expected_length
      end
    end

    required(:customer).schema do
      required(:customer_id).filled(:int?)
    end

    required(:credit_card).schema do
      required(:number).filled(:int?, equal_length?: 8)
      required(:cvc).filled(:int?, equal_length?: 3)
      required(:expiration_date).filled(size?: 5, in_future?: :expiration_date)
    end
  end
end
