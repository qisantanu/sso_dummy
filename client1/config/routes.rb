# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/index'
  get '/' => 'home#index'
  get '/get_sso_url' => 'sessions#get_sso_url'
  post '/sign_in' => 'sessions#sign_in'
  delete '/sign_out' => 'sessions#sign_out'
  get '/dashboard' => 'home#dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
