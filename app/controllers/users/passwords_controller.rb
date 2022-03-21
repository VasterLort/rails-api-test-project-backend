class Users::PasswordsController < Devise::PasswordsController

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    set_minimum_password_length
    resource.reset_password_token = params[:reset_password_token]
    redirect_to front_edit_user_password_url + "?reset_password_token=#{params[:reset_password_token]}"
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