class ProjectsController < ApplicationController
  respond_to :html, :json, :xml

  def index
    @projects = Project.all
    respond_with @projects
  end

  def show
    @project = Project.find(params[:id])
    @tasks = @project.tasks.incomplete
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to @project, :notice => "The project has been created."
    else
      flash.now[:alert] = "Fix the errors below and try again."
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project, :notice => "The project details have been updated."
    else
      flash.now[:alert] = "Fix the errors below and try again."
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy, :notice => "The project has been removed."
    redirect_to root_path
  end
end
