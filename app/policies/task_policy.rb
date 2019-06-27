class TaskPolicy
  attr_reader :user, :task

  def initialize(user, task)
    @user = user
    @task = task
  end

  def index?
    task.user == user
  end

  def show?
    task.user == user
  end

  def create?
    task.user == user
  end

  def update?
    task.user == user
  end

  def destroy?
    task.user == user
  end
end
