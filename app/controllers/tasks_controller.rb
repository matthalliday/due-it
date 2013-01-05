class TasksController < ApplicationController
  before_filter :get_task, only: [:edit, :update, :destroy, :show]

  def index
    @tasks = Task.all
  end

  def show
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

  def edit
  end

  def update
    if @task.update_attributes(params[:task])
      redirect_to @task
      flash[:success] = "Nice going! The task was successfully updated."
    else
      flash[:error] = "Dang! Fix the errors below and try again."
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = "Congrats, bro! That task has been deleted."
    redirect_to root_path
  end

  private

  def get_task
    @task = Task.find(params[:id])
  end
end
