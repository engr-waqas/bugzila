# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, except: %i[index new create]

  def index
    @projects = policy_scope(Project)
    authorize Project
  end

  def show
    @developers = Developer.all
    @qas = Qa.all
    authorize @project
  end

  def new
    @project = current_user.projects.new
    authorize @project
  end

  def edit
    authorize @project
  end

  def create
    @project = current_user.projects.new(project_params)
    authorize @project
    if @project.save
      redirect_to @project
    else
      render 'new'
    end
  end

  def update
    authorize @project
    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    authorize @project
    @project.destroy
    redirect_to projects_url
  end

  def add_user
    @project = Project.find(params[:id])
    @user = User.find(params[:user_id])
    authorize @project
    if @project.users << @user
      redirect_to @project
    else
      redirect_to @project, notice: "User Can't be added to project. "
    end
  end

  def remove_user
    @project = Project.find(params[:id])
    @user = User.find(params[:user_id])
    authorize @project
    @project.users.delete(@user)
    redirect_to @project
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
