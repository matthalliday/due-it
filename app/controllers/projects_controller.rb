class ProjectsController < ApplicationController
  def index
    @projects = Project.order('name ASC')
    respond_to do |format|
      format.html
      format.json { render json: @projects }
    end
  end

  def show
    @project = Project.includes(:tasks).where('tasks.status = ?', 'incomplete').find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to @project
      flash[:success] = "The project has been created."
    else
      flash[:error] = "Fix the errors below and try again."
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project
      flash[:success] = "The project details have been updated."
    else
      flash[:error] = "Fix the errors below and try again."
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:success] = "The project has been removed."
    redirect_to root_path
  end
end
