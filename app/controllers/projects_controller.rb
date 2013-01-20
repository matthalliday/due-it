class ProjectsController < ApplicationController
  before_filter :get_project, except: [:index, :new, :create]

  def index
    @projects = Project.all
  end

  def show
    @incomplete = @project.tasks.incomplete
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to @project
      flash[:success] = "Woo hoo! The project was successfully created."
    else
      flash[:error] = "Dang! Fix the errors below and try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update_attributes(params[:project])
      redirect_to @project
      flash[:success] = "Nice going! The project was successfully updated."
    else
      flash[:error] = "Dang! Fix the errors below and try again."
      render :edit
    end
  end

  def destroy
    @project.destroy
    flash[:success] = "Congrats, bro! That project has been deleted."
    redirect_to root_path
  end

  private

  def get_project
    @project = Project.find(params[:id])
  end
end
