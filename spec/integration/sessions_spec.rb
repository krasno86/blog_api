# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Session' do
  path '/auth/sign_in' do

    post 'Creates a new session' do
      tags 'Session'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
              email: { type: :string },
              password: { type: :string }
          },
          required: %w[email password ]
      }

      let(:user_1) { create(:user) }

      response '200', 'session created' do
        let(:user) { { email: user_1.email, password: user_1.password } }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:user) { { email: 'email', password: 'ssword' } }
        run_test!
      end
    end
  end
end
