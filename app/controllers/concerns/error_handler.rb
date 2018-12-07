module ErrorHandler
  extend ActiveSupport::Concern
  
  def respond_with_error(object, status= :unprocessable_entity)
    render json: { errors: object.errors }, status: status
  end

  included do 
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ errors: e.message }, :not_found)
    end
  end
end
