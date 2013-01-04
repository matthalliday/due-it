class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      redirect_to @task
    else
      render action: :new
    end
  end
  
  def new
    @task = Task.new
  end
end
