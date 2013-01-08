class TasksController < ApplicationController
  before_filter :get_project, except: [:index, :this_week, :next_week, :this_month]
  before_filter :get_task, only: [:show, :edit, :update, :destroy, :complete]

  def index
    @projects = Project.all
  end

  def show
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
  end

  def update
    if @task.update_attributes(params[:task])
      redirect_to [@project, @task]
      flash[:success] = "Nice going! The task was successfully updated."
    else
      flash[:error] = "Dang! Fix the errors below and try again."
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = "Congrats, bro! That task has been deleted."
    redirect_to @project
  end

  def complete
    @task.status = 'complete'
    @task.save
    redirect_to [@project, @task]
    flash[:success] = "High five, bro! You just completed a task."
  end

  # TODO refactor methods using define_method
  def this_week
    @tasks = Task.this_week
  end

  def next_week
    @tasks = Task.next_week
  end

  def this_month
    @tasks = Task.this_month
  end

  private

  def get_project
    @project = Project.find(params[:project_id])
  end

  def get_task
    @task = @project.tasks.find(params[:id])
  end
end
