# frozen_string_literal: true

class Api::V1::TasksController < Api::V1::ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Serialize_object
  include Devise::Controllers::Helpers

  before_action :authenticate_api_v1_user!
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    @tasks = current_api_v1_user.tasks.all.order('created_at DESC')
    head(:not_found) if @tasks.nil?
    render json: TaskSerializer.new(@tasks).serialized_json, status: 200
  end

  def show
    render json: TaskSerializer.new(@task).serialized_json, status: 200
  end

  def create
    @task = current_api_v1_user.tasks.new(task_params)
    if @task.save!
      render json: serialized_object(@task), status: 201
    else
      render json: @task.errors.messages, status: 422
    end
  end

  def update
    if @task.update(task_params)
      render json: serialized_object(@task)
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @task.destroy
      head :no_content, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = current_api_v1_user.tasks.find_by(id: params[:id])
    head(:not_found) if @task.nil?
  end
end

