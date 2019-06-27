# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Tasks' do
  path '/api/v1/tasks' do
    post 'Creates a new task' do
      tags 'Tasks'
      consumes 'application/json'
      parameter name: :task, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
              description: { type: :string }
          },
          required: %w[name description]
      }

      let(:signed_in_user) { create :user}

      response '201', 'group created' do
        let(:task)          { { name: '1111', description: 'rswgwgefwag' } }

        run_test!
      end
    end
  end

  path '/api/v1/tasks' do
    get 'Shows tasks' do
      tags 'Tasks'
      consumes 'application/json'

      let(:signed_in_user) { create :user}

      response '200', 'group created' do
        before { create_list :task, 2, user: signed_in_user }
        run_test!
      end
    end
  end

  path '/api/v1/tasks/{id}' do
    let(:signed_in_user) { create :user }
    let(:task)           { create :task, user: signed_in_user }

    get 'Show a task' do
      tags 'Tasks'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Task founded' do
        let(:id) { task.id }
        run_test!
      end

      response '404', 'Group not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
