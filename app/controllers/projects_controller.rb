# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, except: %i[index new create]
  before_action :set_user, only: %i[add_user remove_user]
  after_action :verify_authorized, except: %i[index new], unless: :devise_controller?

  def index
    @projects = current_user.projects if current_user.manager?
    @projects = current_user.enrollments unless current_user.manager?
  end

  def show
    @users = @project.enrollments
  end

  def new
    @project = current_user.projects.new
  end

  def create
    authorize @project = current_user.projects.create(project_params)
    if @project.save
      redirect_to projects_path, notice: 'Project Created Successfully.'
    else
      render 'new'
    end
  end

  def update
    if set_project.update(project_params)
      redirect_to projects_path, notice: 'Project Updated Successfully.'
    else
      render 'edit'
    end
  end

  def destroy
    set_project.destroy
    redirect_to projects_path, notice: 'Project Deleted Successfully.'
  end

  def add_user
    if set_project.enrollments << set_user
      redirect_to project_path
    else
      redirect_to project_path, notice: "User Can't be added to project. "
    end
  end

  def remove_user
    set_project.enrollments.destroy(set_user)
    redirect_to project_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end

  def set_project
    @project = Project.find(params[:id])
    authorize @project
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
