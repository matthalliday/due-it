class TasksController < ApplicationController
  before_filter :get_project, only: [:show, :new, :create, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
    @task = @project.tasks.find(params[:id])
  end

  def new
    @task = @project.tasks.build
  end

  def create
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
    @task = @project.tasks.find(params[:id])
  end

  def update
    @task = @project.tasks.find(params[:id])
    if @task.update_attributes(params[:task])
      redirect_to [@project, @task]
      flash[:success] = "Nice going! The task was successfully updated."
    else
      flash[:error] = "Dang! Fix the errors below and try again."
      render :edit
    end
  end

  def destroy
    @task = @project.tasks.find(params[:id])
    @task.destroy
    flash[:success] = "Congrats, bro! That task has been deleted."
    redirect_to @project
  end

  # TODO refactor methods using define_method
  def this_week
    @tasks = Task.due_this_week
  end

  def next_week
    @tasks = Task.due_next_week
  end

  def this_month
    @tasks = Task.due_this_month
  end

  private

  def get_project
    @project = Project.find(params[:project_id])
  end
end
