require 'rails_helper'

RSpec.describe Article, type: :request do
  let(:user) { create :user }
  let(:article)  { create :article, user: user }

  describe 'get index' do
    context 'unauthorized user' do
      before { get '/api/v1/articles' }
      it { expect(response).to have_http_status 401 }
    end

    context 'authorized user to index' do
      before do
        2.times {create(:article, user: user) }
        get '/api/v1/articles', headers: user.create_new_auth_token
      end
      it { expect(response).to have_http_status 200 }
      it 'show article' do
        expect(json['data'].length).to eq 2
        expect(json['data'][1]['attributes'].keys).to contain_exactly(*%w[description name])
      end
    end

    context 'get show' do
      before do
        get "/api/v1/articles/#{article.id}",
             headers: user.create_new_auth_token
      end
      it { expect(response).to have_http_status 200 }
      it 'show article' do
        expect(json).to match_response_schema("article")
      end
    end

    context 'create' do
      before do
        post '/api/v1/articles',
             params: {article: {name: '1', description: 'description'}},
             headers: user.create_new_auth_token
      end
      it { expect(response).to have_http_status 201 }
    end

    context 'DELETE' do
      before do
        delete "/api/v1/articles/#{article.id}",
               headers: user.create_new_auth_token
      end
      it { expect(response).to have_http_status 204 }
    end

    context 'update' do
      before do
        put "/api/v1/articles/#{article.id}",
            params: {article: {name: Faker::StarWars.droid}}, headers: user.create_new_auth_token
      end
      it { expect(response).to have_http_status 200 }
    end
  end
end
