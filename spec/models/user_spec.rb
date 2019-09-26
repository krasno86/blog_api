# frozen_string_literal: true

require 'rails_helper'
include Serialize_object

RSpec.describe User, type: :model do
  context 'model associations' do
    it { expect have_many(:articles) }
  end

  context 'db column' do
    it { expect have_db_column(:email).of_type(:string) }
    it { expect have_db_column(:uid).of_type(:string) }
  end

  describe 'validation' do
    let(:user)         { build(:user) }
    let(:invalid_user) { build(:user, email: 'sd') }

    it { expect(user).to be_valid }
    it { expect(invalid_user).not_to be_valid }
  end

  context '#to_json' do
    let(:user)    { create(:user, email: '1@gmail.com') }

    it 'includes email' do
      data = '{"email":"1@gmail.com","allow_password_change": false,"provider": "email","uid": "1@gmail.com"}'
      expect(user.to_json).to be_json_eql(data).excluding('email')
    end

    it 'includes the ID' do
      expect(user.to_json).to have_json_path('id')
      expect(user.to_json).to have_json_type(Integer).at_path('id')
    end

    it 'includes the email' do
      expect(user.to_json).to have_json_path('email')
      expect(user.to_json).to have_json_type(String).at_path('email')
    end
  end
end
