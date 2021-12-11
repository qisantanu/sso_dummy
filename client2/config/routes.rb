# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/index'
  get '/' => 'home#index'
  get '/sign_in' => 'application#sign_in'

  get '/get_sso_url' => 'sessions#get_sso_url'
  post '/sign_in' => 'sessions#sign_in'
  delete '/sign_out' => 'sessions#sign_out'
  get '/dashboard' => 'home#dashboard'
end
