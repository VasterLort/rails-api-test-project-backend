class Users::ConfirmationsController < Devise::ConfirmationsController
  respond_to :json

  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?
    after_confirmation_path_for(resource_name, resource)
  end

  protected

  def after_resending_confirmation_instructions_path_for(resource_name)
    is_navigational_format? ? new_session_path(resource_name) : '/'
  end

  def after_confirmation_path_for(resource_name, resource)
    error = resource.errors.first
    if error
      case error.type
      when :already_confirmed
        redirect_to front_sign_in_url + "?status_token=already_confirmed"
      when :invalid
        redirect_to front_sign_in_url + "?status_token=invalid"
      end
    else
      redirect_to front_sign_in_url + "?status_token=confirmed"
    end
  end

  private

  def respond_with(resource, _opts = {})
    if !resource.is_a?(Hash) && resource.errors.full_messages.any?
      render json: {
        message: resource.errors.full_messages
      }, status: :unprocessable_entity
    else
      render json: {
        success: true,
        message: 'success!',
      }, status: :ok
    end
  end
end