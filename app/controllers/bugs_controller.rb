# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :set_bug, except: %i[new index create]
  before_action :set_project, except: %i[update destroy]
  after_action :verify_authorized, except: [], unless: :devise_controller?

  def index
    authorize @bugs = @project.bugs
  end

  def show; end

  def new
    authorize @bug = Bug.new(project: @project)
  end

  def create
    authorize @bug = current_user.bugs.create(bug_params)
    @bug.project = set_project
    if @bug.save
      redirect_to project_bugs_path
    else
      render 'new'
    end
  end

  def update
    if set_bug.update(bug_params)
      redirect_to project_bugs_path
    else
      render 'edit'
    end
  end

  def destroy
    authorize set_bug.destroy
    redirect_to project_bugs_path
  end

  def assign
    @user = User.find(params[:user_id])
    if set_bug.update(developer_id: @user.id, status: :started)
      redirect_to project_bugs_path(@project)
    else
      redirect_to project_bugs_path(@project), notice: 'Not success'
    end
  end

  def change_status
    if set_bug.update(status: :resolved)
      redirect_to project_bugs_path(@project)
    else
      redirect_to project_bugs_path(@project), notice: 'Not Success'
    end
  end

  private

  def set_bug
    authorize @bug = Bug.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :bug_type, :status, :screenshot)
  end
end
