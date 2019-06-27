require 'rails_helper'

describe TaskPolicy do
  subject { TaskPolicy.new(user, task) }

  context 'being an owner of task' do
    let(:user) { create(:user) }
    let(:task)  { create(:task, user: user) }

    it { is_expected.to permit_actions([:index, :show, :update, :destroy, :create]) }
  end
end
