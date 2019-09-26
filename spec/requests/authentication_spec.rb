require 'rails_helper'

RSpec.describe 'user registrations ', type: :request do
  let(:user) { create(:user) }

  describe 'GET /auth' do
    context 'invalid password lenght' do
      before do
        post '/auth',
             params: {
                 email: 'test@example.com',
                 password: 'swgfw'
             }
      end

      it { expect(response).to have_http_status 422 }
    end

    context 'with valid params' do
      before do
        post '/auth',
             params: {
                 email: 'test@example.com',
                 password: 'aa123456'
             }
      end

      it 'status 200 and valid user' do
        expect(response).to have_http_status 200
        expect(json['data']).to match_response_schema("user")
      end

      it 'returns correct response' do
        expect(json['data']['provider']).to eq('email')
        expect(json['data']['uid']).to eq('test@example.com')
        expect(json['data']['email']).to eq('test@example.com')
      end
    end
  end

  context 'when email already have been taken' do
    before do
      post '/auth',
           params: {
               email: user.email,
               password: user.password
           }
    end

    it { expect(response).to have_http_status 422 }
    it 'returns correct responce' do
      expect(json['status']).to eq('error')
      expect(json['errors']['full_messages']).to eq(['Email has already been taken'])
    end
  end

  context 'registrations#destroy' do
    before {delete '/auth', headers: user.create_new_auth_token}
    it { expect(response).to have_http_status 200 }
  end
end
