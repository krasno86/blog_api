# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'articles' do
  path '/api/v1/articles' do
    post 'Creates a new article' do
      tags 'Articles'
      consumes 'application/json'
      parameter name: :article, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
              description: { type: :string },
              avatar: { type: :string }
          },
          required: %w[name description]
      }

      let(:signed_in_user) { create :user}

      response '201', 'article created' do
        let(:article) { { name: '1111', description: 'rswgwgefwag' } }

        run_test!
      end
    end
  end

  path '/api/v1/articles' do
    get 'Shows articles' do
      tags 'Articles'
      consumes 'application/json'

      let(:signed_in_user) { create :user}

      response '200', 'Articles founded' do
        before { create_list :article, 2, user: signed_in_user }
        run_test!
      end
    end
  end

  path '/api/v1/articles/{id}' do
    let(:signed_in_user) { create :user }
    let(:article)           { create :article, user: signed_in_user }

    get 'Show article' do
      tags 'Articles'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Article found' do
        let(:id) { article.id }
        run_test!
      end

      response '404', 'Article not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/articles/{id}' do
    let(:signed_in_user) { create :user }
    let(:article)        { create :article, user: signed_in_user }

    delete 'Delete article' do
      tags 'Articles'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '204', 'Articles destroyed' do
        let(:id) { article.id }
        run_test!
      end
    end
  end

  path '/api/v1/articles/{id}' do
    let(:signed_in_user) { create :user }
    let(:article)           { create :article, user: signed_in_user }

    put 'Update article' do
      tags 'Articles'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :article, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
              description: { type: :string },
              avatar: { type: :string }
          }
      }

      let(:signed_in_user) { create :user}

      response '200', 'group created' do
        let(:id) { article.id }
        let(:article2) { { name: '1111', description: 'rswgwgefwag' } }

        run_test!
      end
    end
  end
end
