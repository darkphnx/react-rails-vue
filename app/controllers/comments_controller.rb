class CommentsController < ApplicationController
  before_action :find_task

  def create
    @comment = @task.comments.build(safe_comment_params)

    respond_to do |wants|
      if @comment.save
        wants.json { render 'tasks/show', status: :created }
      else
        wants.json { render json: @comment.errors, status: :unprocessible_entity }
      end
    end
  end

  private

  def safe_comment_params
    params.require(:comment).permit(:body)
  end

  def find_task
    @task = Task.find(params[:task_id])
  end
end
