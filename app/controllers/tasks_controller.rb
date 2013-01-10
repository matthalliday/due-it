class TasksController < ApplicationController
  before_filter :get_project, except: [:index, :due_this_week, :due_next_week, :due_this_month, :overdue]
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
    redirect_to @project
    flash[:success] = "Congrats, bro! That task has been deleted."
  end

  def complete
    @task.status = 'complete'
    @task.save
    redirect_to @project
    flash[:success] = "High five, bro! You just completed a task."
  end

  def completed
    @tasks = @project.tasks.complete
  end

  %w(due_this_week due_next_week due_this_month overdue).each do |due_window|
    define_method "#{due_window}" do
      @tasks = Task.incomplete.send(due_window)
      @due_window = due_window.humanize
      render :due_window
    end
  end

  private

  def get_project
    @project = Project.find(params[:project_id])
  end

  def get_task
    @task = @project.tasks.find(params[:id])
  end
end
