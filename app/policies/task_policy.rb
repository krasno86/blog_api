class TaskPolicy
  attr_reader :user, :task

  def initialize(user, task)
    @user = user
    @task = task
  end

  def destroy?
    task.user == user || user.role == 'admin'
  end
end
