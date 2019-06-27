# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api , defaults: { format: :json } do
    namespace :v1 do
      resources :tasks, only: %i[index show create update destroy]
    end
  end
end
