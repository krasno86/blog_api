# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'User registration' do

  path '/api/v1/auth' do
    post 'Creates a new user' do
      tags 'Registration'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
              email: { type: :string },
              password: { type: :string },
              password_confirmation: { type: :string }
          },
          required: %w[email password password_confirmation]
      }

      response '200', 'user registered' do
        let(:user) do
          { email: Faker::Internet.email,
            password: 'aa123456',
            password_confirmation: 'aa123456'}
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { email: 'email', password: '' } }
        run_test!
      end
    end
  end

  path '/api/v1/auth' do
    delete 'deleting user' do
      tags 'Registration'
      consumes 'application/json'
      
      let(:signed_in_user) { create(:user) }
      response '200', 'user deleted' do
        run_test!
      end
    end
  end
end
