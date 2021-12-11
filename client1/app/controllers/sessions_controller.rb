class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def get_sso_url
    url = "http://localhost:3000/sso/get_active_token?app_id=#{APP_ID}"
    redirect_to url
  end

  def sign_in
    url = 'http://localhost:3000/sso/authenticate'
    response = HTTParty.get(url, query: {username: params[:username], password: params[:password], app_id: APP_ID}, header: {"Content-Type": "application/json"})
    
    render json: JSON.parse(response.body)
  end

  def sign_out
    if request.headers['token'].present?
      resp = verify_token(request.headers['token'])
      
      if resp["success"] == true
        url = 'http://localhost:3000/sso/destroy_token'
        response = HTTParty.get(url, query: {token: request.headers['token'], app_id: APP_ID}, header: {"Content-Type": "application/json"})
        
        render json: { message: "logged out" }
      else
        render json: {error: 'not authenticated'}, status: 401
      end
    else
      render json: {error: 'not authenticated'}, status: 401
    end
  end
end