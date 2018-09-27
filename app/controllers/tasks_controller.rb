class TasksController < ApplicationController
  before_action :find_task

  def index
    @tasks = Task.desc
  end

  def create
    @task = Task.build(safe_task_params)

    respond_to do |wants|
      if @task.save
        wants.json { render :show, status: :created }
      else
        wants.json { render json: @task.errors, status: :unprocessible_entity }
      end
    end
  end

  def update
    respond_to do |wants|
      if @task.update(safe_task_params)
        wants.json { render :show }
      else
        wants.json { render json: @task.errors, status: :unprocessible_entity }
      end
    end
  end

  def destroy
    respond_to do |wants|
      if @task.destroy
        wants.json { render :show }
      else
        wants.json { render json: @task.errors, status: :unprocessible_entity }
      end
    end
  end

  private

  def find_task
    @task = Task.find(params[:id]) if params[:id]
  end

  def safe_task_params
    params.require(:task).permit(:title, :tags_list)
  end
end
