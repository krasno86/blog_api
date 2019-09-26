# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  context 'db column' do
    it { expect have_db_column(:name).of_type(:string) }
    it { expect have_db_column(:description).of_type(:string) }
    it { expect have_db_column(:avatar).of_type(:string) }
  end

  context 'basic validation presence_of' do
    it { expect validate_presence_of(:name) }
    it { expect validate_presence_of(:description) }
  end

  describe 'validation' do
    let(:user) { create :user }
    let(:article) { create :article, description: 'bla bla', user: user }
    let(:invalid_article1) { build :article, user: nil }
    let(:invalid_article2) { build :article, description: '' }


    it { expect(article).to be_valid }
    it { expect(invalid_article1).to be_invalid}
    it { expect(invalid_article2).to be_invalid }
  end

  context '#to_json' do
    let(:user)    { create :user }
    let(:article) { create :article, name: '1', description: 'bla bla', user: user }

    it 'includes name and description' do
      article_params = '{"name": "1", "description": "bla bla", "avatar": {"thumb": {"url": null},"url": null}}'
      expect(article.to_json).to be_json_eql(article_params).excluding('user_id')
    end

    it 'includes the ID' do
      expect(article.to_json).to have_json_path('id')
      expect(article.to_json).to have_json_type(Integer).at_path('id')
    end
  end
end