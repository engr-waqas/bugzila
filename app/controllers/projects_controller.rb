# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :find_project, except: %i[index new create]
  before_action :find_user, only: %i[add_user remove_user]
  before_action :authorize_project

  def index
    @projects = current_user.projects if current_user.manager?
    @projects = current_user.enrollments unless current_user.manager?
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      respond_to do |format|
        format.html { redirect_to projects_path, notice: 'Project Created Successfully!' }
        format.js
      end
    else
      render 'new', notice: 'Project Creation Unsuccessful!'
    end
  end

  def show
    @users = User.except_manager if current_user.manager?
    @users = @project.enrollments unless current_user.manager?
  end

  def edit; end

  def update
    if @project.update(project_params)
      redirect_to project_path, notice: 'Project Updated Successfully!'
    else
      render 'edit', notice: 'Project Updation Unsuccessful!'
    end
  end

  def destroy
    if @project.destroy
      respond_to do |format|
        redirect_to projects_path, notice: 'Project Deleted Successfully!'
        format.js
      end
    else
      redirect_to projects_path, notice: 'Project Deleted Unsuccessful!'
    end
  end

  def add_user
    @project.enrollments << @user
  end

  def remove_user
    @project.enrollments.destroy(@user)
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end

  def find_project
    @project = Project.find_by(id: params[:id])
    redirect_to projects_path, notice: 'Project not found!' if @project.nil?
  end

  def authorize_project
    if @project.present?
      authorize @project
    else
      authorize Project
    end
  end

  def find_user
    @user = User.find_by(id: params[:user_id])
    redirect_to projects_path, notice: 'User not found!' if @user.nil?
  end
end
