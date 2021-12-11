# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token
  #before_action :authenticated?, except: [:guest]
  def index
    @original_url = request.original_url
  end

  def dashboard
    if request.headers['token'].present?
      resp = verify_token(request.headers['token'])
      
      if resp["success"] == true
        render json: { message: "here is my dashboard from client 1" }
      else
        render json: {error: 'not authenticated'}, status: 401
      end
    else
      render json: {error: 'not authenticated'}, status: 401
    end
  end
end
