require 'rails_helper'

RSpec.describe Task, type: :request do
  let(:user) { create :user }
  let(:task)  { create :task, user: user }

  describe 'get index' do
    context 'unauthorized user' do
      before { get "/api/v1/tasks" }
      it { expect(response).to have_http_status 401 }
    end

    context 'authorized user to index' do
      before {
        2.times {create(:task, user: user) }
        get '/api/v1/tasks', headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 200 }
      it 'show task' do
        expect(json['data'].length).to eq 2
        expect(json['data'][1]['attributes'].keys).to contain_exactly(*%w[description name])
      end
    end

    context 'get show' do
      before {
        get "/api/v1/tasks/#{task.id}",
             headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 200 }
      it 'show task' do
        expect(json).to match_response_schema("task")
      end
    end

    context 'create' do
      before {
        post '/api/v1/tasks',
             params: { task: { name: '1', description: 'description' } },
             headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 201 }
    end

    context 'DELETE' do
      before {
        delete "/api/v1/tasks/#{task.id}",
               headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 204 }
    end

    context 'update' do
      before {
        put "/api/v1/tasks/#{task.id}",
            params: {task: {name: Faker::StarWars.droid} }, headers: user.create_new_auth_token
      }
      it { expect(response).to have_http_status 200 }
    end
  end
end
