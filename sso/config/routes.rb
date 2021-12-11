# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }

  get 'sso/index'
  get 'sso/verify_token'
  get 'sso/authenticate'
  get 'sso/destroy_token'
  get 'sso/get_active_token'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'sso#index'
end
