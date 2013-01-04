class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      redirect_to @task
      flash[:success] = "Woo hoo! The task was successfully created."
    else
      flash[:error] = "Dang! Fix the errors below and try again."
      render :new
    end
  end
end
