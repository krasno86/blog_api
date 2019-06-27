# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'db column' do
    it { expect have_db_column(:description).of_type(:string) }
  end

  context 'basic validation presence_of and uniq' do
    it { expect validate_presence_of(:description) }
  end

  describe 'validation' do
    let(:user) { create :user }
    let(:task) { create :task, description: 'bla bla', user: user }
    let(:invalid_task1) { build :task, user: nil }
    let(:invalid_task2) { build :task, description: '' }


    it { expect(task).to be_valid }
    it { expect(invalid_task1).to be_invalid}
    it { expect(invalid_task2).to be_invalid }
  end

  context "#to_json" do
    let(:user)    { create :user }
    let(:task) { create :task, name: '1', description: 'bla bla', user: user }

    it "includes name and description" do
      task_params = %({"name": "1", "description": "bla bla"})
      expect(task.to_json).to be_json_eql(task_params).excluding("user_id")
    end

    it "includes the ID" do
      expect(task.to_json).to have_json_path("id")
      expect(task.to_json).to have_json_type(Integer).at_path("id")
    end
  end
end
