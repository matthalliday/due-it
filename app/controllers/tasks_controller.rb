class TasksController < ApplicationController
  def index
    @projects = []
    Project.all.each do |project|
      @projects.push(project) if project.tasks.incomplete.any?
    end

    respond_to do |format|
      format.html
      format.json { render json: Task.all }
    end
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
      redirect_to @project
      flash[:success] = "Woo hoo! The task was successfully created."
    else
      flash[:error] = "Dang! Fix the errors below and try again."
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
      redirect_to [@project, @task]
      flash[:success] = "Nice going! The task was successfully updated."
    else
      flash[:error] = "Dang! Fix the errors below and try again."
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
    redirect_to @project
    flash[:success] = "Congrats, bro! That task has been deleted."
  end

  def mark_complete
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @task.status = 'complete'
    @task.save
    Project.increment_counter(:complete_tasks, params[:project_id])
    Project.decrement_counter(:incomplete_tasks, params[:project_id])
    redirect_to @project
    flash[:success] = "High five, bro! You just completed a task."
  end

  def mark_incomplete
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @task.status = 'incomplete'
    @task.save
    Project.increment_counter(:incomplete_tasks, params[:project_id])
    Project.decrement_counter(:complete_tasks, params[:project_id])
    redirect_to @project
    flash[:success] = "Nice going! The task was successfully updated."
  end

  def completed
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks.complete
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
