# frozen_string_literal: true

require 'httparty'
class ApplicationController < ActionController::Base


  def verify_token(token)
    verify_url = "http://localhost:3000/sso/verify_token?token=#{token}&app_id=#{APP_ID}"

    response = HTTParty.get(verify_url)
  end

  helper_method :user_signed_in?, :current_user
end
