# frozen_string_literal: true

class SsoController < ApplicationController
  before_action :authenticate_user!, except: [:verify_token, :authenticate, :destroy_token, :get_active_token]
  def index

  end

  def verify_token
    if params[:token].nil?
      render json: { success: false, message: "Token doesn't exist" }
    else
      token = Token.where(token: params[:token], app_id: params[:app_id]).first
      if token.nil?
        render json: { success: false, message: "Token doesn't exist" }
      else
        user = token.user
        render json: { success: true, email: user.email, message: 'User Found' }
      end
    end
  end

  def authenticate
    user = User.find_for_authentication(email: params[:username])

    if user && user.valid_password?(params[:password])
      t = user.generate_tok(params[:app_id])

      render json: { token: t.token }
    else
      render json: { error: 'no token'}, status: 401
    end
  end

  def destroy_token
    token = Token.where(token: params[:token], app_id: params[:app_id]).first
    token.user.tokens.destroy_all
    render json: { success: true }
  end

  def get_active_token
    user = User.find_by(email: cookies[:cook_sso].presence)
    is_valid_app = user && user.app_ids.split(",").map(&:strip).include?(params[:app_id])

    if user && params[:app_id].present? && is_valid_app && user.tokens.present?
      t = user.generate_tok(params[:app_id])
      render json: { url: 'http://localhost:3000/', active_token:  t.token }
    else
      cookies.delete(:cook_sso)
      current_user = nil
      render json: { url: 'http://localhost:3000/', active_token:  nil }
    end
  end
end
