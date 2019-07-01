require 'rails_helper'

RSpec.describe 'sessions', type: :request do
  let(:user) { create(:user) }
  describe 'get new session' do
    context 'invalid username' do
      before {
        post '/api/v1/auth/sign_in',
             params: {
                 email: 'test@example.com',
                 password: user.password,
                 uid: user.uid
             }
      }
      it { expect(response).to have_http_status 401 }
    end

    context 'new session' do
      before {
        post '/api/v1/auth/sign_in',
             params: {
                 email: user.email,
                 password: '12345678'
             }
      }
      it 'valid params' do
        expect(response).to have_http_status 200
        expect(json['data']).to match_response_schema("user")
      end
    end

    context 'delete session' do
      before { delete '/api/v1/auth/sign_out', headers: user.create_new_auth_token }
      it { expect(response).to have_http_status 200 }
    end
  end
end

