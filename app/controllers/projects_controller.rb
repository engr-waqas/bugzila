# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, except: %i[index new create]
  after_action :verify_authorized, unless: :devise_controller?

  def index
    @projects = policy_scope(Project)
    authorize Project
  end

  def show
    @developers = Developer.all
    @qas = Qa.all
    authorize set_project
  end

  def new
    @project = current_user.projects.new
    authorize @project
  end

  def edit
    authorize set_project
  end

  def create
    set_project = current_user.projects.new(project_params)
    authorize set_project
    if set_project.save
      redirect_to set_project
    else
      render 'new'
    end
  end

  def update
    authorize set_project
    if set_project.update(project_params)
      redirect_to set_project
    else
      render 'edit'
    end
  end

  def destroy
    authorize set_project
    set_project.destroy
    redirect_to projects_url
  end

  def add_user
    @user = User.find(params[:user_id])
    authorize set_project
    if set_project.users << @user
      redirect_to set_project
    else
      redirect_to set_project, notice: "User Can't be added to project. "
    end
  end

  def remove_user
    @user = User.find(params[:user_id])
    authorize set_project
    set_project.users.delete(@user)
    redirect_to set_project
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
