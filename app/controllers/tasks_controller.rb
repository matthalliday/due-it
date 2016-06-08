class TasksController < ApplicationController
  before_filter :require_login

  def index
    @projects = current_user.projects.order(name: :asc).includes(:tasks).where('tasks.status' => 'incomplete')
  end

  def show
    @project = current_user.projects.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
  end

  def new
    @project = current_user.projects.find(params[:project_id])
    @task = @project.tasks.build
  end

  def create
    @project = current_user.projects.find(params[:project_id])
    @task = @project.tasks.build(task_params)
    if @task.save
      Project.increment_counter(:incomplete_tasks, params[:project_id])
      redirect_to @project, :notice => "The task has been added to the project."
    else
      flash.now[:alert] = "Fix the errors below and try again."
      render :new
    end
  end

  def edit
    @project = current_user.projects.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
  end

  def update
    @project = current_user.projects.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to [@project, @task], :notice => "The task details have been updated."
    else
      flash.now[:alert] = "Fix the errors below and try again."
      render :edit
    end
  end

  def destroy
    @project = current_user.projects.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @task.destroy
    if @task.status == 'complete'
      Project.decrement_counter(:complete_tasks, params[:project_id])
    else
      Project.decrement_counter(:incomplete_tasks, params[:project_id])
    end
    redirect_to @project, :notice => "The task has been removed from the project."
  end

  def mark_complete
    @task = current_user.tasks.find(params[:id])
    @task.update_column(:status, 'complete')
    Project.increment_counter(:complete_tasks, params[:project_id])
    Project.decrement_counter(:incomplete_tasks, params[:project_id])
    redirect_to project_path(params[:project_id]), :notice => "The task has been marked as complete."
  end

  def mark_incomplete
    @task = current_user.tasks.find(params[:id])
    @task.update_column(:status, 'incomplete')
    Project.increment_counter(:incomplete_tasks, params[:project_id])
    Project.decrement_counter(:complete_tasks, params[:project_id])
    redirect_to project_path(params[:project_id]), :notice => "The task has been marked as incomplete."
  end

  def completed
    @project = current_user.projects.includes(:tasks).where('tasks.status' => 'complete').find(params[:project_id])
  end

  %w(due_today upcoming overdue).each do |due_window|
    define_method "#{due_window}" do
      @projects = []
      current_user.projects.each do |project|
        @projects.push(project) if project.tasks.incomplete.send(due_window).any?
      end
      @tasks = current_user.tasks.incomplete.send(due_window)
      @due_window = due_window
      render :due_window
    end
  end

  private

  def task_params
    params.require(:task).permit(:description, :due_date, :estimate, :name)
  end
end
