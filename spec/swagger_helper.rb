require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.to_s + '/swagger'
  config.swagger_docs = {
    'v1/swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {}
    }
  }

  config.after do |example|
    if example.metadata[:response].present? && response.body.present?
      example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
    end
  end

  # config.include_context 'token auth'
end
