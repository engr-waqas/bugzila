# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :find_project, except: %i[index new create]
  before_action :find_user, only: %i[add_user remove_user]
  before_action :authorize_project, only: %i[edit show update destroy add_user remove_user]

  def index
    @projects = current_user.projects if current_user.manager?
    @projects = current_user.enrollments unless current_user.manager?
  end

  def show
    @users = Project.users_except_manager if current_user.manager?
    @users = @project.enrollments unless current_user.manager?
  end

  def edit; end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.new(project_params)
    authorize_project
    if @project.save
      redirect_to projects_path, notice: 'Project Created Successfully.'
    else
      render 'new', notice: 'Project Creation Unsuccessful.'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to project_path, notice: 'Project Updated Successfully.'
    else
      render 'edit', notice: 'Project Updation Unsuccessful.'
    end
  end

  def destroy
    if @project.destroy
      redirect_to projects_path, notice: 'Project Deleted Successfully.'
    else
      redirect_to projects_path, notice: 'Project Deleted Unsuccessful.'
    end
  end

  def add_user
    if @project.enrollments << @user
      redirect_to project_path, notice: 'User added successfully to project.'
    else
      redirect_to project_path, notice: "User Can't be added to project."
    end
  end

  def remove_user
    if @project.enrollments.destroy(@user)
      redirect_to project_path, notice: 'User removed successfully from project.'
    else
      redirect_to project_path, notice: 'User removal unsuccessful.'
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end

  def find_project
    @project = Project.find_by(id: params[:id])
  end

  def authorize_project
    authorize @project
  end

  def find_user
    @user = User.find_by(id: params[:user_id])
  end
end
