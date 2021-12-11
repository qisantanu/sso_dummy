# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
    cookies[:cook_sso] = {
      :value => current_user.email,
       :expires => 1.year.from_now,
     }
  end

  # DELETE /resource/sign_out
  def destroy
    current_user.tokens.destroy_all
    super
    cookies.delete(:cook_sso)
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
