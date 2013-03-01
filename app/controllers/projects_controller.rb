class ProjectsController < ApplicationController
  before_filter :require_login
  respond_to :html, :json, :xml

  def index
    @projects = current_user.projects
    respond_with @projects
  end

  def show
    @project = current_user.projects.find(params[:id])
    @tasks = @project.tasks.incomplete
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(params[:project])
    if @project.save
      redirect_to @project, :notice => "The project has been created."
    else
      flash.now[:alert] = "Fix the errors below and try again."
      render :new
    end
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def update
    @project = current_user.projects.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project, :notice => "The project details have been updated."
    else
      flash.now[:alert] = "Fix the errors below and try again."
      render :edit
    end
  end

  def destroy
    @project = current_user.projects.find(params[:id])
    @project.destroy
    redirect_to root_path, :notice => "The project has been removed."
  end
end
