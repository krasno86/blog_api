# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/admin' => 'rails_admin/main#dashboard', as: :admin_root

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api , defaults: { format: :json } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'

      resources :tasks, only: %i[index show create update destroy]
    end
  end
end
