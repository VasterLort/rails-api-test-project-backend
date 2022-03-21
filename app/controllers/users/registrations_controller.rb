class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    errors = resource.errors.full_messages
    if errors.any?
      render json: {
        message: errors
      }, status: :unprocessable_entity
    else
      render json: {
        success: true,
        message: 'success!',
      }, status: :ok
    end
  end
end