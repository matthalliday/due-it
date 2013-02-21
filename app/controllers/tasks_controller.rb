class TasksController < ApplicationController
  respond_to :html, :json, :xml

  def index
    @projects = Project.includes(:tasks).where('tasks.status = ?', 'incomplete').order('tasks.due_date ASC')
    respond_with Task.all
  end

  def show
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
  end

  def new
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(params[:task])
    if @task.save
      Project.increment_counter(:incomplete_tasks, params[:project_id])
      redirect_to @project, :notice => "The task has been added to the project."
    else
      flash.now[:alert] = "Fix the errors below and try again."
      render :new
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    if @task.update_attributes(params[:task])
      redirect_to @project, :notice => "The task details have been updated."
    else
      flash.now[:alert] = "Fix the errors below and try again."
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
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
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @task.update_attribute(:status, 'complete')
    Project.increment_counter(:complete_tasks, params[:project_id])
    Project.decrement_counter(:incomplete_tasks, params[:project_id])
    redirect_to @project, :notice => "The task has been marked as complete."
  end

  def mark_incomplete
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @task.update_attribute(:status, 'incomplete')
    Project.increment_counter(:incomplete_tasks, params[:project_id])
    Project.decrement_counter(:complete_tasks, params[:project_id])
    redirect_to @project, :notice => "The task has been marked as incomplete."
  end

  def completed
    @project = Project.includes(:tasks).where('tasks.status = ?', 'complete').find(params[:project_id])
  end

  %w(due_today due_this_week due_this_month overdue).each do |due_window|
    define_method "#{due_window}" do
      @projects = []
      Project.all.each do |project|
        @projects.push(project) if project.tasks.incomplete.send(due_window).any?
      end
      @tasks = Task.incomplete.send(due_window)
      @due_window = due_window
      render :due_window
    end
  end
end
