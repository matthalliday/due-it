class TasksController < ApplicationController
  # OPTIMIZE possibly move @project into before_filter

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(params[:task])
    if @task.save
      redirect_to @project
      flash[:success] = "Woo hoo! The task was successfully created."
    else
      flash[:error] = "Dang! Fix the errors below and try again."
      render :new
    end
  end

  def edit
    # FIXME make sure project_id is being passed
    @task = Task.find(params[:id])
  end

  def update
    # FIXME make sure project_id is being passed
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      redirect_to @task
      flash[:success] = "Nice going! The task was successfully updated."
    else
      flash[:error] = "Dang! Fix the errors below and try again."
      render :edit
    end
  end

  def destroy
    # TODO make sure project_id is being passed
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = "Congrats, bro! That task has been deleted."
    redirect_to root_path
  end
end
