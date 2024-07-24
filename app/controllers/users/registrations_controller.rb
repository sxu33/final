class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  protected

  def after_sign_up_path_for(resource)
    user_account_path
  end

  def after_update_path_for(resource)
    user_account_path
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [addresses_attributes: [:street, :city, :province_id, :postal_code]])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [addresses_attributes: [:street, :city, :province_id, :postal_code]])
  end
end