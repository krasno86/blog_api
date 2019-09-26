require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { create(:user) }

  describe 'POST #create' do
    context 'with not verified user' do
      before do
        post '/auth/sign_in',
             params: {
                 email: '1@example.com',
                 password: 'asd123456'
             }
      end
      it { expect(response).to have_http_status 401 }
    end

    context 'when all params are correct' do
      before do
        post '/auth/sign_in',
             params: {
                 email: user.email,
                 password: user.password
             }
      end

      it 'success' do
        expect(response).to have_http_status 200
        expect(json['data']).to match_response_schema('user')
        expect(response.has_header?('access-token')).to eq(true)
      end
    end

    context 'destroy session' do
      before { delete '/auth/sign_out', headers: user.create_new_auth_token }
      it { expect(response).to have_http_status 200 }
    end
  end
end
